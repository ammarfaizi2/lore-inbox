Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289609AbSAWBLN>; Tue, 22 Jan 2002 20:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289610AbSAWBKx>; Tue, 22 Jan 2002 20:10:53 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:3338 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289609AbSAWBKm>; Tue, 22 Jan 2002 20:10:42 -0500
Subject: 3.5.3-pre3 -- procfs.c:80: In function `reiserfs_version_in_proc':
	conversion to non-scalar type requested
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 22 Jan 2002 17:09:42 -0800
Message-Id: <1011748183.24310.18.camel@stomata.megapathdsl.net>
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


