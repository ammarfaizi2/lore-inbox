Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267727AbSLGFTB>; Sat, 7 Dec 2002 00:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267730AbSLGFTB>; Sat, 7 Dec 2002 00:19:01 -0500
Received: from bitmover.com ([192.132.92.2]:3548 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267727AbSLGFTB>;
	Sat, 7 Dec 2002 00:19:01 -0500
Date: Fri, 6 Dec 2002 21:26:34 -0800
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200212070526.gB75QYY32603@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: one more in cyclades
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.build obj=drivers/char
  gcc -Wp,-MD,drivers/char/.consolemap_deftbl.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=consolemap_deftbl -DKBUILD_MODNAME=consolemap_deftbl   -c -o drivers/char/consolemap_deftbl.o drivers/char/consolemap_deftbl.c
  gcc -Wp,-MD,drivers/char/.defkeymap.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=defkeymap -DKBUILD_MODNAME=defkeymap   -c -o drivers/char/defkeymap.o drivers/char/defkeymap.c
  gcc -Wp,-MD,drivers/char/.cyclades.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=cyclades -DKBUILD_MODNAME=cyclades   -c -o drivers/char/cyclades.o drivers/char/cyclades.c
drivers/char/cyclades.c:887: parse error before `}'
make[2]: *** [drivers/char/cyclades.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2
