Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRKKPxk>; Sun, 11 Nov 2001 10:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277176AbRKKPxU>; Sun, 11 Nov 2001 10:53:20 -0500
Received: from sozanski.balliol.ox.ac.uk ([163.1.209.1]:28800 "EHLO
	alancaisez.balliol.ox.ac.uk") by vger.kernel.org with ESMTP
	id <S272818AbRKKPxO>; Sun, 11 Nov 2001 10:53:14 -0500
Subject: PROBLEM: drivers/block/block.o - undefined referedce to
	'deactivate_page' when compiling 2.4.14
From: "Peter Sozanski d'Alancaisez" <peter.sozanski@balliol.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-6IKZz+1Z6cqaJ5G9qNsj"
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 11 Nov 2001 15:53:19 +0000
Message-Id: <1005493999.850.4.camel@alancaisez.balliol.ox.ac.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6IKZz+1Z6cqaJ5G9qNsj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[1] drivers/block/block.o - undefined referedce to 'deactivate_page' when c=
ompiling 2.4.14

[2] When compiling 2.4.14 with exactly the same config as my (operational) =
2.4.12, make bxImage gets stuck on
devices/block/block.o In function 'lo_send'
devices/block/block.o .text+0x8f06 undefined reference to 'deactivate_page'
devices/block/block.o .text+0x8f44 undefined reference to 'deactivate_page'

[4] Linux 2.4.12 #1 SMP Sat Oct 13 12:03:40 GMT 2001 i686 unknown
=20
[7]
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
mount                  2.10r
modutils               2.3.21
e2fsprogs              1.18
pcmcia-cs              3.1.19
PPP                    2.4.0
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         au8820


Any ideas? Many thanks,

Peter

--=-6IKZz+1Z6cqaJ5G9qNsj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA77p7vz5QCPsY/t8YRAtcEAJsH9Ftie1Bqmyy4Cp19g+sKeShTIACeM85k
iOY1LjPKHkxxUTzu9ShMvvw=
=eY6t
-----END PGP SIGNATURE-----

--=-6IKZz+1Z6cqaJ5G9qNsj--
