Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVFMVVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVFMVVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFMVPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:15:20 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48565 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261374AbVFMU6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:58:41 -0400
Date: Mon, 13 Jun 2005 13:58:59 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: Karim Yaghmour <karim@opersys.com>, Andrea Arcangeli <andrea@suse.de>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050613205859.GG1305@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com> <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com> <42ADE334.4030002@opersys.com> <20050613201046.GE1305@us.ibm.com> <20050613203100.GA32690@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613203100.GA32690@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 01:31:00PM -0700, Bill Huey wrote:
> On Mon, Jun 13, 2005 at 01:10:46PM -0700, Paul E. McKenney wrote:
> ...
> > It may well be that system calls containing such side-effects need to be
> > Linux-only, or maybe someone will come up with the necessary tricks to
> > make it all work nicely.  Not particularly worried about it myself --
> > yet, anyway.  There are plenty of things to worry about before we get
> > to that point!
> ...
> 
> I suggest not speculating about the needs of various RT apps with
> respect to the kernel. (your speculation here will add more confusion
> to parts of an already confused kernel community) Vendors and other
> groups will layer them on as needed depending on specific usage.

Certainly good advice, but...

In this instance, I was speculating not about what various RT apps might
need, but instead about what Karim was getting at.  And I have seen cases
where people needed realtime (as in deterministic) I/O, networking stacks,
and the like, so that part is not speculation.

Whether or not deterministic implementations of I/O, networking stacks,
and the like should ever be included in Linux certainly -is- speculation
at this point, but, as I said in my earlier email, there are plenty of
things to worry about before we get to that point.

> The futex/fusyn work is an exception with regard to syscalls, but
> don't speculate about projects like that if you haven't been carefully
> tracking their progress and their end goals.

The futex/fusyn work is on my list, not for speculation, but rather
for looking at what they have, what it does, how it fits in, and how it
appears to be doing.  My reason for looking into it is that I have
also seen people saying that they need priority inheritance in user-level
mutexes.

I would of course be quite interested in your thoughts on futex/fusyn!

						Thanx, Paul

> That's my suggestion.
> 
> bill
> 
> 
