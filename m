Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSKRGG3>; Mon, 18 Nov 2002 01:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSKRGG3>; Mon, 18 Nov 2002 01:06:29 -0500
Received: from rivmkt61.wintek.com ([206.230.0.61]:23168 "EHLO comcast.net")
	by vger.kernel.org with ESMTP id <S261518AbSKRGG2>;
	Mon, 18 Nov 2002 01:06:28 -0500
Date: Mon, 18 Nov 2002 01:16:03 +0000 (UTC)
From: Alex Goddard <agoddard@purdue.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.5.48 Compilation Failure
Message-ID: <Pine.LNX.4.44.0211180113460.22038-100000@dust.ebiz-gw.wintek.com>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During make bzImage:

gcc -Wp,-MD,fs/devfs/.base.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=base -DKBUILD_MODNAME=devfs -DEXPORT_SYMTAB -c -o
fs/devfs/base.o fs/devfs/base.c
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
make[2]: *** [fs/devfs/base.o] Error 1
make[1]: *** [fs/devfs] Error 2
make: *** [fs] Error 2

I'm unsure of exactly what other information would be needed by whomever 
will go after this, but just say something and I'll send what you want.

-- 
Alex Goddard
agoddard@purdue.edu

