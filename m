Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290078AbSA3RBW>; Wed, 30 Jan 2002 12:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290212AbSA3Q7s>; Wed, 30 Jan 2002 11:59:48 -0500
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:37519 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S290153AbSA3Q7Q>; Wed, 30 Jan 2002 11:59:16 -0500
Date: Wed, 30 Jan 2002 08:59:03 -0800
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ingo Molnar <mingo@elte.hu>, Larry McVoy <lm@bitmover.com>,
        Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130085902.C11593@helen.CS.Berkeley.EDU>
In-Reply-To: <Pine.LNX.4.33.0201301933390.11022-100000@localhost.localdomain> <Pine.LNX.4.33L.0201301445430.11594-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0201301445430.11594-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Jan 30, 2002 at 02:47:26PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rik van Riel (riel@conectiva.com.br):
> On Wed, 30 Jan 2002, Ingo Molnar wrote:
> > On Wed, 30 Jan 2002, Larry McVoy wrote:
> >
> > > How much of the out order stuff goes away if you could send changes
> > > out of order as long as they did not overlap (touch the same files)?
> >
> > could this be made: 'as long as they do not touch the same lines of
> > code, taking 3 lines of context into account'? (ie. unified diff
> > definition of 'collisions' context.)
> 
> That would be _wonderful_ and fix the last bitkeeper
> problem I'm having once in a while.

This would seem to require a completely new tool for you to specify which 
hunks within a certain file belong to which changeset.  I can see why
Larry objects.  What's your solution?

-josh

-- 
PRCS version control system    http://sourceforge.net/projects/prcs
Xdelta storage & transport     http://sourceforge.net/projects/xdelta
Need a concurrent skip list?   http://sourceforge.net/projects/skiplist
