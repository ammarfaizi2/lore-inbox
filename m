Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVEKAIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVEKAIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVEKAIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:08:39 -0400
Received: from mail.dif.dk ([193.138.115.101]:34955 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261861AbVEKAH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:07:59 -0400
Date: Wed, 11 May 2005 02:11:48 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
 cleanup)
In-Reply-To: <20050510170246.5be58840.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505110208080.2386@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505110057500.2386@dragon.hyggekrogen.localhost>
 <20050510161657.3afb21ff.akpm@osdl.org> <20050510.161907.116353193.davem@davemloft.net>
 <20050510170246.5be58840.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005, Andrew Morton wrote:

> "David S. Miller" <davem@davemloft.net> wrote:
> >
> > From: Andrew Morton <akpm@osdl.org>
> > Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace cleanup)
> > Date: Tue, 10 May 2005 16:16:57 -0700
> > 
> > > Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > > >
> > > > -	if (b == NULL || already_uses(a, b)) return 1;
> > > > +	if (b == NULL || already_uses(a, b))
> > > > +		return 1;
> > > 
> > > There are about 88 squillion of these in the kernel.  I think it would be a
> > > mistake for me to start taking such patches, sorry.
> > 
> > I disagree.  Putting statements on the same line as
> > the if statement hides bugs and makes the code harder
> > to read.
> 
> We all know that, but this means that we spend the next two years fielding
> an ongoing dribble of trivial patches which distract from real work.
> 
That was not the plan. The patch at the start of this thread was merely a 
"feeler" to see what the judge the reaction to such patches.

> > Fixing these makes the kernel eaiser to maintain
> > and debug.
> 
> Well I suppose I could live with a few REALLY REALLY BIG patches to do this
> to lots of files, but if it's the old death-by-1000-cuts, I'm gonna call
> uncle this time.
> 
These things annoy me, so if you are willing to accept a few patches (in 
the 10-20 range) that clean most (I'm not going to say all) of this stuff 
up, then I'm game. Give me a few days (more likely a week or two or 
slightly more) and I'll get that done. Those patches *will* be big 
though...

--
Jesper


