Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292249AbSCDIdE>; Mon, 4 Mar 2002 03:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292248AbSCDIcz>; Mon, 4 Mar 2002 03:32:55 -0500
Received: from bb-203-125-144-62.singnet.com.sg ([203.125.144.62]:37295 "HELO
	accellion.com") by vger.kernel.org with SMTP id <S292254AbSCDIco>;
	Mon, 4 Mar 2002 03:32:44 -0500
Date: Mon, 4 Mar 2002 16:32:36 +0800
From: Mathieu Legrand <mathieu@accellion.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.19pre2-ac2 || Linux 2.4.18-ac3, compilation error on SPARC
Message-ID: <20020304083236.GC3568@accellion.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-message-flag: Get yourself a real email client. http://www.mutt.org/
X-AntiVirus: scanned for virii by AMaViS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello:

I couldn't get the latest ac kernels to compile on a SUN sparc Ultra 10,
even using the default configuration (arch/sparc64/defconfig).

I didn't try yet to compile a older kernel.  Here is the error message I ge=
t:

sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prot=
otypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-co=
mmon -m64 -pipe -mno-fpu -mcpu=3Dultrasparc -mcmodel=3Dmedlow -ffixed-g4 -f=
call-used-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs   -DKBU=
ILD_BASENAME=3Dide  -DEXPORT_SYMTAB -c ide.c
In file included from /usr/src/linux/include/linux/ide.h:301,
                 from ide.c:149:
/usr/src/linux/include/asm/ide.h:132: warning: `/*' within comment
In file included from /usr/src/linux/include/linux/ide.h:301,
                 from ide.c:149:
/usr/src/linux/include/asm/ide.h:153: parse error before `static'
/usr/src/linux/include/asm/ide.h:153: warning: no semicolon at end of struc=
t or union
/usr/src/linux/include/asm/ide.h:153: warning: no semicolon at end of struc=
t or union
/usr/src/linux/include/asm/ide.h: In function `ide_insw':
/usr/src/linux/include/asm/ide.h:175: warning: implicit declaration of func=
tion `inw_be'
/usr/src/linux/include/asm/ide.h: At top level:
/usr/src/linux/include/asm/ide.h:320: warning: This file contains more `{'s=
 than `}'s.
/usr/src/linux/include/linux/ide.h:1103: warning: This file contains more `=
{'s than `}'s.
ide.c: In function `ide_dump_status':
ide.c:993: warning: long long int format, long int arg (arg 2)
ide.c: In function `hwif_unregister':
ide.c:2188: warning: implicit declaration of function `ide_release_region'
make[3]: *** [ide.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

I am using Debian unstable on that computer.

  egcs64         19980921.1-1
  libc6-sparc64  2.2.5-3
  libc6-dev-spar 2.2.5-3

Reading specs from /usr/lib/gcc-lib/sparc64-linux/egcs-2.92.11/specs
gcc version egcs-2.92.11 19980921 (gcc2 ss-980609 experimental)

--=20
Mathieu Legrand <mathieu @ {accellion.com -work | globules.net -perso}>
GPG: 0x349EBC9961C501D1   fp: D6D2D2D74E6320D99B54 38F3349EBC9961C501D1
 - Yoda of Borg are we: Futile is resistance.  Assimilate you, we will.

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8gzEkNJ68mWHFAdERAs/QAJwOL301htkLPCLHxLvUT+axPodc2wCePMsN
Wba88qGx0b/T0tn/+YHEGqw=
=qo60
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

