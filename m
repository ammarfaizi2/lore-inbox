Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRFWXqk>; Sat, 23 Jun 2001 19:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264026AbRFWXqa>; Sat, 23 Jun 2001 19:46:30 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:50184 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id <S263999AbRFWXqP>; Sat, 23 Jun 2001 19:46:15 -0400
Message-ID: <000f01c0fc3e$b13498c0$d55355c2@microsoft>
From: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
To: <linux-kernel@vger.kernel.org>
Subject: GCC3.0 support: Kernel 2.4.5 compilation troubles
Date: Sun, 24 Jun 2001 03:46:15 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2488.0001
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2488.0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!
trying to compile kernel I got following:

make bzImage

make[2]: Entering directory `/usr/src/linux/arch/i386/lib'
/usr/src/linux/scripts/mkdep -D__KERNEL__ -I/usr/src/linux/include -Wall -Ws
trict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mprefe
rred-stack-boundary=2 -march=i686  -- checksum.S dec_and_lock.c delay.c
getuser.S iodebug.c memcpy.c mmx.c old-checksum.c putuser.S strstr.c
usercopy.c > .depend
make[2]: Leaving directory `/usr/src/linux/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686   -c -o init/main.o init/main.c
In file included from /usr/src/linux/include/net/checksum.h:33,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from init/main.c:24:
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:105:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:105:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:105:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:121:13: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:121:13: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:121:13: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:121:13: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:121:13: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string
literals are deprecated
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686  -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
make
CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
 -march=i686 " -C  kernel
make[1]: Entering directory `/usr/src/linux/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -fno-omit-frame-pointer -c -o sched.o sched.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o dma.o dma.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o fork.o fork.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o exec_domain.o exec_domain.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o panic.o panic.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o printk.o printk.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o module.o module.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o exit.o exit.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o itimer.o itimer.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o info.o info.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o time.o time.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o softirq.o softirq.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o resource.o resource.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o sysctl.o sysctl.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o acct.o acct.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o capability.o capability.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o ptrace.o ptrace.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -ma
rch=i686    -c -o timer.o timer.c
timer.c:35: conflicting types for `xtime'
/usr/src/linux/include/linux/sched.h:540: previous declaration of `xtime'
make[2]: *** [timer.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2


Best regards,
Alexander         mailto:dmor@7ka.mipt.ru

