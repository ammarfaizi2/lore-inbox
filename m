Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbTB0Xhv>; Thu, 27 Feb 2003 18:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbTB0Xhv>; Thu, 27 Feb 2003 18:37:51 -0500
Received: from web11005.mail.yahoo.com ([216.136.131.55]:54635 "HELO
	web11005.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267102AbTB0Xhu>; Thu, 27 Feb 2003 18:37:50 -0500
Message-ID: <20030227234809.96372.qmail@web11005.mail.yahoo.com>
Date: Thu, 27 Feb 2003 15:48:09 -0800 (PST)
From: Kristof Bruyninckx <masterkristof@yahoo.com>
Subject: MC4952 atapi support
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-636671555-1046389689=:95697"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-636671555-1046389689=:95697
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

hi,

I am trying to make uClinux support the atapi
protocol. But everytime I compile it i'm getting the
following errors (see attachement). I already
rebuilded my toolchain and applied the following patch
http://www.uclinux.org/ports/coldfire/gcc-2.95.3-m68k-zext.patch
and got a little further. Do you know what possibly
goes wrong?? any tips or advice will be deeply welkom.

yours truly and hoping for a reply

a learing student

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
--0-636671555-1046389689=:95697
Content-Type: text/plain; name="error4.txt"
Content-Description: error4.txt
Content-Disposition: inline; filename="error4.txt"

m68k-elf-gcc -fno-builtin -nostdinc -D__KERNEL__ -I/uClinux-dist/linux-2.4.x/include  -Wall -Wstrict-prototypes -Wno-trigraphs -O1 -g -fno-strict-aliasing -fno-common -I/usr/local/lib/gcc-lib/m68k-elf/2.95.3/./include -pipe -DNO_MM -DNO_FPU -m5200 -Wa,-S -Wa,-m5200 -D__ELF__ -DMAGIC_ROM_PTR -DUTS_SYSNAME="uClinux" -D__linux__   -nostdinc -I /usr/local/lib/gcc-lib/m68k-elf/2.95.3/include -DKBUILD_BASENAME=ide  -c -o ide.o ide.c
m68k-elf-gcc -fno-builtin -nostdinc -D__KERNEL__ -I/uClinux-dist/linux-2.4.x/include  -Wall -Wstrict-prototypes -Wno-trigraphs -O1 -g -fno-strict-aliasing -fno-common -I/usr/local/lib/gcc-lib/m68k-elf/2.95.3/./include -pipe -DNO_MM -DNO_FPU -m5200 -Wa,-S -Wa,-m5200 -D__ELF__ -DMAGIC_ROM_PTR -DUTS_SYSNAME="uClinux" -D__linux__   -nostdinc -I /usr/local/lib/gcc-lib/m68k-elf/2.95.3/include -DKBUILD_BASENAME=ide_features  -c -o ide-features.o ide-features.c
m68k-elf-gcc -fno-builtin -nostdinc -D__KERNEL__ -I/uClinux-dist/linux-2.4.x/include  -Wall -Wstrict-prototypes -Wno-trigraphs -O1 -g -fno-strict-aliasing -fno-common -I/usr/local/lib/gcc-lib/m68k-elf/2.95.3/./include -pipe -DNO_MM -DNO_FPU -m5200 -Wa,-S -Wa,-m5200 -D__ELF__ -DMAGIC_ROM_PTR -DUTS_SYSNAME="uClinux" -D__linux__   -nostdinc -I /usr/local/lib/gcc-lib/m68k-elf/2.95.3/include -DKBUILD_BASENAME=ide_taskfile  -c -o ide-taskfile.o ide-taskfile.c
m68k-elf-gcc -fno-builtin -nostdinc -D__KERNEL__ -I/uClinux-dist/linux-2.4.x/include  -Wall -Wstrict-prototypes -Wno-trigraphs -O1 -g -fno-strict-aliasing -fno-common -I/usr/local/lib/gcc-lib/m68k-elf/2.95.3/./include -pipe -DNO_MM -DNO_FPU -m5200 -Wa,-S -Wa,-m5200 -D__ELF__ -DMAGIC_ROM_PTR -DUTS_SYSNAME="uClinux" -D__linux__   -nostdinc -I /usr/local/lib/gcc-lib/m68k-elf/2.95.3/include -DKBUILD_BASENAME=ide_proc  -c -o ide-proc.o ide-proc.c
ide-proc.c: In function `proc_ide_read_imodel':
ide-proc.c:418: `ide_acorn' undeclared (first use in this function)
ide-proc.c:418: (Each undeclared identifier is reported only once
ide-proc.c:418: for each function it appears in.)
make[4]: *** [ide-proc.o] Error 1
make[4]: Leaving directory `/uClinux-dist/linux-2.4.x/drivers/ide'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/uClinux-dist/linux-2.4.x/drivers/ide'
make[2]: *** [_subdir_ide] Error 2
make[2]: Leaving directory `/uClinux-dist/linux-2.4.x/drivers'
make[1]: *** [_dir_drivers] Error 2
make[1]: Leaving directory `/uClinux-dist/linux-2.4.x'
make: *** [linux] Error 1
linux:/uClinux-dist #
--0-636671555-1046389689=:95697--
