Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263131AbVCEPy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbVCEPy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbVCEPxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:53:54 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:17831 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S262354AbVCEPpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:45:41 -0500
Subject: Device-mapper quary
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bJD7mY2kXlRpel7g1hPR"
Date: Sat, 05 Mar 2005 17:48:30 +0200
Message-Id: <1110037710.8842.2.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bJD7mY2kXlRpel7g1hPR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I have been getting the following in my logs recently (just after
bootup):

-----
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
Buffer I/O error on device sda3, logical block 308367488
Buffer I/O error on device sda3, logical block 308367489
Buffer I/O error on device sda3, logical block 308367490
Buffer I/O error on device sda3, logical block 308367491
Buffer I/O error on device sda3, logical block 308367492
Buffer I/O error on device sda3, logical block 308367493
Buffer I/O error on device sda3, logical block 308367494
Buffer I/O error on device sda3, logical block 308367495
Buffer I/O error on device sda3, logical block 308367488
Buffer I/O error on device sda3, logical block 308367489
-----

I checked sda though, and it seems fine (badblocks, e2fsck, etc).  sda
(and in theory sda3) is part of a device-mapper stripe array ....


Thanks,

--=20
Martin Schlemmer


--=-bJD7mY2kXlRpel7g1hPR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCKdTOqburzKaJYLYRAosmAJ9ofvMln3suN58zB6jniIQUguKX0QCeKi14
jrEJwfo3/GAXoZ/+uBBySXE=
=m25o
-----END PGP SIGNATURE-----

--=-bJD7mY2kXlRpel7g1hPR--

