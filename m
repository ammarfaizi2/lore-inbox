Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSHKN3W>; Sun, 11 Aug 2002 09:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318300AbSHKN3W>; Sun, 11 Aug 2002 09:29:22 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:64929 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S318299AbSHKN3W>;
	Sun, 11 Aug 2002 09:29:22 -0400
Date: Sun, 11 Aug 2002 16:33:07 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19+bk does not compile - partition stuff
Message-ID: <Pine.GSO.4.43.0208111631230.22083-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[3]: Entering directory `/home/mroos/compile/linux-2.4/fs/partitions'
sparc64-linux-gcc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs-nostdinc -I /usr/lib/gcc-lib/sparc64-linux/egcs-2.92.11/include -DKBUILD_BASENAME=check  -DEXPORT_SYMTAB -c check.c
check.c: In function `devfs_register_disc':
check.c:328: structure has no member named `number'
check.c:329: structure has no member named `number'
check.c: In function `devfs_register_partitions':
check.c:361: structure has no member named `number'

current linux-2.4 from BK, sparc64.

-- 
Meelis Roos (mroos@linux.ee)

