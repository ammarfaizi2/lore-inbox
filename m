Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267721AbTCFD2g>; Wed, 5 Mar 2003 22:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbTCFD2f>; Wed, 5 Mar 2003 22:28:35 -0500
Received: from B5142.pppool.de ([213.7.81.66]:26293 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S267721AbTCFD2e>; Wed, 5 Mar 2003 22:28:34 -0500
Subject: Re: Kernel bloat 2.4 vs. 2.5
From: Daniel Egger <degger@fhm.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030304154105.7a2db7fa.akpm@digeo.com>
References: <1046817738.4754.33.camel@sonja>
	 <20030304154105.7a2db7fa.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q/DVWaNDfiA0WsEdoT3H"
Organization: 
Message-Id: <1046921111.484.10.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Mar 2003 04:25:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q/DVWaNDfiA0WsEdoT3H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mit, 2003-03-05 um 00.41 schrieb Andrew Morton:

> Please specify the compiler which was used, and use /usr/bin/size to repo=
rt
> image sizes.

The compiler was in both cases:
gcc version 3.2.3 20030228 (Debian prerelease)

2.4.20:

2271565 Feb 25 17:08 vmlinux

   text    data     bss     dec     hex filename
1730302  112564  176676 2019542  1ed0d6 vmlinux

2.5.63:

2561828 Mar  4 16:50 vmlinux

   text    data     bss     dec     hex filename
1867787  167450  140292 2175529  213229 vmlinux


As I said, the 2.4 kernel has almost everything built in while 2.5 was
stripped down to minimum size possible. The latter is still unusable
since modules do not work. :/

--=20
Servus,
       Daniel

--=-Q/DVWaNDfiA0WsEdoT3H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Zr+Xchlzsq9KoIYRAhP3AJ0eIVjCjE5sVbGsp4xUaf7OxmiPXQCdHoNv
LZXayCvr6JI64hMCbp7wAxA=
=XV8j
-----END PGP SIGNATURE-----

--=-Q/DVWaNDfiA0WsEdoT3H--

