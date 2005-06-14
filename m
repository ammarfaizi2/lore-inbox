Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVFNUTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVFNUTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVFNUTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:19:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:54158 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261328AbVFNUTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:19:37 -0400
To: Bill Huey (hui) <bhuey@lnxw.com>
cc: karim@opersys.com, dwalker@mvista.com, paulmck@us.ibm.com,
       Andrea Arcangeli <andrea@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Attempted summary of "RT patch acceptance" thread 
In-reply-to: Your message of Tue, 14 Jun 2005 12:20:56 PDT.
             <20050614192056.GA2985@nietzsche.lynx.com> 
Date: Tue, 14 Jun 2005 13:19:12 -0700
Message-Id: <E1DiHsO-0000kJ-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Jun 2005 12:20:56 PDT, Bill Huey wrote:
> On Tue, Jun 14, 2005 at 09:41:22AM -0700, Gerrit Huizenga wrote:
> > It's easy:
> > 
> > 	1) Change your allegiance to Linux first
> > 	2) Do the right thing.
> > 
> > And, implicit in that is that I believe that RT for the community will
> > in the long term be The Right Thing.
> 
> This implications of this patch are huge. It's transparent and will ultimately
> change the userspace land scape for just about everything despite the paranoia
> and disinformation spread by various arch-conservatives in this community.

Hmm.  I think a few people have misunderstood one aspect of my position
here which bears clarification:

I'm making __NO__ statement on the validity of the specific RT patch
under circulation.  Well, no statement on whether it should go into
mainline as it is.  I think it is a cool patch, from what I've seen and
read, it is way better than most things that have been kicked around.

However, what I __AM__ saying is:  Linux over time can tolerate changes
which will improve its ability to be used in various levels of Real Time
situations.  Those improvements may start out small, such as analyses
of latency problems, or locking improvements and such.  However, the
thing about understanding the community is to figure out *which* solutions
are the right solutions that move things closer to real time.  If this
patch fits all of the community goals and guidelines for simplicity,
easy to maintain, clear, and evolves in the right general direction, then,
yes, it is probably the right patch.  But even if it isn't, that doesn't
mean the end of RT support for Linux - it just means that the community
needs to continue to collaborate in the right direction and this particular
patch can be used as a yardstick for progress in some cases.

This isn't about defending a particular patch to the death (even if it
is the best one we've seen so far) but about evolving solutions to
resolve the core problem while not breaking anything else.  This patch
*might* be the next step in that evolution.  It *looks* like it could
be a good step in the right direction and useful to test in -mm or the
like for a while.  But odds are it will also introduce some problems and
need some continued evolution as well.

gerrit
