Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbQLQVD3>; Sun, 17 Dec 2000 16:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130613AbQLQVDT>; Sun, 17 Dec 2000 16:03:19 -0500
Received: from [216.120.107.189] ([216.120.107.189]:49933 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S130485AbQLQVDL>; Sun, 17 Dec 2000 16:03:11 -0500
Date: Sun, 17 Dec 2000 12:32:37 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: set_rtc_mmss: can't update from 0 to 59
Message-ID: <20001217123237.B11947@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was trying to figure out why I periodically get the message=20

set_rtc_mmss: can't update from 0 to 59

on my console.  It appears that the kernel is attempting to update my CMOS
clock for me, based on the more accurate data being provided by my xntpd.

According to the notes in the code, this should work if my RTC is less than
15 minutes off... which I can guarantee it is.  Accoring to hwclock, it's
less than a second off.

So, what's causing this message?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Okay, this isn't funny anymore! Let me down!  I'll tell Bill on you!!
					-- Microsoft Salesman
User Friendly, 4/1/1998

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6PSLlz64nssGU+ykRAsG8AJ9J1dBvHmDL+Ku/lIRAzlnhtCgHPQCfeS5i
S2V3SUsHLuz352XgCSXg9jc=
=eLww
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
