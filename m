Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133047AbRD3ERd>; Mon, 30 Apr 2001 00:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133050AbRD3ERX>; Mon, 30 Apr 2001 00:17:23 -0400
Received: from adsl-63-199-250-45.dsl.sndg02.pacbell.net ([63.199.250.45]:55303
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S133047AbRD3ERF>; Mon, 30 Apr 2001 00:17:05 -0400
Date: Sun, 29 Apr 2001 21:16:55 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        mailhot@enst.fr, markus@schlup.net
Subject: Re: Dane-Elec PhotoMate Combo
Message-ID: <20010429211655.C8349@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net, mailhot@enst.fr,
	markus@schlup.net
In-Reply-To: <UTC200104291221.OAA37952.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200104291221.OAA37952.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Apr 29, 2001 at 02:21:11PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I would seriously argue with the "works beautifully" part of that. =20

The DPCM code relies on the SDDR09 code, which is horrendously buggy.  It's
also being actively worked on.  I can crash it at will with relatively
simple operations.

Matt

On Sun, Apr 29, 2001 at 02:21:11PM +0200, Andries.Brouwer@cwi.nl wrote:
>     From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
>=20
>     > (ii) this card needs usb/storage/dpcm.c which is compiled when
>     > CONFIG_USB_STORAGE_DPCM is set, but this variable is missing
>     > from usb/Config.in. Add it.
>=20
>     This config option is considered so immature that it's not ready for =
the
>     kernel config, even as an EXPERIMENTAL.  Use it at your own risk.
>=20
> Of course. But the choice is simple. Without it, one has a non-functional
> device. With it, one has a device that works beautifully.

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

NYET! The evil stops here!
					-- Pitr
User Friendly, 6/22/1998

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE67Oc3z64nssGU+ykRAiZTAJ9xZngeDj52HpFqOwM34MrF0EaXpwCfYfVb
Y/auDvskMId3d65jc2Rl4Ec=
=V4K5
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
