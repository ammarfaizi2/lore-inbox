Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSKRMaF>; Mon, 18 Nov 2002 07:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSKRMaF>; Mon, 18 Nov 2002 07:30:05 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:32782 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S261868AbSKRMaD>;
	Mon, 18 Nov 2002 07:30:03 -0500
From: Rene Blokland <reneb@orac.aais.org>
Subject: 2.5.48 Compilation Failure skbuff.c
Date: Mon, 18 Nov 2002 13:36:48 +0100
Organization: Cistron
Message-ID: <slrnathnn0.aas.reneb@orac.aais.org>
Reply-To: reneb@cistron.nl
X-Trace: ncc1701.cistron.net 1037623023 23520 195.64.94.30 (18 Nov 2002 12:37:03 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 2.5.48 Doesn't compile for me on a AMD k6-3 with gcc-3.2 and glibc-2.3.1

make -f scripts/Makefile.build obj=net/core
  gcc -Wp,-MD,net/core/.skbuff.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=skbuff -DKBUILD_MODNAME=skbuff   -c -o net/core/skbuff.o
net/core/skbuff.c
In file included from include/net/xfrm.h:6,
                 from net/core/skbuff.c:61:
include/linux/crypto.h: In function `crypto_tfm_alg_modname':
include/linux/crypto.h:202: dereferencing pointer to incomplete type
make[2]: *** [net/core/skbuff.o] Error 1
make[1]: *** [net/core] Error 2
make: *** [net] Error 2

Any comments?

-- 
Groeten / Regards, Rene J. Blokland


