Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbSKZBPp>; Mon, 25 Nov 2002 20:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbSKZBPp>; Mon, 25 Nov 2002 20:15:45 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:10923 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265901AbSKZBPp>; Mon, 25 Nov 2002 20:15:45 -0500
Date: Mon, 25 Nov 2002 20:15:52 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.49-ac1 : apic_sis_bug undeclared
Message-ID: <Pine.LNX.4.44.0211252008380.1805-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While 'make bzImage', I received the following error.
Regards,
Frank

  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make -f scripts/Makefile.build obj=init
  gcc -Wp,-MD,init/.main.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -p -Iarch/i386/mach-generic -Iarch/i386/mach-defaults -nostdinc -iwithprefix include    -DKBUILD_BASENAME=main -DKBUILD_MODNAME=main   -c -o init/main.o init/main.c
In file included from include/asm/smp.h:19,
                 from include/linux/smp.h:16,
                 from include/linux/sched.h:22,
                 from include/linux/smp_lock.h:5,
                 from init/main.c:24:
include/asm/io_apic.h: In function `io_apic_modify':
include/asm/io_apic.h:128: `apic_sis_bug' undeclared (first use in this function)
include/asm/io_apic.h:128: (Each undeclared identifier is reported only once
include/asm/io_apic.h:128: for each function it appears in.)
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

