Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbTCJNmW>; Mon, 10 Mar 2003 08:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261318AbTCJNmW>; Mon, 10 Mar 2003 08:42:22 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:8320 "EHLO bjl1.jlokier.co.uk")
	by vger.kernel.org with ESMTP id <S261313AbTCJNmV>;
	Mon, 10 Mar 2003 08:42:21 -0500
Date: Mon, 10 Mar 2003 13:52:48 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030310135248.GA12232@bjl1.jlokier.co.uk>
References: <20030309024522.GA25121@renegade> <200303100341.h2A3fKEO004164@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303100341.h2A3fKEO004164@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Zack Brown <zbrown@tumblerings.org> said:
> > I'd be willing to maintain this as the beginning of a feature list and
> > post it regularly to lkml if enough people feel it would be useful and not
> > annoying. The goal would be to identify the features/problems that would
> > need to be handled by a kernel-ready version control system.
> 
> I believe that has very little relevance to lkml, only perhaps to a mailing
> list for a bk replacement. For the kernel this work has already been done
> (by Larry and the head penguins).

I'd like to thank those kind souls who explained how branch _and_
merge history is used by the better merging utilities.  Now I see why
tracking merge history is so helpful.  (Tracking it for credit and
blame history was obvious, but tracking it to enable tools to be
better at resolving conflicts was not something I'd thought of).

Of course there will be times when two or more people apply a patch
without the history of that patch being tracked, and then try to merge
both changes - any version control system should handle that as
gracefully as it can.  However I now see how much actively tracking
the history of those operations can help tools to reduce the amount of
human effort required to combine changes from different places.

So thank you for illustrating that.

ps. Yes I know that CVS sucks at these things.  I've seen _awful_
software engineering disasters due to the difficulty of tracking
different lines of development through CVS, first hand :)

-- Jamie
