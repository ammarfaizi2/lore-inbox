Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268717AbUJEAad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268717AbUJEAad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUJEAad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:30:33 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:45193 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268717AbUJEAab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:30:31 -0400
Date: Tue, 5 Oct 2004 02:28:14 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2.6.9-rc3] Fix 'htmldocs' and friends with O=
Message-ID: <20041005002814.GA32087@thundrix.ch>
References: <20041004233958.GD32692@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20041004233958.GD32692@smtp.west.cox.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Mon, Oct 04, 2004 at 04:39:58PM -0700, Tom Rini wrote:
> --- linux-2.6.9-rc3.orig/scripts/kernel-doc
> +++ linux-2.6.9-rc3/scripts/kernel-doc
> @@ -1531,7 +1531,7 @@ sub process_state3_type($$) {=20
>  }
> =20
>  sub process_file($) {
> -    my ($file) =3D @_;
> +    my ($file) =3D "$ENV{'SRCTREE'}@_";
>      my $identifier;
>      my $func;
>      my $initial_section_counter =3D $section_counter;

=46rom performance/memory footprint standpoint it might be better to use
the dot operator here for concatenation.

			Tonnerre

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBYeqd/4bL7ovhw40RAuzAAJ0QGqJbm7hGnxea3nVmbIZAFWaKtgCeOOP4
7DaSLlubTcEYN1//kdnu0ls=
=D7B5
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
