Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132219AbRAUAN5>; Sat, 20 Jan 2001 19:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132272AbRAUANs>; Sat, 20 Jan 2001 19:13:48 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:34310 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S132219AbRAUANg>;
	Sat, 20 Jan 2001 19:13:36 -0500
Date: Sat, 20 Jan 2001 17:10:45 -0700
From: yodaiken@fsmlabs.com
To: Jay Ts <jay@toltec.metran.cx>
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>, xpert@xfree86.org,
        "mcrichto@mpp.ecs.umass.edu" <mcrichto@mpp.ecs.umass.edu>
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Message-ID: <20010120171045.B15918@hq.fsmlabs.com>
In-Reply-To: <3A5D994A.1568A4D5@uow.edu.au> <200101130245.TAA02910@toltec.metran.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200101130245.TAA02910@toltec.metran.cx>; from Jay Ts on Fri, Jan 12, 2001 at 07:45:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 07:45:43PM -0700, Jay Ts wrote:
> Andrew Morton wrote:
> > 
> > Jay Ts wrote:
> > > 
> > > Now about the only thing left is to get it included
> > > in the standard kernel.  Do you think Linus Torvalds is more likely
> > > to accept these patches than Ingo's?  I sure hope this one works out.
> > 
> > We (or "he") need to decide up-front that Linux is to become
> > a low latency kernel. Then we need to decide the best way of
> > doing that.
> > 
> > Making the kernel internally preemptive is probably the best way of
> > doing this.  But it's a *big* task
> 
> Ouch.  Yes, I agree that the ideal path is for Linus and the other
> kernel developers and ... well, just about everyone ... is to create
> a long-range strategy and 'roadmap' that includes support for low-latency.
> 
> And making the kernel preemptive might be the best way to do that
> (and I'm saying "might"...).

Keep in mind that Ken Thompson & Dennis Ritchie did not decide on a 
non-preemptive strategy for UNIX because they were unaware of such 
methods or because they were stupid. And when Rob Pike redesigned a new
"unix" Plan9  note there is no-preemptive kernel, and the core Linux
designers have rejected preemptive kernels too. Now it is certainly possible
that things have change and/or all these folks are just plain wrong. But
I wouldn't bet too much on it.

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
