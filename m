Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282655AbRL0Vnx>; Thu, 27 Dec 2001 16:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282705AbRL0Vnp>; Thu, 27 Dec 2001 16:43:45 -0500
Received: from altus.drgw.net ([209.234.73.40]:21254 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S282655AbRL0Vn3>;
	Thu, 27 Dec 2001 16:43:29 -0500
Date: Thu, 27 Dec 2001 15:43:18 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011227154318.F25200@altus.drgw.net>
In-Reply-To: <20011227123344.H25698@work.bitmover.com> <Pine.LNX.4.33.0112271236120.1167-100000@penguin.transmeta.com> <20011227125028.J25698@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011227125028.J25698@work.bitmover.com>; from lm@bitmover.com on Thu, Dec 27, 2001 at 12:50:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[snip]

> > > but your typical SCM has the end user doing the merges, not the maintainer.
> > > If you had an SCM system which allowed the maintainer to do all or some of
> > > the merging, would that help?
> > 
> > Well, that's what the filesystem is for me right now ;)
> 
> Yes, and it works great for easy merges.  It sucks for complicated merges.
> BK can help you a great deal with those merges.  

There is a point to be made though that if *Linus* has to do a complicated 
merge, the 'patch' that caused the merge should probably be suspect in the 
first place.

The person sending the patch should be the one responsible for resolving a
complicated merge. If BK makes that easier, great. HOWEVER, I don't really
want Linus to be using some tool that does automerging.. No SCM system and
automerge tool is going to understand what the code *means*, unless it's 
got a compiler integrated into it.

I've had some strange things happen on a BK automerge in the past, and I
don't trust any automated system that doesn't understand the code to not
make some subtle semantic mistake. (Mind you, when strange things
happened, the code usually worked, and I didn't notice until I tried to
*manually* prepare a 'patch' to send upstream)


-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
