Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263349AbTCNPU1>; Fri, 14 Mar 2003 10:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263358AbTCNPU1>; Fri, 14 Mar 2003 10:20:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51414 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263349AbTCNPUZ>; Fri, 14 Mar 2003 10:20:25 -0500
Date: Fri, 14 Mar 2003 16:31:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, Osamu Tomita <tomita@cinet.co.jp>
Subject: 2.5.64-ac4: mpparse.c doesn't compile
Message-ID: <20030314153107.GT16212@fs.tum.de>
References: <200303141509.h2EF9R017016@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303141509.h2EF9R017016@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  gcc -Wp,-MD,arch/i386/kernel/.mpparse.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=mpparse -DKBUILD_MODNAME=mpparse -c -o 
arch/i386/kernel/mpparse.o arch/i386/kernel/mpparse.c
arch/i386/kernel/mpparse.c: In function `get_smp_config':
arch/i386/kernel/mpparse.c:658: `pc98' undeclared (first use in this function)
arch/i386/kernel/mpparse.c:658: (Each undeclared identifier is reported only once
arch/i386/kernel/mpparse.c:658: for each function it appears in.)
make[1]: *** [arch/i386/kernel/mpparse.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

