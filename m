Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbTLQOKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 09:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbTLQOKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 09:10:42 -0500
Received: from outbound02.telus.net ([199.185.220.221]:64176 "EHLO
	priv-edtnes04.telusplanet.net") by vger.kernel.org with ESMTP
	id S264405AbTLQOKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 09:10:40 -0500
Subject: ieee1394 subsystem causes segfaults
From: Dale K Dicks <dale_d@telusplanet.net>
Reply-To: dale_d@telusplanet.net
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hQ4LU40/77p2IqvINvVZ"
Organization: Home
Message-Id: <1071670222.2519.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 07:10:22 -0700
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-hQ4LU40/77p2IqvINvVZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

1. when unloading the ochi1394 or sbp2 modules from a 2.6.0-test11
kernel, a segfault occurs every time.

2. modprobe ohci1394, modprobe sbp2, rmmod sbp2 and/or rmmod ohci1394,
segfault, lsmod hangs after this as well as the originating tty

3. modules

4. 2.6.0-test11

5. no oops message

6. see 2.

7. Gentoo Linux

7.2. [ ddicks@linuxbox ~ ] $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.80GHz
stepping        : 2
cpu MHz         : 1808.041
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3588.09


DKD
Calgary, Alberta, Canada
dale_D at telusplanet dot net

--
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


--=-hQ4LU40/77p2IqvINvVZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/4GPOTy0R239cY34RAupYAJ0aK6r5xN1u5MRujQqcmm6mw18CaACeP1tq
dMsn0wbnKCz5hAquAzes3Jk=
=R5vC
-----END PGP SIGNATURE-----

--=-hQ4LU40/77p2IqvINvVZ--

