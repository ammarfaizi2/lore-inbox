Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUIEWlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUIEWlG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUIEWif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:38:35 -0400
Received: from imap.nuit.ca ([66.11.160.83]:40127 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S267323AbUIEWgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:36:53 -0400
Date: Sun, 5 Sep 2004 22:36:44 +0000
From: simon@nuit.ca
To: linux-kernel@vger.kernel.org
Cc: simon@nuit.ca
Subject: sig11 with sch_ingress in 2.6.8.1
Message-ID: <20040905223644.GB19153@nuit.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040818i
X-Scan-Signature: smtp.nuit.ca 1C45cq-0003qb-HN 0a2f6a544f009e953df4c70d5e63f261
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline


kernel oops in sch_ingress

when the network comes up, the whole achine locks up hard, making it
impossible to use the network and the machine.

networking, modules

version 2.6.8.1

the most i was abe to get from it was:

sig11 ing_hook+0x48/0x50 sch_ingress

and something about nf_iterate and nf_hook_slow

cat /proc/cpuinfo
processor       : 0
cpu             : 740/750
temperature     : 35-37 C (uncalibrated)
clock           : 195MHz
revision        : 2.2 (pvr 0008 0202)
bogomips        : 602.11
machine         : Power Macintosh
motherboard     : AAPL,8500 MacRISC
detected as     : 16 (PowerMac 8500/8600)
pmac flags      : 00000000
memory          : 448MB
pmac-generation : OldWorld

the other stuff (/proc/modules, ver_linux script, etc.) is only relevant to the
FUBAR kernel, therefore i won't post it - only upon request, as it isn't always
convenient for me to reboot the machine to the FUBAR kernel (it serves as the
LAN's router as well).

i rebuilt the kernel something like 6 times or more thinking some config
changed and i was building it all wrong. guess not :)

thanks


--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQGVAwUBQTuU+WqIeuJxHfCXAQJORgv+JzDyEs7SUt26zwYNJsAOrmvh1jqaaMZW
0u1TtEcoR4oJDgb/hfa2G3wj5Qobamw7pd7Rp7KAVIQuP1upTqDdSNjvGkxufRDA
J+LEy09kB7GALnGcm8R4aZEcNXJtoyO/vhfP0FiFzYSlMScO5Mmut6g/y/dSohYt
ek7MKDVWrXYOcU6/gCZ89WJfJn4h05eG4G+3ycElda2zcbOMjFRUgIQYsW8Ly3bp
ZXJQ8TZfwjTuEN21ZZFCFGUbb5dPryt7xkbwF08DrfBvhxHcqQfjrXYfF9vf1Kz8
TDd0AmQ9RmaKL3cZTq99uJV0DnJZTB5pQPPaqp9vMWQOdvKyX3pmuKkvTdb3Iewk
vde4qHeE2lgtaR7/1A1hP1exuucpQImx8qvjOGeSVDTrVCBpbiAo9UAmBWJ6Wf94
PXXrvfuVSFfaF4o3z7uXSEJAhIauLRbipu11NQgd4lySrAgtP207lYk7eIV7BQZb
lViaciSoL+wVczLM7seyVuUvcfUnmhLv
=kAY9
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
