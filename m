Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131010AbRCJLMb>; Sat, 10 Mar 2001 06:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131011AbRCJLMW>; Sat, 10 Mar 2001 06:12:22 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:34577 "HELO
	mail5.speakeasy.net") by vger.kernel.org with SMTP
	id <S131010AbRCJLME>; Sat, 10 Mar 2001 06:12:04 -0500
Message-ID: <3AAA0F21.51EB55B2@speakeasy.org>
Date: Sat, 10 Mar 2001 06:25:21 -0500
From: root <jellison@speakeasy.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Problem at Kernel Configuring!!!!]
Content-Type: multipart/mixed;
 boundary="------------721253C5FF3B9F9112C29803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------721253C5FF3B9F9112C29803
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------721253C5FF3B9F9112C29803
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3AAA0E52.B162C69B@speakeasy.org>
Date: Sat, 10 Mar 2001 06:21:54 -0500
From: root <jellison@speakeasy.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.or
Subject: Problem at Kernel Configuring!!!!
Content-Type: multipart/mixed;
 boundary="------------8EDC2C7B42F86D78B4F89E14"

This is a multi-part message in MIME format.
--------------8EDC2C7B42F86D78B4F89E14
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I am sending an output the last part kernel configuring. I have read and
applied "Changes" which went successful. In configuring kernel, I did
make xconfig, make dep, and make clean which was successful.
But when I did a "make bzImage" that when I ran into problems.  "Make
bzImage" stop with an error.

I am using Athlon 700mg/hz, 15g HD.  I  am running kernel  2.2.16 and
distributor is Redhat.

Could this be a bug in the new 2.4.2?

My email address is jellison@speakeasy.org

Thanks,

Jonathan Ellison

--------------8EDC2C7B42F86D78B4F89E14
Content-Type: text/plain; charset=us-ascii;
 name="nohup.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nohup.out"

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=athlon    -c -o init/main.o init/main.c
In file included from /usr/src/linux/include/linux/irq.h:58,
                 from /usr/src/linux/include/asm/hardirq.h:7,
                 from /usr/src/linux/include/linux/interrupt.h:46,
                 from /usr/src/linux/include/asm/string.h:297,
                 from /usr/src/linux/include/linux/string.h:22,
                 from /usr/src/linux/include/linux/fs.h:24,
                 from /usr/src/linux/include/linux/capability.h:18,
                 from /usr/src/linux/include/linux/binfmts.h:6,
                 from /usr/src/linux/include/linux/sched.h:10,
                 from /usr/src/linux/include/linux/mm.h:5,
                 from /usr/src/linux/include/linux/slab.h:15,
                 from /usr/src/linux/include/linux/proc_fs.h:6,
                 from init/main.c:16:
/usr/src/linux/include/asm/hw_irq.h: In function `x86_do_profile':
/usr/src/linux/include/asm/hw_irq.h:198: `current' undeclared (first use in this function)
/usr/src/linux/include/asm/hw_irq.h:198: (Each undeclared identifier is reported only once
/usr/src/linux/include/asm/hw_irq.h:198: for each function it appears in.)
In file included from /usr/src/linux/include/asm/string.h:297,
                 from /usr/src/linux/include/linux/string.h:22,
                 from /usr/src/linux/include/linux/fs.h:24,
                 from /usr/src/linux/include/linux/capability.h:18,
                 from /usr/src/linux/include/linux/binfmts.h:6,
                 from /usr/src/linux/include/linux/sched.h:10,
                 from /usr/src/linux/include/linux/mm.h:5,
                 from /usr/src/linux/include/linux/slab.h:15,
                 from /usr/src/linux/include/linux/proc_fs.h:6,
                 from init/main.c:16:
/usr/src/linux/include/linux/interrupt.h: In function `raise_softirq':
/usr/src/linux/include/linux/interrupt.h:89: `current' undeclared (first use in this function)
/usr/src/linux/include/linux/interrupt.h: In function `tasklet_schedule':
/usr/src/linux/include/linux/interrupt.h:160: `current' undeclared (first use in this function)
/usr/src/linux/include/linux/interrupt.h: In function `tasklet_hi_schedule':
/usr/src/linux/include/linux/interrupt.h:174: `current' undeclared (first use in this function)
In file included from /usr/src/linux/include/linux/string.h:22,
                 from /usr/src/linux/include/linux/fs.h:24,
                 from /usr/src/linux/include/linux/capability.h:18,
                 from /usr/src/linux/include/linux/binfmts.h:6,
                 from /usr/src/linux/include/linux/sched.h:10,
                 from /usr/src/linux/include/linux/mm.h:5,
                 from /usr/src/linux/include/linux/slab.h:15,
                 from /usr/src/linux/include/linux/proc_fs.h:6,
                 from init/main.c:16:
