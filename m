Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbSIXTPL>; Tue, 24 Sep 2002 15:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbSIXTPL>; Tue, 24 Sep 2002 15:15:11 -0400
Received: from math.ut.ee ([193.40.5.125]:35250 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S261756AbSIXTPL>;
	Tue, 24 Sep 2002 15:15:11 -0400
Date: Tue, 24 Sep 2002 22:20:24 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: compile error in brlvger.c (2.4.20-pre7+bk)
Message-ID: <Pine.GSO.4.44.0209242219030.18070-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-pre7+current BK as of yesterday, on PowerPC.

gcc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/home/mroos/compile/linux-2.4/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DMODULE -DMODVERSIONS -include /home/mroos/compile/linux-2.4/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=brlvger  -c -o brlvger.o brlvger.c
brlvger.c: In function `brlvger_cleanup':
brlvger.c:275: parse error before `)'
brlvger.c: In function `intr_callback':
brlvger.c:850: parse error before `)'
brlvger.c:860: parse error before `)'

-- 
Meelis Roos (mroos@linux.ee)

