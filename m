Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSEZUqS>; Sun, 26 May 2002 16:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316403AbSEZUpG>; Sun, 26 May 2002 16:45:06 -0400
Received: from bitmover.com ([192.132.92.2]:46043 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316402AbSEZUoL>;
	Sun, 26 May 2002 16:44:11 -0400
Date: Sun, 26 May 2002 13:44:13 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, David Schleef <ds@schleef.org>,
        Karim Yaghmour <karim@opersys.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526134413.H30610@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
	Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020525114426.B15969@work.bitmover.com> <3CEFEB73.5BB2C14C@opersys.com> <20020525133637.B17573@work.bitmover.com> <20020525190913.A6869@stm.lbl.gov> <20020525201749.A19792@work.bitmover.com> <20020525204542.A10392@stm.lbl.gov> <20020525210330.A20253@work.bitmover.com> <1022442044.11859.131.camel@irongate.swansea.linux.org.uk> <20020526120630.C30610@work.bitmover.com> <1022448794.11811.142.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 10:33:14PM +0100, Alan Cox wrote:
> On Sun, 2002-05-26 at 20:06, Larry McVoy wrote:
> > > there are many different implementations which are very different but
> > > which in pure mathematics are strictly identical.
> > 
> > Is this theory or practice, Alan?  We're not talking about pure copyright,
> > we're also discussing derived works.  And anyway, I'd like you to cite a
> > case where two independently developed substantial chunks of code compile
> > to the same expression tree.  I'm sure you can find strcmp() implementations
> > which do, but I'd be surprised if you could find a stdio implementation that
> > was, and you sure as hell won't find two file system implementations that do.
> > Righ?  Or do you have a counter example?
> 
> I was very careful to say "pure mathematics". With perfect optimisation
> all implementations of the same algorithm should produce the same parse
> tree.

And I was very careful to ask for a specific counter example.  In theory, 
I'm sure you may be right, but theory doesn't count.  We were discussing
how to show that the code was the same, in other words, we're in the
context of practice, you said it wouldn't work, and I said show me an
example.  You don't get to fall back on theory, I specifically asked for
a real world example.

> The same exercise on library implementations of qsort, strcmp and so
> forth are probably also going to show that.

Right.  I already agreed that the trivial cases would do it.  What about
stdio?  That's pretty simple set of interfaces, and I doubt that even
the gnu one and the v7 one compile to the same expression tree.

Let's put it this way: do you know of any expression tree, compiled
from two from scratch different implementations of the same thing,
with more than 5000 nodes, which results in the same thing?  Not only
do you not, I'd go so far as to predict you'll never find one no matter
how long you look.  Sure, you limit the solution space down to something
like strcmp, the set of possible expression trees is probably in single
digits or so.  That doesn't prove anything other than you're looking at
a simplistic case.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
