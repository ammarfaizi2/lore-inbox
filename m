Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263250AbTCYScE>; Tue, 25 Mar 2003 13:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263251AbTCYScE>; Tue, 25 Mar 2003 13:32:04 -0500
Received: from M1019P023.adsl.highway.telekom.at ([62.47.159.87]:23463 "EHLO
	sputnik") by vger.kernel.org with ESMTP id <S263250AbTCYScA>;
	Tue, 25 Mar 2003 13:32:00 -0500
Date: Tue, 25 Mar 2003 19:42:11 +0100
From: maximilian attems <maks@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: 2.5.65 compile failure
Message-ID: <20030325184211.GA9811@mail.sternwelten.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

used gcc 2.95.4


  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=3Dversion -DKBUILD_MODNAME=3Dvers=
ion
-c -o init/.tmp_version.o init/version.c
scripts/fixdep init/.version.o.d init/version.o 'gcc
-Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=3D2 -march=3Di686 -Iinclude/asm-i386/mach-default
-fomit-frame-pointer -nostdinc -iwithprefix include
-DKBUILD_BASENAME=3Dversion -DKBUILD_MODNAME=3Dversion -c -o
init/.tmp_version.o init/version.c' > init/.version.o.tmp; rm -f
init/.version.o.d; mv -f init/.version.o.tmp init/.version.o.cmd
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
arch/ i386/kernel/init_task.o   init/built-in.o --start-group
usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
arch/i386/mach-default/built-in.o
  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o
net/built-in.o --end-group  -o vmlinux
vers/built-in.o: In function `ide_setup':
drivers/built-in.o(.init.text+0x2db2): undefined reference to `cmd640_vlb'
drivers/built-in.o: In function `probe_for_hwifs':
drivers/built-in.o(.init.text+0x2f81): undefined reference to
`ide_probe_for_cmd640x'
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.66'
make: *** [stamp-build] Error 2



old similar message:
http://www.cs.helsinki.fi/linux/linux-kernel/2002-39/0436.html

please cc me for any questions or answers
thx
maks



--=20
      Yb   dY    d888    888b    .db.
       Yb dY     8        d'     8  8
________YbY______Y888____8888_____YY________
 00000000 00010100

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+gKMD6//kSTNjoX0RAstDAJwO0s15APpSA9j2FNnZf7uHy15GbwCfSyMq
SZgptPyaeBGtkQD0kQjNGbo=
=h6jX
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
