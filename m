Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286488AbRL0Uuz>; Thu, 27 Dec 2001 15:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286646AbRL0Uuq>; Thu, 27 Dec 2001 15:50:46 -0500
Received: from bitmover.com ([192.132.92.2]:24478 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S286488AbRL0Uu3>;
	Thu, 27 Dec 2001 15:50:29 -0500
Date: Thu, 27 Dec 2001 12:50:28 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011227125028.J25698@work.bitmover.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011227123344.H25698@work.bitmover.com> <Pine.LNX.4.33.0112271236120.1167-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0112271236120.1167-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 27, 2001 at 12:41:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 12:41:15PM -0800, Linus Torvalds wrote:
> No, I'm taking a bigger view. A patch is not just a "patch". A patch has a
> lot of stuff around it, one being the unknowable information on whether
> the sender of the patch is somebody who will do a good job maintaining the
> things the patch impacts.
> 
> That's something a source control system doesn't give you - but that
> doesn't mean that you cannot use a SCM as a tool anyway.

OK, cool, just checking.  We're on the same page.

> > I _think_ what you are saying is that an SCM where your repository is a
> > wide open black hole with no quality control is a problem, but that's
> > not the SCM's fault.  You are the filter, the SCM is simply an accounting/
> > filing system.
> 
> Right. But that's true only if I use SCM as a _personal_ medium, which
> doesn't help my external patch acceptance.
> 
> So even if I used CVS or BK internally, that's not what people _gripe_
> about.  People want write access, not just a SCM.

I think it is important to distinguish between BK and CVS.  CVS can't do 
what you want, BK can.

People can't have write access in CVS for the obvious reasons, the tree
becomes a chaotic mess of stuff that hasn't been filtered.  But in BK,
because each workspace is a repository, people inherently have write
access to *their* repository.  So they get SCM.  And they may eventually
get their stuff into your tree if you ever accept the changeset.

There are problems with this, BK isn't perfect, but it is much closer 
to solving the set of problems you are describing that CVS can ever 
hope to be.

> > but your typical SCM has the end user doing the merges, not the maintainer.
> > If you had an SCM system which allowed the maintainer to do all or some of
> > the merging, would that help?
> 
> Well, that's what the filesystem is for me right now ;)

Yes, and it works great for easy merges.  It sucks for complicated merges.
BK can help you a great deal with those merges.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
