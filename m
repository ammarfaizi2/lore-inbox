Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292230AbSBBFtt>; Sat, 2 Feb 2002 00:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292231AbSBBFtj>; Sat, 2 Feb 2002 00:49:39 -0500
Received: from bitmover.com ([192.132.92.2]:22914 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292230AbSBBFtc>;
	Sat, 2 Feb 2002 00:49:32 -0500
Date: Fri, 1 Feb 2002 21:49:18 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rob Landley <landley@trommello.org>
Cc: Larry McVoy <lm@bitmover.com>,
        Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        Keith Owens <kaos@ocs.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper change granularity (was Re: A modest proposal -- We need a patch penguin)
Message-ID: <20020201214918.E27081@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rob Landley <landley@trommello.org>, Larry McVoy <lm@bitmover.com>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	Keith Owens <kaos@ocs.com.au>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <lm@bitmover.com> <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de> <20020201083855.C8664@work.bitmover.com> <20020202001058.UXDU10685.femail14.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020202001058.UXDU10685.femail14.sdc1.sfba.home.com@there>; from landley@trommello.org on Fri, Feb 01, 2002 at 06:45:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 06:45:59PM -0500, Rob Landley wrote:
> > The norm is:
> > 	clone a repository
> > 	edit the files
> > 	modify/compile/debug until it works
> > 	check in
> > 	push the patch up the shared repository
> > I'm really at a loss as to why that shouldn't be the norm here as well.
> 
> You'll notice that bitkeeper is totally useless between the clone and the 
> check in, in your model.  It can't really be used DURING development, only 
> before and after.

What nonsense.  Go read the docs.

> As for a simple example of when your model above breaks down, a lot of 
> developers who use things like emacs have their source control system as part 
> of their integrated development environment.  When they "save and compile", 
> it's checked into the RCS (often with a terse three or four word comment 
> that's intended as a label to jog the developer's memory).  

Hey genuis.  Download BK, install it, get into emacs, and type the key
strokes you just described.  What happens?  I'll let you in on a little
secret, smart boy, it does exactly what it should do.  Works just like
it were RCS or SCCS.  It was carefully designed behave exactly like SCCS
so that emacs/make/patch/etc all just know how to use it.  Try patching
a BK repository w/ patch(1) and you'll see

    retrieve file from revision system with lock?

Just works.  Fits neatly with the tools that we all know and love.

So explain to me again how it is that the tool is "totally useless"
when it works *exactly* the way you say it should?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
