FROM		ubuntu
MAINTAINER	Nicholas Johns "nicholas.a.johns5@gmail.com"

#Force updating ubuntu
RUN		echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN 		apt-get update; apt-get upgrade -y; apt-get install -y wget

#Add nginx certificate and sources
RUN		wget -qO - http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN 		echo "deb http://nginx.org/packages/mainline/ubuntu/ precise nginx" > /etc/apt/sources.list.d/nginx.list

#Install nginx
RUN		apt-get update; apt-get install -y nginx

#Replace existing nginx configuration with this one
RUN		mv /etc/nginx /etc/nginx_pre_git
ADD		. /etc/nginx

RUN		echo "daemon off;" >> /etc/nginx/nginx.conf

#Attach volume
VOLUME		/srv

#Expose port 80, can be changed if we put a proxy in front of docker
EXPOSE		80

#Run the things!
ENTRYPOINT	["/usr/sbin/nginx"]

CMD		["-p /etc/nginx"]
