Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUIASsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUIASsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUIASsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:48:15 -0400
Received: from devel.lbsd.net ([196.25.111.100]:54403 "EHLO web.linuxrulz.org")
	by vger.kernel.org with ESMTP id S267410AbUIASsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:48:10 -0400
Date: Wed, 1 Sep 2004 20:47:41 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] DVD+RW support for 2.6.7-bk13
Message-ID: <20040901184741.GQ10151@lbsd.net>
References: <m2hdsr6du0.fsf@telia.com> <m34qmhest1.fsf@telia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+wSiqF7c0ySQ2tNi"
Content-Disposition: inline
In-Reply-To: <m34qmhest1.fsf@telia.com>
User-Agent: Mutt/1.4.2.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+wSiqF7c0ySQ2tNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Nigel pointed out that the earlier patches contained attributions that
> are not present in this patch. The 2.4 patch contains:
>=20
>   Nov 5 2001, Aug 8 2002. Modified by Andy Polyakov
>   <appro@fy.chalmers.se> to support MMC-3 complaint DVD+RW units.
>=20
> and Nigel changed it to this in his 2.6 patch:
>=20
>   Modified by Nigel Kukard <nkukard@lbsd.net> - support DVD+RW
>   2.4.x patch by Andy Polyakov <appro@fy.chalmers.se>
>=20
> The patch I sent you deleted most of the earlier work and moved the
> rest to cdrom.c, but the comments were not moved over, since the
> earlier authors didn't modify cdrom.c.
>=20
> Nigel wants to get credit for his work though, so were should we put
> those messages? Is this patch acceptable?
>=20

Thanks Peter  ;-)=20


Andy wrote the support for 2.4, I basically ported it to 2.6. Make sure
you included aswell though, your help is greatly appreciated!

Everyone, enjoy your day!

-Nigel


>=20
>  linux-petero/drivers/cdrom/cdrom.c |    6 ++++++
>  1 files changed, 6 insertions(+)
>=20
> diff -puN drivers/cdrom/cdrom.c~packet-copyright drivers/cdrom/cdrom.c
> --- linux/drivers/cdrom/cdrom.c~packet-copyright	2004-09-01 20:03:13.0753=
94816 +0200
> +++ linux-petero/drivers/cdrom/cdrom.c	2004-09-01 20:31:57.282275528 +0200
> @@ -234,6 +234,12 @@
>    -- Mt Rainier support
>    -- DVD-RAM write open fixes
> =20
> +  Nov 5 2001, Aug 8 2002. Modified by Andy Polyakov
> +  <appro@fy.chalmers.se> to support MMC-3 compliant DVD+RW units.
> +
> +  Modified by Nigel Kukard <nkukard@lbsd.net> - support DVD+RW
> +  2.4.x patch by Andy Polyakov <appro@fy.chalmers.se>
> +
>  ------------------------------------------------------------------------=
-*/
> =20
>  #define REVISION "Revision: 3.20"
> _

--+wSiqF7c0ySQ2tNi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBNhlNKoUGSidwLE4RAi9ZAJ9/y4yUzgSRh23gSd6+PzGc5SddvQCbBj5d
iKBriW/wC9DTDgigUkCA2Ho=
=+P3t
-----END PGP SIGNATURE-----

--+wSiqF7c0ySQ2tNi--
