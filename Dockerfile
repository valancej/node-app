FROM registry.access.redhat.com/ubi7/python-36:latest
USER root
LABEL maintainer="Jeremy Valance"
# Update image
RUN yum update --disableplugin=subscription-manager -y && rm -rf /var/cache/yum
RUN yum install --disableplugin=subscription-manager httpd -y && rm -rf /var/cache/yum
#COPY
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt

# Add default Web page and expose port
RUN echo "The Web Server is Running" > /var/www/html/index.html
EXPOSE 80 22
# Start the service
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
