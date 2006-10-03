Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWJCMX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWJCMX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWJCMXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:23:25 -0400
Received: from hentges.net ([81.169.178.128]:11139 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1750772AbWJCMXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:23:25 -0400
Subject: Re: PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved with
	2.6.18 kernel
From: Matthias Hentges <oe@hentges.net>
To: Wink Saville <wink@saville.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4521E326.2000406@saville.com>
References: <45206777.7020405@saville.com> <1159808447.4652.6.camel@mhcln03>
	 <4521E326.2000406@saville.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wFTNKGfVUaaimvroLIwd"
Date: Tue, 03 Oct 2006 14:23:22 +0200
Message-Id: <1159878202.4652.10.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wFTNKGfVUaaimvroLIwd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Wink,

Am Montag, den 02.10.2006, 21:12 -0700 schrieb Wink Saville:
> Matthias,
>=20
> Thanks, I tried your config file on 2.6.18 and it works!
>=20
> The first time I tried my command line was:
>=20
> Command line: root=3D/dev/sda2 ro quiet splash initcall_debug=20
> console=3DttyS0,115200n8 loglevel=3D7 video=3Dnvidiafb:nomtrr
>=20
> and it came up but no keyboard or mouse, I changed it too:
>=20
> Command line: root=3D/dev/sda2 ro quiet splash
>=20
> You mentioned you "saw some hangs", I assume with the current=20
> configuration your having no problems with stability?
>=20

correct. These hangs at boot-time were all related to the nvidia FB
driver. The current config with 2.6.18-mm1 is rock-stable for me ( the
box is running 24/7 ).

I was seeing randon freezes w/ 2.6.18-mm2 for which I could not identify
the cause.

--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-wFTNKGfVUaaimvroLIwd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFIlY6Aq2P5eLUP5IRAnhfAJ9jN//JjIYUlyZiujfYMP90QOu5QQCglT6j
LM8QNvlnRVxJp9I1KqSGPmQ=
=ZlQn
-----END PGP SIGNATURE-----

--=-wFTNKGfVUaaimvroLIwd--

