Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270318AbSISIB5>; Thu, 19 Sep 2002 04:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270348AbSISIBi>; Thu, 19 Sep 2002 04:01:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59638 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S270318AbSISIBe>; Thu, 19 Sep 2002 04:01:34 -0400
Date: Thu, 19 Sep 2002 10:06:34 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>, Dominik Brodowski <devel@brodo.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre7-ac2
In-Reply-To: <200209182133.g8ILXhk08396@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0209191003250.15721-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Alan Cox wrote:

>...
> Linux 2.4.20-pre7-ac1
>...
> o	CPUfreq update					(Dominik Brodowski)
>...

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc
-iwithprefix include -DKBUILD_BASENAME=cpufreq  -c -o cpufreq.o cpufreq.c
In file included from
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/linux/irq.h:69,
                 from
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/asm/hardirq.h:6,
                 from
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/linux/interrupt.h:45,
                 from cpufreq.c:21:
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/asm/hw_irq.h: In
function `x86_do_profile':
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/asm/hw_irq.h:201:
`current' undeclared (first use in this function)
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/asm/hw_irq.h:201:
(Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/asm/hw_irq.h:201:
for each function it appears in.)
make[2]: *** [cpufreq.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.19-full/kernel'

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

