Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVA0Xuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVA0Xuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVA0Xtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:49:49 -0500
Received: from xs4all.vs19.net ([213.84.236.198]:17724 "EHLO xs4all.vs19.net")
	by vger.kernel.org with ESMTP id S261282AbVA0XaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:30:18 -0500
Date: Fri, 28 Jan 2005 00:30:07 +0100
From: Jasper Spaans <jasper@vs19.net>
To: linux-kernel@vger.kernel.org, ajgrothe@yahoo.com
Subject: crypto algoritms failing?
Message-ID: <20050127233007.GA4678@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
X-Copyright: Copyright 2005 Jasper Spaans, unauthorised distribution prohibited
User-Agent: Mutt/1.5.6+20040907i
X-Broken-Reverse-DNS: no host name found for IP address 192.168.0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi List,

When booting I see this in dmesg:

testing tea ECB encryption=20
test 1 (128 bit key):
0a3aea4140a9ba94
fail
test 2 (128 bit key):
775d2a6af6ce9209
fail
test 3 (128 bit key):
be7abb81952d1f1edd89a1250421df95
fail
test 4 (128 bit key):
e04d5d3cb78c364794189591a9fc49f844d12dc299b8082a078973c24592c690
fail
[..]
testing xtea ECB encryption=20
test 1 (128 bit key):
aa2296e56c61f345
fail
test 2 (128 bit key):
823eeb35dcddd9c3
fail
test 3 (128 bit key):
e204dbf289859eea6135aaedb5cb712c
fail
test 4 (128 bit key):
0b03cd8abe95fdb1c144910ba5c91bb4a9da1e9eb13e2a8feaa56a85d1f4a8a5
fail

CPU in that machine is an athlon xp, cpu flags according to /proc/cpuinfo
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow

Compiler: gcc 3.3.5 (debian package 1:3.3.5-6)

Is this supposed to happen?


Jasper
--=20
Jasper Spaans                                       http://jsp.vs19.net/
 00:24:05 up 10207 days, 16:11, 0 users, load average: 6.29 6.03 6.13
         There already is an object oriented version of COBOL.
             It's called "ADD ONE TO COBOL GIVING COBOL."

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB+Xl/N+t4ZIsVDPgRAiH1AKDm5gKqw071eie+qxKi5AcnmO/eLwCfdD/K
NfGWGdmckV6zLBYYAPVwg0Y=
=/rgD
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