/usr/src/linux/include/asm/string.h: In function `__constant_memcpy3d':
/usr/src/linux/include/asm/string.h:305: `current' undeclared (first use in this function)
/usr/src/linux/include/asm/string.h: In function `__memcpy3d':
/usr/src/linux/include/asm/string.h:312: `current' undeclared (first use in this function)
In file included from /usr/src/linux/include/linux/raid/md.h:51,
                 from init/main.c:25:
/usr/src/linux/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux/include/linux/raid/md_k.h:39: warning: control reaches end of non-void function
make: *** [init/main.o] Error 1
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=athlon    -c -o init/main.o init/main.c
In file included from /usr/src/linux/include/linux/irq.h:58,
                 from /usr/src/linux/include/asm/hardirq.h:7,
                 from /usr/src/linux/include/linux/interrupt.h:46,
                 from /usr/src/linux/include/asm/string.h:297,
                 from /usr/src/linux/include/linux/string.h:22,
                 from /usr/src/linux/include/linux/fs.h:24,
                 from /usr/src/linux/include/linux/capability.h:18,
                 from /usr/src/linux/include/linux/binfmts.h:6,
                 from /usr/src/linux/include/linux/sched.h:10,
                 from /usr/src/linux/include/linux/mm.h:5,
                 from /usr/src/linux/include/linux/slab.h:15,
                 from /usr/src/linux/include/linux/proc_fs.h:6,
                 from init/main.c:16:
/usr/src/linux/include/asm/hw_irq.h: In function `x86_do_profile':
/usr/src/linux/include/asm/hw_irq.h:198: `current' undeclared (first use in this function)
/usr/src/linux/include/asm/hw_irq.h:198: (Each undeclared identifier is reported only once
/usr/src/linux/include/asm/hw_irq.h:198: for each function it appears in.)
In file included from /usr/src/linux/include/asm/string.h:297,
                 from /usr/src/linux/include/linux/string.h:22,
                 from /usr/src/linux/include/linux/fs.h:24,
                 from /usr/src/linux/include/linux/capability.h:18,
                 from /usr/src/linux/include/linux/binfmts.h:6,
                 from /usr/src/linux/include/linux/sched.h:10,
                 from /usr/src/linux/include/linux/mm.h:5,
                 from /usr/src/linux/include/linux/slab.h:15,
                 from /usr/src/linux/include/linux/proc_fs.h:6,
                 from init/main.c:16:
/usr/src/linux/include/linux/interrupt.h: In function `raise_softirq':
/usr/src/linux/include/linux/interrupt.h:89: `current' undeclared (first use in this function)
/usr/src/linux/include/linux/interrupt.h: In function `tasklet_schedule':
/usr/src/linux/include/linux/interrupt.h:160: `current' undeclared (first use in this function)
/usr/src/linux/include/linux/interrupt.h: In function `tasklet_hi_schedule':
/usr/src/linux/include/linux/interrupt.h:174: `current' undeclared (first use in this function)
In file included from /usr/src/linux/include/linux/string.h:22,
                 from /usr/src/linux/include/linux/fs.h:24,
                 from /usr/src/linux/include/linux/capability.h:18,
                 from /usr/src/linux/include/linux/binfmts.h:6,
                 from /usr/src/linux/include/linux/sched.h:10,
                 from /usr/src/linux/include/linux/mm.h:5,
                 from /usr/src/linux/include/linux/slab.h:15,
                 from /usr/src/linux/include/linux/proc_fs.h:6,
                 from init/main.c:16:
/usr/src/linux/include/asm/string.h: In function `__constant_memcpy3d':
/usr/src/linux/include/asm/string.h:305: `current' undeclared (first use in this function)
/usr/src/linux/include/asm/string.h: In function `__memcpy3d':
/usr/src/linux/include/asm/string.h:312: `current' undeclared (first use in this function)
In file included from /usr/src/linux/include/linux/raid/md.h:51,
                 from init/main.c:25:
/usr/src/linux/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux/include/linux/raid/md_k.h:39: warning: control reaches end of non-void function
make: *** [init/main.o] Error 1














--------------8EDC2C7B42F86D78B4F89E14--


--------------721253C5FF3B9F9112C29803--

