Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbTAIQTN>; Thu, 9 Jan 2003 11:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTAIQTM>; Thu, 9 Jan 2003 11:19:12 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63496 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266795AbTAIQTL>; Thu, 9 Jan 2003 11:19:11 -0500
Date: Thu, 9 Jan 2003 11:12:10 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Robert Love <rml@tech9.net>, Adrian Bunk <bunk@fs.tum.de>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
In-Reply-To: <20030109125007.GA17045@codemonkey.org.uk>
Message-ID: <Pine.LNX.3.96.1030109101553.28217A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Dave Jones wrote:

> On Wed, Jan 08, 2003 at 05:49:54PM -0500, Bill Davidsen wrote:

>  > > SMP isn't a processor option ?
>  >   Clearly not, it's not processor dependent or even architecture dependent
> 
> Of course its arch dependant. Some of the archs we support don't do SMP.
> See m68k for one. Sure there may be some boards out there with >1 68k
> welded to them, but Linux doesn't run on them.

Exactly, that's not a characteristic of the CPU, it's a system board thing
and support is really a low level kernel option.

>  > generally. It's a characteristic of the os, unlike microcode, mtrr, and
>  > other stuff not on some architectures.
> 
> Absolute nonsense. These are _cpu_ features. If you dispute this,
> you have no understanding of what you talking about.

No, you missed what I was talking about... reread the above, I said SMP
was an os feature *unlike* mtrr, etc.

>  > You can select it for 386/486/P5
>  > (and it works in 2.4 at least, for P5, have several).
> 
> And thats perfectly valid. Although I've not seen an MP compliant
> 386/486 personally, there were patches I beleive at one time for
> some of the strange 486 implementations.
> 
> It's also a valid thing to do to do for code coverage reasons.
> Although I doubt anyones testing SMP builds on a 386/486 any more.
> 
>  >   I would think that processor options would select the processor and any
>  > options which are specific to it rather than generally supported. Serial
>  > numbers, firmware loads, that sort of feature.
> 
> serial number stuff is done at run time. Firmware loads. Well, you
> mentioned above that microcode wasn't a CPU feature, now you change
> your mind ?
> 
>  >   Preempt and smp, are general, I guess not supported on every possible
>  > hardware
>  
> Again, more contradiction. Above you said of SMP:
> "Clearly not, it's not processor dependent or even architecture dependent"
> Now you're saying it is arch dependant.

In general by architecture dependent I meant "specific to one
architecture" or even one processor. HT is only on one type of CPU, mtrr
is on one family of CPUs, etc. As opposed to SMP, which is possible on any
of the supported CPUs, even if there isn't a Linux supported example of
it. There was even a board mounting two AMD Socket7 CPUs with a bunch of
glue which ran some BSD variant (no VM, I assume).

I don't mind you disagreeing with me, I'd appreciate it if you would stop
misreading what I said and then claiming I don't know I'm talking about.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

