Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291948AbSBTQAv>; Wed, 20 Feb 2002 11:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291952AbSBTQAb>; Wed, 20 Feb 2002 11:00:31 -0500
Received: from 213-97-45-174.uc.nombres.ttd.es ([213.97.45.174]:47879 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id <S291948AbSBTQAZ>;
	Wed, 20 Feb 2002 11:00:25 -0500
Date: Wed, 20 Feb 2002 17:00:15 +0100 (CET)
From: Pau Aliagas <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.5 fails to compile
Message-ID: <Pine.LNX.4.44.0202201658300.1941-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/asm/thread_info.h:13,
from /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/linux/thread_info.h:10,
from /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/linux/spinlock.h:7,
from /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/linux/mmzone.h:8,
from /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/linux/gfp.h:4,
from /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/linux/slab.h:14,
from /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/linux/proc_fs.h:5,
from init/main.c:15: /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/asm/processor.h:
In  function `thread_saved_pc': /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/asm/processor.h:444: 
dereferencing pointer to incomplete type /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/asm/processor.h:445: 
warning: control reaches end of non-void function
make[1]: *** [init/main.o] Error 1
make[1]: Leaving directory `/home/pau/LnxZip/RPM/BUILD/kernel-2.5.4'
 -- 

Pau

