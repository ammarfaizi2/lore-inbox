Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbTAHSnF>; Wed, 8 Jan 2003 13:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267838AbTAHSnF>; Wed, 8 Jan 2003 13:43:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18695 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267624AbTAHSnC>; Wed, 8 Jan 2003 13:43:02 -0500
Date: Wed, 8 Jan 2003 13:36:06 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@tech9.net>
cc: Adrian Bunk <bunk@fs.tum.de>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
In-Reply-To: <1042041195.694.2734.camel@phantasy>
Message-ID: <Pine.LNX.3.96.1030108132758.22872B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2003, Robert Love wrote:

> On Wed, 2003-01-08 at 09:32, Bill Davidsen wrote:
> 
> > Someone else suggested putting all the low level options like preempt,
> > smp, and the stuff in kernel-hacking into a single menu, with a better
> > name.
> 
> I do not think I like this.  SMP, kernel preemption, and high memory
> support are the three most fundamental choices one makes during
> configuration.

I guess, depending on your definition of fundemental. I would put any
option which affects the kernel as a whole in that category, myself.
Compiling with frame pointers comes to mind, since every object file is
changed and there are performance implications as well.

> They should be out in the open, in the beginning, in a well-labeled
> category.  They only issue I see is "processor options" should be
> renamed "core options" or whatever.  But that is trivial.

Processor option would select the processor and any architecture dependent
options, I would think. Something like "kernel characteristics" could have
options like smp.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

