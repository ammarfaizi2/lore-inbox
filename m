Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132016AbQLJADb>; Sat, 9 Dec 2000 19:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131989AbQLJADV>; Sat, 9 Dec 2000 19:03:21 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:41736 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131103AbQLJADO>; Sat, 9 Dec 2000 19:03:14 -0500
Date: Sat, 9 Dec 2000 18:33:33 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: John Summerfield <summer@OS2.ami.com.au>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.0-test11 does not build:
In-Reply-To: <200012091233.eB9CW7Z27402@emu.os2.ami.com.au>
Message-ID: <Pine.LNX.4.30.0012091832330.620-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, John Summerfield wrote:

>/usr/src/linux/include/linux/modules/irmod.ver:139: warning: this is the
>location of the previous definition
>/usr/src/linux/include/linux/modules/irsyms.ver:145: warning:
>`__ver_irda_task_kick' redefined
>/usr/src/linux/include/linux/modules/irmod.ver:141: warning: this is the
>location of the previous definition
>/usr/src/linux/include/linux/modules/irsyms.ver:147: warning:
>`__ver_irda_task_next_state' redefined
>/usr/src/linux/include/linux/modules/irmod.ver:143: warning: this is the
>location of the previous definition
>/usr/src/linux/include/linux/modules/irsyms.ver:149: warning:
>`__ver_irda_task_delete' redefined
>/usr/src/linux/include/linux/modules/irmod.ver:145: warning: this is the
>location of the previous definition
>/usr/src/linux/include/linux/modules/irsyms.ver:151: warning:
>`__ver_async_wrap_skb' redefined
>/usr/src/linux/include/linux/modules/irmod.ver:147: warning: this is the
>location of the previous definition
>/usr/src/linux/include/linux/modules/irsyms.ver:153: warning:
>`__ver_async_unwrap_char' redefined
>/usr/src/linux/include/linux/modules/irmod.ver:149: warning: this is the
>location of the previous definition
>In file included from /usr/src/linux/include/linux/modversions.h:40,
>                 from /usr/src/linux/include/linux/module.h:21,
>                 from ksyms.c:14:
>/usr/src/linux/include/linux/modules/ksyms.ver:504: warning: `del_timer_sync'
>redefined
>/usr/src/linux/include/linux/timer.h:34: warning: this is the location of the
>previous definition
>In file included from /usr/src/linux/include/linux/interrupt.h:45,
>                 from ksyms.c:21:
>/usr/src/linux/include/asm/hardirq.h:37: warning: `synchronize_irq' redefined
>/usr/src/linux/include/linux/modules/i386_ksyms.ver:84: warning: this is the
>location of the previous definition
>In file included from ksyms.c:17:
>/usr/src/linux/include/linux/kernel_stat.h: In function `kstat_irqs':
>/usr/src/linux/include/linux/kernel_stat.h:48: `smp_num_cpus' undeclared
>(first use in this function)
>/usr/src/linux/include/linux/kernel_stat.h:48: (Each undeclared identifier is
>reported only once
>/usr/src/linux/include/linux/kernel_stat.h:48: for each function it appears
>in.)
>make[2]: *** [ksyms.o] Error 1
>make[2]: Leaving directory `/usr/src/linux/kernel'
>make[1]: *** [first_rule] Error 2
>make[1]: Leaving directory `/usr/src/linux/kernel'
>make: *** [_dir_kernel] Error 2
>[summer@possum linux]$
>
>I HAVE built this kernel for another computer. I was having problems with
>this, so I remove the .config, created a new one with "make oldconfig" and the
>customised with make xconfig"

Try doing a "make distclean" or "make mrproper" first.  Are you
using kgcc?


----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

If you're interested in computer security, and want to stay on top of the
latest security exploits, and other information, visit:

http://www.securityfocus.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
