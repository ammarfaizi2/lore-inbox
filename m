Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTECHPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 03:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTECHPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 03:15:32 -0400
Received: from dsl-62-3-122-162.zen.co.uk ([62.3.122.162]:8577 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S263269AbTECHPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 03:15:30 -0400
Subject: Re: Compile error kernel 2.4.21-rc1
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1051938126.3976.11.camel@marx>
References: <1051938126.3976.11.camel@marx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GIpWYRYY1TFRwyaKoqtB"
Organization: Trudheim Technology Limited
Message-Id: <1051946869.3976.32.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 03 May 2003 08:27:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GIpWYRYY1TFRwyaKoqtB
Content-Type: multipart/mixed; boundary="=-yiH3DzKy7lhmgfHUvtmd"


--=-yiH3DzKy7lhmgfHUvtmd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-05-03 at 06:02, Anders Karlsson wrote:
> Hi,
>=20
> Just tried to compile kernel 2.4.21-rc1 and I get the compile error as
> per attached file 'compile_error.txt'. The config file used is also
> attached. This happened while doing 'make rpm'. This is being compiled
> on SuSE Pro 8.2 which is using GCC 3.3.
>=20
> I'll happily try out patches.

Found another compile error. Again attached in 'compile_error.txt'.

/Anders


--=-yiH3DzKy7lhmgfHUvtmd
Content-Disposition: attachment; filename=compile_error.txt
Content-Type: text/plain; name=compile_error.txt; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

gcc -D__KERNEL__ -I/usr/src/packages/BUILD/kernel-2.4.21rc1/include -Wall -=
Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fom=
it-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 -DMODUL=
E -DMODVERSIONS -include /usr/src/packages/BUILD/kernel-2.4.21rc1/include/l=
inux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=3Dma60=
0  -c -o ma600.o ma600.c
ma600.c:51:22: warning: extra tokens at end of #undef directive
ma600.c: In function `ma600_init':
ma600.c:89: warning: concatenation of string literals with __FUNCTION__ is =
deprecated
ma600.c: In function `ma600_cleanup':
ma600.c:95: warning: concatenation of string literals with __FUNCTION__ is =
deprecated
ma600.c: In function `ma600_open':
ma600.c:108: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c: In function `ma600_close':
ma600.c:126: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c: In function `ma600_change_speed':
ma600.c:187: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c:189:40: pasting ";" and "return" does not give a valid preprocessin=
g token
ma600.c:192: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c:218: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c:249: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c:257: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c:276: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c: In function `ma600_reset':
ma600.c:301: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c:303:40: pasting ";" and "return" does not give a valid preprocessin=
g token
ma600.c:306: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c:329: warning: concatenation of string literals with __FUNCTION__ is=
 deprecated
ma600.c: At top level:
/usr/src/packages/BUILD/kernel-2.4.21rc1/include/linux/module.h:299: warnin=
g: `__module_kernel_version' defined but not used
/usr/src/packages/BUILD/kernel-2.4.21rc1/include/linux/module.h:302: warnin=
g: `__module_using_checksums' defined but not used
ma600.c:339: warning: `__module_license' defined but not used
make[4]: *** [ma600.o] Error 1
make[4]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1/driver=
s/net/irda'
make[3]: *** [_modsubdir_irda] Error 2
make[3]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1/driver=
s/net'
make[2]: *** [_modsubdir_net] Error 2
make[2]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1/driver=
s'
make[1]: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1'
Bad exit status from /var/tmp/rpm-tmp.25479 (%build)
make: *** [rpm] Error 1


--=-yiH3DzKy7lhmgfHUvtmd--

--=-GIpWYRYY1TFRwyaKoqtB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+s291LYywqksgYBoRAtnBAKDkNSFKEe+E5OX59zRpWsfGBjbxwACggeJd
5la12zXNfiJkkHAjGa2hdXY=
=2pfj
-----END PGP SIGNATURE-----

--=-GIpWYRYY1TFRwyaKoqtB--

