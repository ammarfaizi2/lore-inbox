Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287617AbSAEIwb>; Sat, 5 Jan 2002 03:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287618AbSAEIwU>; Sat, 5 Jan 2002 03:52:20 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:51210 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287617AbSAEIwG>; Sat, 5 Jan 2002 03:52:06 -0500
Subject: 2.5.2-pre8 -- reiserfs compilation errors
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.04.17.55 (Preview Release)
Date: 05 Jan 2002 00:52:22 -0800
Message-Id: <1010220743.21181.4.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -c -o procfs.o procfs.c
procfs.c: In function `reiserfs_version_in_proc':
procfs.c:80: conversion to non-scalar type requested
procfs.c: In function `reiserfs_super_in_proc':
procfs.c:137: conversion to non-scalar type requested
procfs.c: In function `reiserfs_per_level_in_proc':
procfs.c:217: conversion to non-scalar type requested
procfs.c: In function `reiserfs_bitmap_in_proc':
procfs.c:296: conversion to non-scalar type requested
procfs.c: In function `reiserfs_on_disk_super_in_proc':
procfs.c:337: conversion to non-scalar type requested
procfs.c: In function `reiserfs_oidmap_in_proc':
procfs.c:390: conversion to non-scalar type requested
procfs.c: In function `reiserfs_journal_in_proc':
procfs.c:441: conversion to non-scalar type requested
procfs.c:494: incompatible type for argument 1 of `bdevname'
procfs.c: In function `reiserfs_proc_register':
procfs.c:581: aggregate value used where an integer was expected
make[3]: *** [procfs.o] Error 1
make[3]: Leaving directory `/usr/src/linux/fs/reiserfs'

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y

Gnu C                  3.0.3
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.23
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Linux C++ Library      3.0.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0


