Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274509AbRJADkB>; Sun, 30 Sep 2001 23:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274513AbRJADjw>; Sun, 30 Sep 2001 23:39:52 -0400
Received: from mail.direcpc.com ([198.77.116.30]:27787 "EHLO
	postoffice2.direcpc.com") by vger.kernel.org with ESMTP
	id <S274509AbRJADjj>; Sun, 30 Sep 2001 23:39:39 -0400
Subject: md5sum: WARNING: 4 of 13 computed checksums did NOT match
From: Jeffrey Ingber <jhingber@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-1YcIqX+am+HTHzazggX+"
X-Mailer: Evolution/0.14.99+cvs.2001.09.29.08.08 (Preview Release)
Date: 30 Sep 2001 23:43:10 -0400
Message-Id: <1001907794.19740.1.camel@DESK-2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1YcIqX+am+HTHzazggX+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

	I receive this warning when compiling 2.4.10.  Maybe it's not
important, but it caught my attention.

gcc -D__KERNEL__ -I/usr/src/linux-2.4.10/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
-march=3Di686 -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.10/include/linux/modversions.h   -c -o c4.o c4.c
make[3]: Leaving directory `/usr/src/linux-2.4.10/drivers/isdn/avmb1'
make -C hisax modules
md5sum: WARNING: 4 of 13 computed checksums did NOT match

Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)




--=-1YcIqX+am+HTHzazggX+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7t+ZNaMTzuMuv5OERAs71AJ4zgHjEyfd6KXXOou0zG0fgn9qZFgCfWVd7
M69HPaFB+u56gabgPedFYPo=
=tQmd
-----END PGP SIGNATURE-----

--=-1YcIqX+am+HTHzazggX+--

