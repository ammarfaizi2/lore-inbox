Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276587AbRJKRTF>; Thu, 11 Oct 2001 13:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRJKRS4>; Thu, 11 Oct 2001 13:18:56 -0400
Received: from 208-58-240-129.s383.tnt1.atnnj.pa.dialup.rcn.com ([208.58.240.129]:48626
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S276600AbRJKRSj>; Thu, 11 Oct 2001 13:18:39 -0400
Date: Thu, 11 Oct 2001 13:20:03 -0400
From: Malcolm Mallardi <magamo@mirkwood.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.12 Compiling error.
Message-ID: <20011011132003.A13730@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the new Kernel 2.4.12, when attempting to compile modules, the parport=
=20
module dies, I'm attempting to compile it with IEEE1284 readback support=20
(HP OJ T45 printer)

make -C parport modules
make[2]: Entering directory `/usr/src/linux-2.4.12/drivers/parport'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes=
=20
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common=20
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 -DMODULE   -c -o=20
ieee1284_ops.o ieee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in=20
this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in=20
this function)
make[2]: *** [ieee1284_ops.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.12/drivers/parport'
make[1]: *** [_modsubdir_parport] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.12/drivers'
make: *** [_mod_drivers] Error 2

Is the error I get.

--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net/~magamo/index.htm

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7xdTD37pc5u26PgoRAsVGAKCVskWIiN1HyMBezowLiaJ94D9f+wCeLCAZ
dAblyYX3P1yJNqHCWKFkoCU=
=WfTi
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
