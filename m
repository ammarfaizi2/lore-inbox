Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSFDOWJ>; Tue, 4 Jun 2002 10:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSFDOWI>; Tue, 4 Jun 2002 10:22:08 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:16 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S311871AbSFDOWH>;
	Tue, 4 Jun 2002 10:22:07 -0400
Date: Tue, 4 Jun 2002 16:22:07 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
Message-ID: <20020604142207.GN20788@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <000a01c20bc5$b0681830$010b10ac@sbp.uptime.at> <000001c20bd1$0cad7580$010b10ac@sbp.uptime.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/Q3JWIUAuLE0ZFy"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-06-04 16:06:35 +0200, Oliver Pitzeier <o.pitzeier@uptime.at>
wrote in message <000001c20bd1$0cad7580$010b10ac@sbp.uptime.at>:
> Ok. Kernel compiled, but at the startup I see this:
> [ ... ]
> Initializing RT netlink socket
> pci: passed tb register update test
> pci: passed sg loopback i/o read test
> pci: passed tbia test
> pci: passed pte write cache snoop test
> pci: failed valid tag invalid pte reload test (mcheck; workaround
> available)
> pci: passed pci machine check test
> Kernel bug at /usr/src/linux-2.5.20/include/linux/device.h:75
> swapper(1): Kernel Bug 1
> pc =3D [<fffffc00003dceac>]  ra =3D [<fffffc00003dbc14>]  ps =3D 0000    =
Not
> tainted
> v0 =3D 0000000000000000  t0 =3D 0000000000000000  t1 =3D fffffc00005b3a48
>=20
> I check what is on line 75 in device.h!

That's a known problem. Please look for my mail with Subject "[2.5.19]
Oops during PCI scan on Alpha". One follow-up had a working (but
hackish) fix.

> PS: Anybody want's the patches???

/me

MfG, JBG
PS: Please answer _under_ or _within_ an old mail, but never ever above
it!

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE8/M0MHb1edYOZ4bsRAhtvAJ9llWMGuNYIsdIjNTUbp42+kS0uLwCdFH4n
HCovzQY01j9rLaREBgId6IQ=
=5RsN
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--
