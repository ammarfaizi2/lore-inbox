Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbRAFTbE>; Sat, 6 Jan 2001 14:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132739AbRAFTaz>; Sat, 6 Jan 2001 14:30:55 -0500
Received: from [156.46.206.66] ([156.46.206.66]:60683 "EHLO eagle.netwrx1.com")
	by vger.kernel.org with ESMTP id <S131047AbRAFTao>;
	Sat, 6 Jan 2001 14:30:44 -0500
From: "George R. Kasica" <georgek@netwrx1.com>
To: linux-kernel@vger.kernel.org
Subject: Cannot compile 2.2.18
Date: Sat, 06 Jan 2001 13:30:42 -0600
Organization: Netwrx Consulting Inc.
Reply-To: georgek@netwrx1.com
Message-ID: <pdse5t875jp4agj2e03s2p5mv31eg6cheo@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

Since 2.4.0 is being a pig here I thought I'd go back and recompile
2.2.18 and place the whole tree someplace safe (ie burn a
CD)....well...now I can't compile 2.2.18 (did a tar xvf so I have a
fresh source tree) either....here's what I get with a 

make mrproper
make dep
make config
make bzImage

>cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-fr
>ame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=
>2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -c -o kmod.o kmod.c
>rm -f kernel.o
>ld -m elf_i386  -r -o kernel.o signal.o ksyms.o sched.o dma.o fork.o exec_domain
>.o panic.o printk.o sys.o module.o exit.o itimer.o info.o time.o softirq.o resou
>rce.o sysctl.o acct.o capability.o kmod.o
>ld: cannot open input file elf_i386
>make[2]: *** [kernel.o] Error 2
>make[2]: Leaving directory `/usr/src/linux/kernel'
>make[1]: *** [first_rule] Error 2
>make[1]: Leaving directory `/usr/src/linux/kernel'
>make: *** [_dir_kernel] Error 2


Any help is urgently needed.

George

===[George R. Kasica]===        +1 262 513 8503
President                       +1 206 374 6482 FAX 
Netwrx Consulting Inc.          Waukesha, WI USA 
http://www.netwrx1.com
georgek@netwrx1.com
ICQ #12862186
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
