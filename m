Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVFNKoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVFNKoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 06:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVFNKoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 06:44:08 -0400
Received: from [213.69.232.60] ([213.69.232.60]:24581 "HELO ei.schottelius.org")
	by vger.kernel.org with SMTP id S261173AbVFNKoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 06:44:02 -0400
Date: Tue, 14 Jun 2005 11:41:41 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: Why is one sync() not enough?
Message-ID: <20050614094141.GE1467@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again!

When my system shuts down and init calls sync() and after that
umount and then reboot, the filesystem is left in an unclean state.

If I do sync() two times (one before umount, one after umount) it
seems to work.

Can someboy explain that to me?

Architecture is ppc and x86.

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQq6mU7OTBMvCUbrlAQKxIA//W9ck87CwhwqfYNBpEBbsmFhXi6Zk4F4z
aEaPpcSiZIwQjvDhOQbokwO9xE0GeqQQCXpSOJvv/kzedoavLALYkz0TCs8xXJMR
OhXfQld1CpdgtoZOJo93A6bB4200tULag+E+i9T01qOjcO4fbE4DfrOUoynBczP7
Mh3MoJcoYSJwIWDOSHiYFT9o6UkHIr/uUYVnLPjVo5P14CZL8uctyZ3HkWYJm5J8
FY8xaGEXYcEh0T0Img8nXJyQ2xj/JEZRzTM7mCF6RRyQ9c/vOWqIoM2F6oVgGJw9
RPgOkGgwUAkg7p/veMjcCYuanQFuYf9+ndbOIMfdGKfgFatLLiXZ2xNvOhl29s/P
REeN/CH7qio0FoACIJxgsy8YbYe+Zo13q/mZ8TLrIO/7MDFh7ej83LN9qYFoqMyr
OQCADMz1ETKq08RrfCayvfoq8a9GyykVnnJBOinA/36wNjmjPgP3cD2xuFcFmPXk
8qO+ksekC54/kWyN37yMbqDJKVJg/FfhwBqcHE74/L3hobr9K/wqAC+rpvlbFCb2
OwoHOgJp302jlJ9L3F9G5KWcEM+RYJn3O7RImQsd4Jwm0ETtMmWc7953OW8PNa4M
U+f4nn/7ybOx2b+xQf0oNEGfqA10RfmmHdLaVrmO+gMaG1bvvuXbUYkA2nYjmvbr
TqNwcdTZW4s=
=+PoU
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
