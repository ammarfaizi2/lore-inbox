Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316300AbSEZTGb>; Sun, 26 May 2002 15:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316301AbSEZTGa>; Sun, 26 May 2002 15:06:30 -0400
Received: from bitmover.com ([192.132.92.2]:42199 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316300AbSEZTG3>;
	Sun, 26 May 2002 15:06:29 -0400
Date: Sun, 26 May 2002 12:06:30 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, David Schleef <ds@schleef.org>,
        Karim Yaghmour <karim@opersys.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526120630.C30610@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
	Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020525110208.A15969@work.bitmover.com> <20020525182617.D627E11972@denx.denx.de> <20020525114426.B15969@work.bitmover.com> <3CEFEB73.5BB2C14C@opersys.com> <20020525133637.B17573@work.bitmover.com> <20020525190913.A6869@stm.lbl.gov> <20020525201749.A19792@work.bitmover.com> <20020525204542.A10392@stm.lbl.gov> <20020525210330.A20253@work.bitmover.com> <1022442044.11859.131.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 08:40:44PM +0100, Alan Cox wrote:
> On Sun, 2002-05-26 at 05:03, Larry McVoy wrote:
> > Me too.  I've been here before, I was one of about 8 people who actually
> > knew that AT&T should have won the BSD lawsuit because I diffed the code.
> > And you can't diff it with a perl script, that simply doesn't work.  The
> 
> And then went on to cite bmap which is clearly different. Yes Larry, now
> would you mind returning to the ward like a good patient 8)

Sniffle, whimper.  It is clearly different in that it calls out to the
BSD allocation policy, which is completely different.

However, if you diff the code, there is more than enough which is the same
that there is now way you can call that a rewrite of bmap().  I was wrong in
saying it was bit for bit identical, but other than showing me to be a clutz,
it doesn't detrack from the point.

But I'm headed for he ward.  Sniff.

> > only real ways that I know of are
> >     a) have a human do it, function by function
> >     b) compile the code to an expression tree and then diff the expression
> >        trees.
> 
> b) doesn't work because copyright does not apply to the fundamental
> algorithms. If you want to look at it at that level you need to remember
> there are many different implementations which are very different but
> which in pure mathematics are strictly identical.

Is this theory or practice, Alan?  We're not talking about pure copyright,
we're also discussing derived works.  And anyway, I'd like you to cite a
case where two independently developed substantial chunks of code compile
to the same expression tree.  I'm sure you can find strcmp() implementations
which do, but I'd be surprised if you could find a stdio implementation that
was, and you sure as hell won't find two file system implementations that do.
Righ?  Or do you have a counter example?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
