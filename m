Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbRHJHq5>; Fri, 10 Aug 2001 03:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264942AbRHJHqr>; Fri, 10 Aug 2001 03:46:47 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:10249 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S264932AbRHJHqe>;
	Fri, 10 Aug 2001 03:46:34 -0400
Date: Fri, 10 Aug 2001 11:46:39 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ac97_codec.c: add ident string for Winbond W83971D codec
Message-ID: <20010810114639.A22339@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 11:37am  up 13 days, 18:43,  2 users,  load average: 0.03, 0.05, 0.01
X-Uname: Linux orbita1.ru 2.2.20pre2-acl 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

patch adds ident string for the Winbond W83971D (stupid fixedrate 48kHz AC9=
7 codec).

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-w83971d
Content-Transfer-Encoding: quoted-printable

diff -urN /linux.vanilla/drivers/sound/ac97_codec.c /linux/drivers/sound/ac=
97_codec.c
--- /linux.vanilla/drivers/sound/ac97_codec.c	Fri Aug 10 11:06:17 2001
+++ /linux/drivers/sound/ac97_codec.c	Fri Aug 10 11:08:28 2001
@@ -141,6 +141,7 @@
 	{0x83847644, "SigmaTel STAC9744/45",	&sigmatel_9744_ops},
 	{0x83847656, "SigmaTel STAC9756/57",	&sigmatel_9744_ops},
 	{0x83847684, "SigmaTel STAC9783/84?",	&null_ops},
+	{0x57454301, "Winbond 83971D",		&null_ops},
 	{0,}
 };
=20
@@ -173,7 +174,7 @@
 	/*  24 */ "Wolfson Microelectronics 3D Enhancement",
 	/*  25 */ "Delta Integration 3D Enhancement",
 	/*  26 */ "SigmaTel 3D Enhancement",
-	/*  27 */ "Reserved 27",
+	/*  27 */ "Winbond 3D Stereo Enhancement",
 	/*  28 */ "Rockwell 3D Stereo Enhancement",
 	/*  29 */ "Reserved 29",
 	/*  30 */ "Reserved 30",

--7AUc2qLy4jB3hD7Z--

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7c5FeBm4rlNOo3YgRApGgAJ0e9gnUwGKiPjfO7/mrk1cyk2O1VwCgjgT8
M/NZ23Tx1YGUZ1xllC7lBnQ=
=QlDF
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
