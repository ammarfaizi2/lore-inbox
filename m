Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318218AbSGWWhW>; Tue, 23 Jul 2002 18:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSGWWhW>; Tue, 23 Jul 2002 18:37:22 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54026 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318218AbSGWWhV>; Tue, 23 Jul 2002 18:37:21 -0400
Date: Tue, 23 Jul 2002 18:33:41 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
In-Reply-To: <E17Wf0s-0001tS-00@starship>
Message-ID: <Pine.LNX.3.96.1020723182559.2194G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Daniel Phillips wrote:

> On Monday 22 July 2002 12:23, Joe Thornber wrote:

> > For example I released the LVM2 vs EVMS snapshot
> > benchmarks in the hope of encouraging EVMS to move over to
> > device-mapper, unfortunately 2 months later a reply is posted stating
> > that they have now developed equivalent (but broken) code :(
> 
> Supposing both device-mapper and (the kernel part of) EVMS get into the tree, 
> there's nothing stopping you from submitting a patch to make EVMS use 
> device-mapper.  If there's already equivalent code in EVMS, that just makes 
> the job easier.
> 
> I'm firmly in the 'we need both' camp.
> 
> EVMS is a full-bloated^W blown enterprise solution, ready to go with every
> imaginable bell and whistle.  Device-mapper represents the classic Linux 
> minimalist approach.  Hopefully, with the two side-by-side in the tree, both 
> will evolve more rapidly.

Based on reading this thread and some articles referenced and searched, it
would appear that EVMS and LVM2 could/should use the same underpining,
such as device-mapper. If you have two competing planes they should still
land on the same runway. That way other software could be written which
did still other things, or the same things in different ways. Having two
kinds of lowest level under them seems like more code to maintain than is
necessary, and may lead to conflicts if both are in use. I know the EVMS
folks say that won't happen, and there's a good reason for having two
groups inventing the wheel, but I'd feel better if ther was one wheel and
a single API which all *VM* software could use.

I suspect that there's som NIH involved...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

