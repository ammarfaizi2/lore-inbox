Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbQLRRTU>; Mon, 18 Dec 2000 12:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131143AbQLRRTL>; Mon, 18 Dec 2000 12:19:11 -0500
Received: from [216.120.107.189] ([216.120.107.189]:46865 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S129455AbQLRRSz>; Mon, 18 Dec 2000 12:18:55 -0500
Date: Mon, 18 Dec 2000 08:48:19 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: set_rtc_mmss: can't update from 0 to 59
Message-ID: <20001218084819.A17221@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200012181310.OAA170929.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <UTC200012181310.OAA170929.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Dec 18, 2000 at 02:10:32PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Honestly, this is the best solution I've heard.  It seems that the message
is somewhat bogus, anyway, seeing as how this message is somewhat "normal"
and just represents the occasional occurance of a fast cmos clock with
xntpd and running the code near the top of the hour.

Matt

On Mon, Dec 18, 2000 at 02:10:32PM +0100, Andries.Brouwer@cwi.nl wrote:
>     From mdharm@ziggy.one-eyed-alien.net Mon Dec 18 04:47:51 2000
>=20
>     > so if your cmos time is 0.001 sec ahead of your system time
>     > then around the hour you'll see
>     >     set_rtc_mmss: can't update from 0 to 59
>=20
>     but, the question is, how do we fix this?
>=20
> Put #if 0 ... #endif around the printk.
>=20
> Andries

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Oh BAY-bee.
					-- Dust Puppy to Greg
User Friendly, 12/13/1997

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Pj/Tz64nssGU+ykRAsjnAKDCK5j7h6QUHFQzu3RmLr2BpKOFDwCgwWfJ
UF3K+KmfwlpKx7f6Sb3B+7g=
=ok2e
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
