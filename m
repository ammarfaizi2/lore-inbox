Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291843AbSBAQnz>; Fri, 1 Feb 2002 11:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291837AbSBAQnq>; Fri, 1 Feb 2002 11:43:46 -0500
Received: from bitmover.com ([192.132.92.2]:21441 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291851AbSBAQna>;
	Fri, 1 Feb 2002 11:43:30 -0500
Date: Fri, 1 Feb 2002 08:43:27 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        Keith Owens <kaos@ocs.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020201084327.D8664@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	Keith Owens <kaos@ocs.com.au>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de> <Pine.LNX.4.33L.0202010926080.17106-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0202010926080.17106-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Feb 01, 2002 at 09:30:56AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 09:30:56AM -0200, Rik van Riel wrote:
> On Fri, 1 Feb 2002, Horst von Brand wrote:
> If the object is to minimise confusion by not showing
> back-tracked changes, why not simply allow the user
> to mark changesets with a "visibility":

That's what LODs do.  You can do all your work in your "branch", when you
are ready, you do a branch-to-branch pull which collapses the view of all
your changesets down to one in the other view.

I'd love it if you could get Linus to buy into this as an acceptable answer.

I do agree that there are times when you really want to collapse a pile
of changes into one and I'm willing to write that code if it becomes
agreed that it is widely useful.  It's maintaining both versions of 
the changes, the collapsed and uncollapsed, that I don't want to do.
That would be a nightmare in the source base and I don't believe there
is substantial real benefit.  Either the changes are valuable or they
aren't.  If they are valuable enough that you want to save them then
you should let the rest of the world see them.  If they aren't, then
they aren't.  I'm sure you can find cases that don't match that view
but I'm equally sure they are a very small percentage.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
