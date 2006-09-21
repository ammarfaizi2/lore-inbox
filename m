Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWIUFXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWIUFXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 01:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWIUFXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 01:23:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62124 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750839AbWIUFXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 01:23:39 -0400
Date: Wed, 20 Sep 2006 22:23:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
In-Reply-To: <20060920220744.0427539d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609202217420.4388@g5.osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org> <45121382.1090403@garzik.org>
 <20060920220744.0427539d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Sep 2006, Andrew Morton wrote:
> 
> Why would a shorter cycle be better?  What are we trying to achieve?

I don't think a shorter cycle is necessarily better, but I think we could 
try having a more "directed" cycle, and perhaps merge certain specific 
things rather than everything.

That would possibly _cause_ a shorter cycle, if only because the problems 
are hopefully more focused from the fact that we merged with a certain 
focus.

Of course, it would likely just frustrate the people who didn't get 
merged, and would need to wait for the next cycle. So it might be a net 
negative, even if we'd bring individual cycles in a bit.

> > The cycles seem to be stretching out again, and I don't really think 
> > it's worth it to hold up the entire kernel for every single piddly 
> > little regression to get fixed.  We'll _never_ be perfect, even if we 
> > weren't slackers.

I think that's true. 2.6.18 got delayed partly due to me beign away, but I 
also think that it then got delayed too much afterwards too, just because 
I felt a bit nervous about having been away ;)

So it definitely stretched out too much.

Whether there is a lot we can do about it, I dunno. In many ways, the real 
issue is simply that we have a lot of changes. And people are _never_ as 
interested in the testing part as they were in writing new code..

		Linus
