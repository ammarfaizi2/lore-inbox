Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273918AbRJNDur>; Sat, 13 Oct 2001 23:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274055AbRJNDuh>; Sat, 13 Oct 2001 23:50:37 -0400
Received: from mail.ask.ne.jp ([203.179.96.3]:57837 "EHLO mail.ask.ne.jp")
	by vger.kernel.org with ESMTP id <S273918AbRJNDuU>;
	Sat, 13 Oct 2001 23:50:20 -0400
Date: Sun, 14 Oct 2001 12:50:43 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: David Ronis <ronis@montroll.chem.mcgill.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module Build Failure in 2.4.12
Message-Id: <20011014125043.4031e6d8.bruce@ask.ne.jp>
In-Reply-To: <200110140325.f9E3Pttt002153@montroll.chem.mcgill.ca>
In-Reply-To: <200110140325.f9E3Pttt002153@montroll.chem.mcgill.ca>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001 23:25:55 -0400
David Ronis <ronis@montroll.chem.mcgill.ca> wrote:

> I've been trying to build 2.4.12 on an i586-linux-gnu box [an out of the 
> package Slackware8.0 system].  The build fails in building the parport
> driver
> module.  Specfically:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes
> -Wno-
> trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
> -mpref
> erred-stack-boundary=2 -march=i586 -DMODULE   -c -o ieee1284_ops.o
> ieee1284_ops.
> c
> ieee1284_ops.c: In function `ecp_forward_to_reverse':
> ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this
> func
> tion)
> ieee1284_ops.c:365: (Each undeclared identifier is reported only once
> ieee1284_ops.c:365: for each function it appears in.)
> ieee1284_ops.c: In function `ecp_reverse_to_forward':
> ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this
> func
> tion)
> make[2]: *** [ieee1284_ops.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.12/drivers/parport'
> make[1]: *** [_modsubdir_parport] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.12/drivers'
> make: *** [_mod_drivers] Error 2
 
[SNIP]

> I'm going to remove this support and try again, but the problem should be
> fixed.

It has been, many times in the last few days... try searching the l-k archives
before posting.


Bruce
