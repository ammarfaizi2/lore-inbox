Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131405AbRBMNVT>; Tue, 13 Feb 2001 08:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131294AbRBMNVJ>; Tue, 13 Feb 2001 08:21:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:36480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131405AbRBMNU6>; Tue, 13 Feb 2001 08:20:58 -0500
Date: Tue, 13 Feb 2001 08:20:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tony Gale <gale@syntax.dera.gov.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x SMP blamed for Xfree 4.0 crashes
In-Reply-To: <XFMail.20010213130505.gale@syntax.dera.gov.uk>
Message-ID: <Pine.LNX.3.95.1010213081530.16233A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Tony Gale wrote:

> Having experienced a number of crashes with Xfree 4.0 with 2.4
> kernels, that I wasn't getting with 2.2 kernels, a quick search on
> the xfree Xpert mailing list reveals this:
> 
> --------------------------------------------------------------------
> (http://www.xfree86.org/pipermail/xpert/2001-January/004666.html)
> 
> Mark Vojkovich mvojkovich@valinux.com
> Wed, 10 Jan 2001 10:49:05 -0800 (PST)
> 
> On Wed, 10 Jan 2001, Martin Schenk wrote:
>  > I'm using the nv.o driver
> of XFree-4.0.1 with a TNT card
> > on a SMP system under the new linux kernel 2.4.0.
> >> Occasionally XFree segfaults and dumps me back to the command
> > line.
> > I assume the problem has to do with my using the new kernel,
> > which provides finer grained kernel locks.
> >> I attach the startup info from XFree.log and a backtrace done
> > on the coredump (if someone is interested in the coredump,
> > it is about 2MB bzip2'd).
> 
>    This is a long-standing problem with 2.3 and 2.4 SMP
> kernels.  I believe it is a kernel bug and isn't the XFree86
> project's problem.  The problem does not exist on 2.2
> SMP kernels nor on 2.3/4 UP kernels.  The symptoms are
> random segfaults in perfectly fine XFree86 code. 
> ---------------------------------------------------------------------
> 
> Anyone looking into this?
> 
> -tony

A work-around seems to be `option "noaccel"` . This may not
be either XFree86 or Linux problem, but a problem with MMX
and certain screen-cards, in kernels so compiled. I would
try another screen card if you have one.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


