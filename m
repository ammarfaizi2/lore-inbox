Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311536AbSDDUTJ>; Thu, 4 Apr 2002 15:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311530AbSDDUTA>; Thu, 4 Apr 2002 15:19:00 -0500
Received: from bitmover.com ([192.132.92.2]:713 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S311483AbSDDUSu>;
	Thu, 4 Apr 2002 15:18:50 -0500
Date: Thu, 4 Apr 2002 12:18:48 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1
Message-ID: <20020404121848.H17549@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020403195445.U17549@work.bitmover.com> <Pine.LNX.4.33.0204041203440.14206-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 12:12:07PM -0800, Linus Torvalds wrote:
> > You can click on any name to see what they have been working on, once you
> > drill down through a name, you are looking at things through a "this user
> > only" filter.
> 
> Side note: this only works partially.
> 
> For example, of the 297 changesets in 2.5.8-pre1, 147 were from email
> patches (the 50% ratio seems to have held up pretty well over time:  
> about half of the submissions I get are old-style patches, with half being
> BK merges. Of course, for me the advantage of BK is that the BK merge half
> often required _much_ less than 50% of the time).

OK, I think I see.  If you get a GNU patch from someone like Dave who got
it from someone else, then it shows up as Dave in your changelogs.  Hmm.
Do you think it is worthwhile to try and do some parsing of the message
such that we can set $BK_USER to the right person if the message contains
the info?  Dave is pretty good about doing stuff like 

	Patch description...
	Originally from Matt Domsch.

If we formalized that a bit we could get the annotations right.  I know
it may sound like an ego stroking exercise, but it's actually very useful
when looking at the annotated history to see who did something, it makes
it easier to track them down and feed them new changes/suggestions/etc.
Yeah, it makes it easier to bug them with questions too, but that tends
to happen anyway.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
