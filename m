Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130539AbRAaQnp>; Wed, 31 Jan 2001 11:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131234AbRAaQnh>; Wed, 31 Jan 2001 11:43:37 -0500
Received: from 3ff8be8d.dsl.flashcom.net ([63.248.190.141]:7940 "EHLO
	vader.supremedesigns.com") by vger.kernel.org with ESMTP
	id <S130539AbRAaQnW>; Wed, 31 Jan 2001 11:43:22 -0500
Message-ID: <3A7840C8.17841498@supremedesigns.com>
Date: Wed, 31 Jan 2001 11:43:52 -0500
From: Lukasz Gogolewski <lucas@supremedesigns.com>
Organization: SupremeDesigns
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem with compiling kernel 2.4.1 on top of 2.2.14
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just recently I've tried to compile kernel 2.4.1 on my RH 6.2 machine
that runs 2.2.14.
All my utilities needed in order to compile that kernel are up to date.

When I got thru xmake config and I configure all the options. I try to
compile it.

When I do make dep I dont' get any error messages.

When I do either make bzImage or make zImage I get the following errors
at the very beginning:


                 from /usr/src/linux/include/asm/hardirq.h:6,
                 from /usr/src/linux/include/linux/interrupt.h:45,
                 from /usr/src/linux/include/asm/string.h:296,
                 from /usr/src/linux/include/linux/string.h:21,
                 from /usr/src/linux/include/linux/fs.h:23,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/asm/hw_irq.h:198: `current' undeclared (first use
in this function)
/usr/src/linux/include/asm/hw_irq.h:198: (Each undeclared identifier is
reported only once
/usr/src/linux/include/asm/hw_irq.h:198: for each function it appears
in.)
/usr/src/linux/include/linux/interrupt.h: In function `raise_softirq':
In file included from /usr/src/linux/include/asm/string.h:296,
                 from /usr/src/linux/include/linux/string.h:21,
                 from /usr/src/linux/include/linux/fs.h:23,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/linux/interrupt.h:89: `current' undeclared (first
use in this function)
/usr/src/linux/include/linux/interrupt.h: In function
`tasklet_schedule':
/usr/src/linux/include/linux/interrupt.h:160: `current' undeclared
(first use in this function)
/usr/src/linux/include/linux/interrupt.h: In function
`tasklet_hi_schedule':
/usr/src/linux/include/linux/interrupt.h:174: `current' undeclared
(first use in this function)
/usr/src/linux/include/asm/string.h: In function `__constant_memcpy3d':
In file included from /usr/src/linux/include/linux/string.h:21,
                 from /usr/src/linux/include/linux/fs.h:23,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/asm/string.h:305: `current' undeclared (first use
in this function)
/usr/src/linux/include/asm/string.h: In function `__memcpy3d':
/usr/src/linux/include/asm/string.h:312: `current' undeclared (first use
in this function)
make: *** [init/main.o] Error 1

This is just a part of the error messages that appear. It happens at the
very beginning.
Can someone help. I don't know what I'm doing wrong. Since in the past
I've compiled kernel 2.4.0
w/o any problems. I even reinstalled RH 6.2 just to make sure that
everything is clean prior to compiling kernel 2.4.1

Someone please help. I need my USB and Sound Card to work.

Thanks,

- Lucas


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
