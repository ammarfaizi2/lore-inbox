Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbTBRA6R>; Mon, 17 Feb 2003 19:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTBRA6R>; Mon, 17 Feb 2003 19:58:17 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:38849 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267224AbTBRA6P>; Mon, 17 Feb 2003 19:58:15 -0500
From: "Alvaro Barbosa G." <alvaro.barbosa-g@ntlworld.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: linux-2.5.62 - failing to make modules -  make[2]: *** [drivers/char/riscom8.o] Error 1
Date: Tue, 18 Feb 2003 01:08:12 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8dYU+NYssuivyRQ"
Message-Id: <200302180108.12738.alvaro.barbosa-g@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_8dYU+NYssuivyRQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

using gcc-3.2.2-1
i386 arch

When making modules i get these errors:

n file included from drivers/char/riscom8.c:51:
drivers/char/riscom8.h:88: field `tqueue' has incomplete type
drivers/char/riscom8.h:89: field `tqueue_hangup' has incomplete type
drivers/char/riscom8.c:84: warning: type defaults to `int' in declaration of 
`DECLA         RE_TASK_QUEUE'
drivers/char/riscom8.c:84: warning: parameter names (without types) in 
function dec         laration
drivers/char/riscom8.c:142: confused by earlier errors, bailing out
make[2]: *** [drivers/char/riscom8.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

any comments?

regards,
alvaro


--Boundary-00=_8dYU+NYssuivyRQ
Content-Type: text/plain;
  charset="us-ascii";
  name="makmod_err"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="makmod_err"

make -f scripts/Makefile.build obj=scripts
rm -rf .tmp_versions
mkdir -p .tmp_versions
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=1
make -f scripts/Makefile.build obj=init
  Generating include/linux/compile.h (unchanged)
make -f scripts/Makefile.build obj=usr
make -f scripts/Makefile.build obj=arch/i386/kernel
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/mcheck
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/mtrr
make -f scripts/Makefile.build obj=arch/i386/kernel/timers
make -f scripts/Makefile.build obj=arch/i386/mm
make -f scripts/Makefile.build obj=arch/i386/mach-default
make -f scripts/Makefile.build obj=kernel
make -f scripts/Makefile.build obj=mm
make -f scripts/Makefile.build obj=fs
make -f scripts/Makefile.build obj=fs/afs
make -f scripts/Makefile.build obj=fs/autofs
make -f scripts/Makefile.build obj=fs/autofs4
make -f scripts/Makefile.build obj=fs/befs
make -f scripts/Makefile.build obj=fs/bfs
make -f scripts/Makefile.build obj=fs/coda
make -f scripts/Makefile.build obj=fs/cramfs
make -f scripts/Makefile.build obj=fs/devpts
make -f scripts/Makefile.build obj=fs/exportfs
make -f scripts/Makefile.build obj=fs/ext2
make -f scripts/Makefile.build obj=fs/ext3
make -f scripts/Makefile.build obj=fs/fat
make -f scripts/Makefile.build obj=fs/freevxfs
make -f scripts/Makefile.build obj=fs/hfs
make -f scripts/Makefile.build obj=fs/intermezzo
make -f scripts/Makefile.build obj=fs/isofs
make -f scripts/Makefile.build obj=fs/jbd
make -f scripts/Makefile.build obj=fs/jfs
make -f scripts/Makefile.build obj=fs/lockd
make -f scripts/Makefile.build obj=fs/minix
make -f scripts/Makefile.build obj=fs/msdos
make -f scripts/Makefile.build obj=fs/ncpfs
make -f scripts/Makefile.build obj=fs/nfs
make -f scripts/Makefile.build obj=fs/nfsd
make -f scripts/Makefile.build obj=fs/nls
make -f scripts/Makefile.build obj=fs/ntfs
make -f scripts/Makefile.build obj=fs/partitions
make -f scripts/Makefile.build obj=fs/proc
make -f scripts/Makefile.build obj=fs/ramfs
make -f scripts/Makefile.build obj=fs/reiserfs
make -f scripts/Makefile.build obj=fs/romfs
make -f scripts/Makefile.build obj=fs/smbfs
make -f scripts/Makefile.build obj=fs/sysfs
make -f scripts/Makefile.build obj=fs/sysv
make -f scripts/Makefile.build obj=fs/udf
make -f scripts/Makefile.build obj=fs/ufs
make -f scripts/Makefile.build obj=fs/vfat
make -f scripts/Makefile.build obj=ipc
make -f scripts/Makefile.build obj=security
make -f scripts/Makefile.build obj=crypto
make -f scripts/Makefile.build obj=drivers
make -f scripts/Makefile.build obj=drivers/atm
make -f scripts/Makefile.build obj=drivers/base
make -f scripts/Makefile.build obj=drivers/base/fs
make -f scripts/Makefile.build obj=drivers/block
make -f scripts/Makefile.build obj=drivers/block/paride
make -f scripts/Makefile.build obj=drivers/cdrom
make -f scripts/Makefile.build obj=drivers/char
make -f scripts/Makefile.build obj=drivers/char/agp
make -f scripts/Makefile.build obj=drivers/char/drm
make -f scripts/Makefile.build obj=drivers/char/ftape
make -f scripts/Makefile.build obj=drivers/char/ftape/compressor
make -f scripts/Makefile.build obj=drivers/char/ftape/lowlevel
make -f scripts/Makefile.build obj=drivers/char/ftape/zftape
make -f scripts/Makefile.build obj=drivers/char/ipmi
make -f scripts/Makefile.build obj=drivers/char/mwave
make -f scripts/Makefile.build obj=drivers/char/pcmcia
make -f scripts/Makefile.build obj=drivers/char/watchdog
  gcc -Wp,-MD,drivers/char/.riscom8.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=riscom8 -DKBUILD_MODNAME=riscom8 -c -o drivers/char/.tmp_riscom8.o drivers/char/riscom8.c

--Boundary-00=_8dYU+NYssuivyRQ--

