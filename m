Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290825AbSAaB5s>; Wed, 30 Jan 2002 20:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290827AbSAaB5i>; Wed, 30 Jan 2002 20:57:38 -0500
Received: from bitmover.com ([192.132.92.2]:60844 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290825AbSAaB5a>;
	Wed, 30 Jan 2002 20:57:30 -0500
Date: Wed, 30 Jan 2002 17:57:29 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rob Landley <landley@trommello.org>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130175729.N22323@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rob Landley <landley@trommello.org>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Eli Carter <eli.carter@inet.com>,
	Georg Nikodym <georgn@somanetworks.com>,
	Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C586C8D.2C100509@inet.com> <Pine.LNX.4.33.0201301408290.2618-100000@penguin.transmeta.com> <20020130143608.I22323@work.bitmover.com> <20020130231701.FKGV22669.femail15.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130231701.FKGV22669.femail15.sdc1.sfba.home.com@there>; from landley@trommello.org on Wed, Jan 30, 2002 at 06:18:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 06:18:11PM -0500, Rob Landley wrote:
> > And you just lost some useful information.  The fact that so-and-so did
> > fix A and then did B is actually useful.  It tells me that A didn't work
> > and B does.  You think it's "crap" and by tossing it dooms all future
> > developers to rethink the A->B transition.
> 
> <rant>

I'll see your rant and raise you a nickel.

> If developers can't ever make temporary changes to their tree which they do 
> NOT intend to send to linus, they can't FUNCTION.  (Except my not doing 
> development in said tree.)

Of course they can do that.  They get to decide what they push and
what they don't.  I don't think you understand BK.  What we are talking
about is the problem that the change has been committed to CVS, other
changes are built on top of it, and now Linus realizes that the change
was bad news.  The problem is extracting stuff out of the middle which
has already been built upon for more stuff.  How would you propose solving
that problem because that is the problem statement?

If someone sends Linus a patch, he checks into BK or CVS or whatever,
he then gets 5 other patches and applies them in BK/CVS, and THEN he
wants to take out the first patch, how would you suggest we do that?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
