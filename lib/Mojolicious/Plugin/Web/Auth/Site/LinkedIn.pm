use strict;
use warnings;

package Mojolicious::Plugin::Web::Auth::Site::LinkedIn;

use Mojo::Base qw/Mojolicious::Plugin::Web::Auth::OAuth2/;

has access_token_url => 'https://www.linkedin.com/oauth/v2/accessToken';
has authorize_url    => 'https://www.linkedin.com/oauth/v2/authorization';
has response_type    => 'code';
has scope            => 'r_liteprofile r_emailaddress';
has user_info        => 1;
has user_info_url    => 'https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))';
has user_more_info_url => 'https://api.linkedin.com/v2/me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))';
has authorize_header => 'Bearer';

sub moniker {'linkedin'}

1;
__END__

# ABSTRACT: LinkedIn OAuth Plugin for Mojolicious::Plugin::Web::Auth

=pod

=head1 SYNOPSIS

    # Mojolicious
    $self->plugin('Web::Auth',
        module      => 'LinkedIn',
        key         => 'LinkedIn consumer key',
        secret      => 'LinkedIn consumer secret',
        on_finished => sub {
            my ( $c, $access_token, $email_info ) = @_;
            ...
        },
        on_error => sub {
            my ( $c, $error ) = @_;
            ...
        },
    );

    # Mojolicious::Lite
    plugin 'Web::Auth',
        module      => 'LinkedIn',
        key         => 'LinkedIn consumer key',
        secret      => 'LinkedIn consumer secret',
        on_finished => sub {
            my ( $c, $access_token, $email_info ) = @_;
            ...
        };


    # default authentication endpoint: /auth/linkedin/authenticate
    # default callback endpoint: /auth/linkedin/callback

=head1 DESCRIPTION

This module adds L<LinkedIn|https://developer.linkedin.com/docs/rest-api/> support to
L<Mojolicious::Plugin::Web::Auth>.

The only extra URL option is the C<user_more_info_url> which the user can use to do a L<Mojo::UserAgent> call to with the access token as a parameter, to get the other info such as profile image and first or last name. This URL can also be modified by the user to retrieve extra fields. For more details refer to the L<LinkedIn API|https://developer.linkedin.com/docs/rest-api/>.

=cut
