Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282792AbRLKT6v>; Tue, 11 Dec 2001 14:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282812AbRLKT6l>; Tue, 11 Dec 2001 14:58:41 -0500
Received: from pl475.nas921.ichikawa.nttpc.ne.jp ([210.165.235.219]:62994 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S282792AbRLKT6b>;
	Tue, 11 Dec 2001 14:58:31 -0500
Date: Wed, 12 Dec 2001 04:58:23 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Brian Horton <go_gators@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to debug a deadlock'ed kernel?
Message-Id: <20011212045823.0bf53af9.bruce@ask.ne.jp>
In-Reply-To: <3C166540.DC0BDBEE@mail.com>
In-Reply-To: <3C166540.DC0BDBEE@mail.com>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001 13:57:52 -0600
Brian Horton <go_gators@mail.com> wrote:

> Anyone got any good tips on how to debug a SMP system that is locked up
> in a deadlock situation in the kernel? I'm working on a kernel module,
> and after some number of hours of stress testing, the box locks up. None
> of the sysrq options show anything on the display, though the reBoot
> option does reboot the system. RedHat 6.2 and its 2.2.14 kernel. Doesn't
> hang for me on 2.4, so I need to debug it here... 
> 
> Any hints? 

Try using a serial console (activate it in your kernel config and hook up
another PC to the serial port - if it's oopsing, you should see the oops over
the serial line.)
Also, I believe you can use kdb via serial as well (although I've never tried).


Bruce

