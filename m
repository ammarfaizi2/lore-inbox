Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290425AbSAQUL0>; Thu, 17 Jan 2002 15:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290352AbSAQULQ>; Thu, 17 Jan 2002 15:11:16 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1549 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290332AbSAQUK7>; Thu, 17 Jan 2002 15:10:59 -0500
Date: Thu, 17 Jan 2002 15:10:33 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: David Weinehall <tao@acc.umu.se>
cc: romano@dea.icai.upco.es, linux-kernel@vger.kernel.org
Subject: Re: Power off NOT working, kernel 2.4.16
In-Reply-To: <20020117175446.P5235@khan.acc.umu.se>
Message-ID: <Pine.LNX.3.96.1020117150001.2890D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, David Weinehall wrote:

> On Thu, Jan 17, 2002 at 08:09:59AM -0500, bill davidsen wrote:

> >   I've had that problem with my BP6 for so long I stopped complaining.
> > Time to start again, I guess.
> > 
> >                                  WHINE
> > 
> >   There, now I feel better ;-) Really annoying, though, to have to boot
> > NT just to turn the machine off.
> 
> Ever tried holding the power-button for 3 seconds?!

Given that it should shut down after a job completes and I work 130+ miles
away, that's not optimal. I'd rather not use the system to heat air that
the a/c needs to cool so I can run the idle loop. Currently I just run a
script to use "lilo -R" to boot to an OS which is smart enough to do the
job. Actually old kernels did the job until the APC was enhanced. More QA
buy the "it doesn't break MY system" method of testing...

At some point I'll convert to ext3, and shutdown with sync() and have the
X10 module cut power, or use "find why this kernel shuts it down and that
one doesn't" as an employment test when some kid applies for a kernel
hacker job ;-) 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

