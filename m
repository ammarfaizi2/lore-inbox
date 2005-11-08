Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVKHIjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVKHIjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 03:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVKHIjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 03:39:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932489AbVKHIjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 03:39:46 -0500
Date: Tue, 8 Nov 2005 00:39:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: keep in sync with -mm tree?
Message-Id: <20051108003927.73465450.akpm@osdl.org>
In-Reply-To: <43706127.8020304@reub.net>
References: <56rz6-8re-25@gated-at.bofh.it>
	<56rSs-mJ-3@gated-at.bofh.it>
	<43706127.8020304@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>

Please retain the cc line.

> On 8/11/2005 4:00 p.m., Andrew Morton wrote:
> > Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> >> Hello,
> >>
> >> We can always keep in sync with the current Linus tree through his git
> >> tree. But from where can we keep in sync with the current -mm tree?
> >> ie, when somethings added to -mm, how do we get that too?
> > 
> > You can't.  The patches in -mm spend 90% of their time in an untested,
> > often-doesn't-compile state.  It's only in the 24-48 hours preceding a
> > release that I actually start build- and run-time testing it all.
> 
> Would it be at all useful if a small (and for feedback purposes only possibly 
> known) subset of users were to give the -mm releases a basic compile and build 
> before a proper -mm is released?  ie in the 24 hours preceding a formal -mm 
> release, to shake out the most obvious brown paper bag problems?  I know -mm 
> is a testbed but still, it must surely be better if the big bulk of those 
> (unknown number x) people who try it don't need to further patch it to get it 
> to at least build.  It also allows comments like "EDAC is known to not compile 
> on i386 with SMP, we are bugging Alan already about it" to be clearly stated 
> at the time it is released.
> 
> Personally I seem to have my share of compile, symbol and oopses that are 
> fairly obvious and are visible within 5 mins of booting up, and I'd be willing 
> to spare 15 mins once every couple of weeks or so to do a primitive regression 
> test on this and report back.  I can build on i386 and possibly x86_64 if need be.
> 
> Andrew, what do you think?

Maybe.  I'll take a look at uploading a nightly rollup as well.

> >> The only way now seems to check the mm-commits list. Is it possible to
> >> expose akpm's working folder somewhere for convenience?
> > 
> > Well I suppose I could upload stuff to
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ daily.  Then it's
> > trivial to install mm-of-the-day as a quilt series.
> > 
> > <does crontab -e>
> > 
> > Let me know how it goes..
> 
> Last time I tried a broken-out- tarball I ended up watching a heap of fuzzy 
> apply's then a part of the patch which was entirely rejected, leaving only the 
> first half of the broken-out mm patch applied and my tree in a busted half 
> patched state.

That would be atypicel ;)
