Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSKRJB0>; Mon, 18 Nov 2002 04:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSKRJB0>; Mon, 18 Nov 2002 04:01:26 -0500
Received: from gzp11.gzp.hu ([212.40.96.53]:13325 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id <S261733AbSKRJBZ>;
	Mon, 18 Nov 2002 04:01:25 -0500
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: Linux v2.5.48
References: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
Organization: Who, me?
User-Agent: tin/1.5.15-20021115 ("Spiders") (UNIX) (Linux/2.4.20-rc1 (i686))
Message-ID: <66aa.3dd8ae09.31d44@gzp1.gzp.hu>
Date: Mon, 18 Nov 2002 09:08:25 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 2.95.4
GNU ld version 2.12.90.0.15 20020717

make -f scripts/Makefile.build obj=fs/devfs
  gcc -Wp,-MD,fs/devfs/.base.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=base -DKBUILD_MODNAME=devfs -DEXPORT_SYMTAB  -c -o fs/devfs/base.o fs/devfs/base.c
fs/devfs/base.c: In function `devfs_symlink':
fs/devfs/base.c:3032: incompatible types in assignment
fs/devfs/base.c:3033: incompatible types in assignment
fs/devfs/base.c:3034: incompatible types in assignment
fs/devfs/base.c: In function `devfs_mkdir':
fs/devfs/base.c:3063: incompatible types in assignment
fs/devfs/base.c:3064: incompatible types in assignment
fs/devfs/base.c:3065: incompatible types in assignment
fs/devfs/base.c: In function `devfs_mknod':
fs/devfs/base.c:3132: incompatible types in assignment
fs/devfs/base.c:3133: incompatible types in assignment
fs/devfs/base.c:3134: incompatible types in assignment
make[3]: *** [fs/devfs/base.o] Error 1
make[2]: *** [fs/devfs] Error 2
make[1]: *** [fs] Error 2
make: *** [vmlinux] Error 2

