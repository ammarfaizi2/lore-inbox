Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTBXHuo>; Mon, 24 Feb 2003 02:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264813AbTBXHuo>; Mon, 24 Feb 2003 02:50:44 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:13955 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S264628AbTBXHun>; Mon, 24 Feb 2003 02:50:43 -0500
Date: Mon, 24 Feb 2003 00:00:52 -0800
To: William Lee Irwin III <wli@holomorphy.com>,
       Larry McVoy <lm@work.bitmover.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>, Ben Greear <greearb@candelatech.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224080052.GA4764@gnuppy.monkey.org>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com> <33350000.1046043468@[10.10.2.4]> <20030224045717.GC4215@work.bitmover.com> <20030224074447.GA4664@gnuppy.monkey.org> <20030224075430.GN10411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224075430.GN10411@holomorphy.com>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 11:54:30PM -0800, William Lee Irwin III wrote:
> On Sun, Feb 23, 2003 at 11:44:47PM -0800, Bill Huey wrote:
> > And large unbounded operation on data structures. DOS, a single tasking
> > operating system is fast running a single thread of execution too, it just
> > happens to also be completely useless.
> > Whether folks like it or not, embedded RT is the future of Linux much more
> > so than any single NUMA machine that's sold or can be sold by IBM, SGI and
> > any other vendor of that type.
> 
> And scalability is as essential there as it is on 512x/16TB O2K's.
> 
> For this, it's _downward_ scalability, where "downward" is relative to
> "typical" UP x86 boxen.

The good thing about Linux is that, with some compile options, stuff (scalability)
can be insert and removed and any time. One shouldn't narrow their view of how an
OS can be out of a strict tradition.

I don't buy this spinlock-for-all-locking things tradition with no preemption,
especially given some of the IO performance improvement that happened as a courtesy
of preempt. Some how that was forgotten in Larry's discussion.

bill

