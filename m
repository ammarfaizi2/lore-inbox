Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314280AbSDVRUv>; Mon, 22 Apr 2002 13:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314292AbSDVRUv>; Mon, 22 Apr 2002 13:20:51 -0400
Received: from otter.mbay.net ([206.55.237.2]:47364 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S314280AbSDVRUt>;
	Mon, 22 Apr 2002 13:20:49 -0400
Date: Mon, 22 Apr 2002 10:20:39 -0700 (PDT)
From: John Alvord <jalvo@mbay.net>
To: Pavel Machek <pavel@suse.cz>
cc: davidm@hpl.hp.com, Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <20020421180021.A155@toy.ucw.cz>
Message-ID: <Pine.LNX.4.20.0204221019280.20972-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Apr 2002, Pavel Machek wrote:

> Hi!
> 
> >   Davide> i still have pieces of paper on my desk about tests done on
> >   Davide> my dual piii where by hacking HZ to 1000 the kernel build
> >   Davide> time went from an average of 2min:30sec to an average
> >   Davide> 2min:43sec. that is pretty close to 10%
> > 
> > The last time I measured timer tick overhead on ia64 it was well below
> > 1% of overhead.  I don't really like using kernel builds as a
> > benchmark, because there are far too many variables for the results to
> > have any long-term or cross-platform value.  But since it's popular, I
> > did measure it quickly on a relatively slow (old) Itanium box: with
> > 100Hz, the kernel compile was about 0.6% faster than with 1024Hz
> > (2.4.18 UP kernel).
> 
> .5% still looks like a lot to me. Good compiler optimization is .5% on 
> average...
> 
> And think what it does with old 386sx.. Maybe time for those "tick on demand"
> patches?

Doesn't IBM have a tickless patch.. useful when demonstrating 10,000
virtual linux machines on a single system.

john alvord

