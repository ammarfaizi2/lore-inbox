Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVBCVUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVBCVUl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbVBCVUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:20:41 -0500
Received: from 86.144.199.200.docasdoporto.com.br ([200.199.144.86]:53740 "EHLO
	shelob.localdomain") by vger.kernel.org with ESMTP id S262434AbVBCVU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:20:26 -0500
Subject: help with strace
From: Rodrigo Ramos <rodrigo.ramos@triforsec.com.br>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TZXYhgp1SQhHylUBTsTb"
Message-Id: <1107464486.7171.112.camel@ZeroOne>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 03 Feb 2005 18:01:27 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TZXYhgp1SQhHylUBTsTb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I think that many of us in this mailing list use strace
(http://www.liacs.nl/~wichert/strace/) for studying, debugging and....=20
I am writing a paper about Strace under Linux version 2.4.22-1.2197.nptl
using the strace's man page as my principal reading source. Does anybody
heres knows others sources? While I am doing some tests I see that my
results are a little bit different from the man page...Example:

In the man page's examples there are no 64 after the system call, like
in my output. What is this 64?

lstat64("/dev/null", {st_mode=3DS_IFCHR|0666, st_rdev=3Dmakedev(1, 3), ...}=
)
=3D 0

lstat64("/home/teste", 0x92b85ac)       =3D -1 ENOENT (No such file or
directory)

Best regards,
--=20
Rodrigo Ramos

55 81 3463.1593
55 81 8851.3524
http://www.triforsec.com.br
http://www.defenselayer.com
Key fingerprint =3D F381 366D D233 22B4 7E72  A21D DE9B 2FF3 71CF E098

--=-TZXYhgp1SQhHylUBTsTb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBCApEl3psv83HP4JgRAseZAKCdIvVmwMOlgkviHUcwiH35zfpckACfUa4s
860AeoT1FBoZuyGFWkaj6UY=
=Ojb8
-----END PGP SIGNATURE-----

--=-TZXYhgp1SQhHylUBTsTb--

