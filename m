Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129950AbQKGK72>; Tue, 7 Nov 2000 05:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131212AbQKGK7T>; Tue, 7 Nov 2000 05:59:19 -0500
Received: from ns2.Deuroconsult.ro ([193.226.167.164]:38160 "EHLO
	marte.Deuroconsult.ro") by vger.kernel.org with ESMTP
	id <S129950AbQKGK7L>; Tue, 7 Nov 2000 05:59:11 -0500
Date: Tue, 7 Nov 2000 12:58:15 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
To: Michael Vines <mjvines@undergrad.math.uwaterloo.ca>
cc: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>, linux-kernel@vger.kernel.org
Subject: Re: Kernel hook for open
In-Reply-To: <Pine.LNX.4.10.10011061234230.12539-100000@barkingdogstudios.com>
Message-ID: <Pine.LNX.4.20.0011071253280.6730-100000@marte.Deuroconsult.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Michael Vines wrote:

> On Mon, 6 Nov 2000, Erik Mouw wrote:
> 
> > On Mon, Nov 06, 2000 at 10:11:11AM -0500, Michael Vines wrote:
> > > On Mon, 6 Nov 2000, Erik Mouw wrote:
> > > > Use LD_PRELOAD instead.
> > > 
> > > You could also write a simple kernel module that replaces the open system
> > > call.  See the Linux Kernel Module Programming Guide for details. 
> > > http://www.linuxdoc.org/guides.html
> > > 
> > > specifically http://www.linuxdoc.org/LDP/lkmpg/node20.html
> > 
> > Why difficult when it can be done easy? To test the Y2K readiness of
> > some programs (yeah, Y2K, remember?), I wrote a small library that
> > overloaded the time() and gettimeofday() syscalls in about 100 lines of
> > code.  No kernel modules needed, no root privileges needed, just set the
> > environment variable LD_PRELOAD and off you go.
> 
> Well the question was posted to the kernel mailing list and not the glibc
> mailing list after all :)
> 
> 	Michael
> 

Yes, you are right. It was my fault. I should have send my mail to both
kernel and glibc list.

I just want to intercept open call. That's all. I don't care much if I
must do a kernel module or I use PRELOAD. Probably is better to use
LD_PRELOAD.

Thank you all for your kindly help! You are great! All of you! Thanks!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
A new Linux distribution: http://l13plus.deuroconsult.ro
http://www2.deuroconsult.ro/~catab

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
