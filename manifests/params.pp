# == Class: sahara::params
#
# Parameters for puppet-sahara
#
class sahara::params {
  include ::openstacklib::defaults

  if $::os_package_type == 'debian' or $::os['name'] == 'Fedora' or
    ($::os['family'] == 'RedHat' and Integer.new($::os['release']['major']) > 7){
    $pyvers = '3'
  } else {
    $pyvers = ''
  }
  $client_package_name = "python${pyvers}-saharaclient"
  $group               = 'sahara'

  case $::osfamily {
    'RedHat': {
      $common_package_name       = 'openstack-sahara-common'
      $all_package_name          = 'openstack-sahara'
      $api_package_name          = 'openstack-sahara-api'
      $engine_package_name       = 'openstack-sahara-engine'
      $all_service_name          = 'openstack-sahara-all'
      $api_service_name          = 'openstack-sahara-api'
      $engine_service_name       = 'openstack-sahara-engine'
      $sahara_wsgi_script_path   = '/var/www/cgi-bin/sahara'
      $sahara_wsgi_script_source = '/usr/bin/sahara-wsgi-api'
    }
    'Debian': {
      $common_package_name       = 'sahara-common'
      $all_package_name          = 'sahara'
      $api_package_name          = 'sahara-api'
      $engine_package_name       = 'sahara-engine'
      $all_service_name          = 'sahara'
      $api_service_name          = 'sahara-api'
      $engine_service_name       = 'sahara-engine'
      $sahara_wsgi_script_path   = '/usr/lib/cgi-bin/sahara'
      $sahara_wsgi_script_source = '/usr/bin/sahara-wsgi-api'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}")
    }
  }
}
