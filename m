Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSIWNIx>; Mon, 23 Sep 2002 09:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbSIWNIx>; Mon, 23 Sep 2002 09:08:53 -0400
Received: from mail.emit.pl.108.205.195.in-addr.arpa ([195.205.108.125]:58629
	"EHLO mail.emit.pl") by vger.kernel.org with ESMTP
	id <S261264AbSIWNIv>; Mon, 23 Sep 2002 09:08:51 -0400
Date: Mon, 23 Sep 2002 15:18:20 +0200
From: Ian Carr-de Avelon <avelon@emit.pl>
Message-Id: <200209231318.g8NDIKA30432@mail.emit.pl>
Subject: 2.4.20-pre7 i486
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.4.20-pre7 fails for i486 (still a fer of them around) without 
Symmetric multi-processing support. With SMP support, the kernel compiles,
but resets immediately after boot.
This is with gcc 2.95.3
Yours
Ian
 
/usr/src/linux/include/linux/modules/ksyms.ver:548: warning: `del_timer_sync' redefined
/usr/src/linux/include/linux/timer.h:30: warning: this is the location of the previous definition
In file included from /usr/src/linux/include/linux/interrupt.h:45,
                 from ksyms.c:21:
/usr/src/linux/include/asm/hardirq.h:37: warning: `synchronize_irq' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:90: warning: this is the location of the previous definition
In file included from ksyms.c:17:
/usr/src/linux/include/linux/kernel_stat.h: In function `kstat_irqs':
/usr/src/linux/include/linux/kernel_stat.h:57: `smp_num_cpus' undeclared (first
use in this function)
/usr/src/linux/include/linux/kernel_stat.h:57: (Each undeclared identifier is reported only once
/usr/src/linux/include/linux/kernel_stat.h:57: for each function it appears in.)make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2

