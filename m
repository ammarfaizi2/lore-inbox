Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262912AbSKEA0r>; Mon, 4 Nov 2002 19:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbSKEA0r>; Mon, 4 Nov 2002 19:26:47 -0500
Received: from air-2.osdl.org ([65.172.181.6]:23745 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262912AbSKEA0q>;
	Mon, 4 Nov 2002 19:26:46 -0500
Date: Mon, 4 Nov 2002 16:29:01 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.46 jfs compile error
Message-ID: <Pine.LNX.4.33L2.0211041628020.12851-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  gcc -Wp,-MD,fs/jfs/.super.o.d -D__KERNEL__ -Iinclude -Wall
  -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
  -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
  -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
  -D_JFS_4K  -DKBUILD_BASENAME=super   -c -o fs/jfs/super.o
  fs/jfs/super.c
  fs/jfs/super.c:31:21: jfs_acl.h: No such file or directory
  make[2]: *** [fs/jfs/super.o] Error 1
  make[1]: *** [fs/jfs] Error 2
  make: *** [fs] Error 2

-- 
~Randy

