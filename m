Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRDNI4O>; Sat, 14 Apr 2001 04:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRDNI4E>; Sat, 14 Apr 2001 04:56:04 -0400
Received: from p3EE37582.dip.t-dialin.net ([62.227.117.130]:3827 "EHLO
	infinity.bzimage.de") by vger.kernel.org with ESMTP
	id <S131317AbRDNIzz>; Sat, 14 Apr 2001 04:55:55 -0400
Date: Sat, 14 Apr 2001 10:55:52 +0200
From: Norbert Tretkowski <nobse@debian.org>
To: Linux Kernel Mailingliste <linux-kernel@vger.kernel.org>
Subject: can't compile -ac6
Message-ID: <20010414105552.A15368@infinity.bzimage.de>
Mail-Followup-To: Linux Kernel Mailingliste <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: defunct
Mail-Copies-To: never
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac6/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c sys.c
sys.c: In function `sys_gethostname': /usr/src/linux-2.4.3-ac6/include/asm/rwsem-xadd.h:153: inconsistent operand constraints in an `asm'
make[2]: *** [sys.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.3-ac6/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.3-ac6/kernel'
make: *** [_dir_kernel] Error 2

I'm using gcc 3.0 (20010402) and had no problems with 2.4.3-ac4.


Norbert

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE62BCYr/RnCw96jQERAjdbAKCO3uQiFCNTAWbdqSXA8fBRS6MzfQCdHOH7
aKwi80uIXYn78OemB+2qiSM=
=+oDH
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
