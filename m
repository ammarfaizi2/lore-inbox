Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129221AbQKDXIW>; Sat, 4 Nov 2000 18:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbQKDXIM>; Sat, 4 Nov 2000 18:08:12 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:17413 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129221AbQKDXIG>;
	Sat, 4 Nov 2000 18:08:06 -0500
Message-ID: <3A0496B5.3B298B6F@mandrakesoft.com>
Date: Sat, 04 Nov 2000 18:07:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: bcorsello@usa.net
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  kernel oops on boot in 2.4.0 test10
In-Reply-To: <0d19638042204b0NYCSMTP1@nyc.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Corsello wrote:
> 
> [1.] One line summary of the problem:
>         kernel oops on boot in 2.4.0 test 10 (i386)
> 
> [2.] Full description of the problem/report:
>         On every boot of test 10, I get a kernel oops very early on.
>         Is reproducible (happens every boot).
>         I've successfully booted 2.3 kernels on this machine, but get this
>         kernel oops on boot every time with the later 2.4.0tests (from about
>         test5 on -- that's from memory, may not be accurate).
>         I am successfully running a late 2.2 kernel:  Linux version 2.2.15-4mdk
> (chmou@kenobi.mandrakesoft.com) (gcc version 2.95.3 19991030 (prerelease)) #1
> Wed May 10 15:31:30 CEST 2000

Can you play the kernel shuffle, and narrow down exactly which kernel
version breaks for you?  Read, from the linux source tree,
Documentation/BUG-HUNTING.


> [5.] Output of Oops.. message (if applicable) with symbolic information =
>      resolved (see Documentation/oops-tracing.txt)
> ksymoops 2.3.4 on i586 2.2.15-4mdk.  Options used
>      -v /usr/src/linux/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -O (specified)
>      -m /usr/src/linux/System.map (specified)

Are you certain you used the correct vmlinux and System.map here?  Can
you present your .config for kernel building?

> Trace; c0194d36 <isapnp_proc_attach_device+36/94>

Do you have any ISAPNP cards in your system?

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
