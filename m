Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267976AbTAHW5G>; Wed, 8 Jan 2003 17:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267978AbTAHW5G>; Wed, 8 Jan 2003 17:57:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:45063 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267976AbTAHW5E>; Wed, 8 Jan 2003 17:57:04 -0500
Date: Wed, 8 Jan 2003 17:49:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Robert Love <rml@tech9.net>, Adrian Bunk <bunk@fs.tum.de>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
In-Reply-To: <20030108195000.GA670@codemonkey.org.uk>
Message-ID: <Pine.LNX.3.96.1030108164157.23971A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Dave Jones wrote:

> On Wed, Jan 08, 2003 at 01:36:06PM -0500, Bill Davidsen wrote:
> 
>  > I guess, depending on your definition of fundemental. I would put any
>  > option which affects the kernel as a whole in that category, myself.
>  > Compiling with frame pointers comes to mind, since every object file is
>  > changed and there are performance implications as well.
> 
> No-one other than kernel hackers should be playing with that option,
> hence it's in the kernel hacking menu.

  Anyone who wants to be able to debug a problem should be playing with
that, it's one thing which affects the whole kernel, and is't really a
hack in the usualy sense. And sysctl isn't really a hack, it's just
another feature (my opinion).

>  > Processor option would select the processor and any architecture dependent
>  > options, I would think. Something like "kernel characteristics" could have
>  > options like smp.
> 
> SMP isn't a processor option ?

  Clearly not, it's not processor dependent or even architecture dependent
generally. It's a characteristic of the os, unlike microcode, mtrr, and
other stuff not on some architectures. You can select it for 386/486/P5
(and it works in 2.4 at least, for P5, have several).

  I would think that processor options would select the processor and any
options which are specific to it rather than generally supported. Serial
numbers, firmware loads, that sort of feature.

  Preempt and smp, are general, I guess not supported on every possible
hardware, but certainly not restricted to a single model or family.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

