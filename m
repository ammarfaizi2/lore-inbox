Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSKZIv0>; Tue, 26 Nov 2002 03:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSKZIv0>; Tue, 26 Nov 2002 03:51:26 -0500
Received: from dhcp31182033.columbus.rr.com ([24.31.182.33]:61454 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id <S265587AbSKZIvY>; Tue, 26 Nov 2002 03:51:24 -0500
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Tue, 26 Nov 2002 03:58:40 -0500
To: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM][SOUND][2.5] - ALSA & OSS cannot find SBAWE32 Card
Message-ID: <20021126085840.GA1033@zion.rivenstone.net>
Mail-Followup-To: Shawn Starr <spstarr@sh0n.net>,
	linux-kernel@vger.kernel.org
References: <200211260258.05564.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <200211260258.05564.spstarr@sh0n.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2002 at 02:58:05AM -0500, Shawn Starr wrote:

> ALSA device list:
>    No soundcards found.
>=20
> dmesg 2.4.20-pre7 - OSS: - WORKS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

    Me too!

    In 2.5.47 mainline and 2.5.49-ac1 the ALSA drivers (either sb16 or
sbawe) load but don't detect devices if PNP support is built in.  The
same card (an awe64) works fine under 2.4.19.

    Without PNP sb16 works (with only sb16 features) but sbawe will
not load, complaining that it can't find the awe bits.

--=20
Joseph Fannin
jhf@rivenstone.net


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE94ze/Wv4KsgKfSVgRAsnEAJ45sZoBIIbjmD9QfcQO00mVZKPzWwCfXjHU
kkR4761udQIyl9e1Jv0pMew=
=ir5a
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
