Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291155AbSAaRLe>; Thu, 31 Jan 2002 12:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291153AbSAaRLY>; Thu, 31 Jan 2002 12:11:24 -0500
Received: from bitmover.com ([192.132.92.2]:9140 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291155AbSAaRLL>;
	Thu, 31 Jan 2002 12:11:11 -0500
Date: Thu, 31 Jan 2002 09:11:10 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <garzik@havoc.gtf.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        lm@bitmover.com
Subject: Re: real BK usage (was: A modest proposal -- We need a patch penguin)
Message-ID: <20020131091110.K1519@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, lm@bitmover.com
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com> <1012354692.1777.4.camel@stomata.megapathdsl.net> <20020130080504.JUTO18525.femail19.sdc1.sfba.home.com@there> <20020130034746.K32317@havoc.gtf.org> <a38ekv$1is$1@penguin.transmeta.com> <20020130050708.D11267@havoc.gtf.org> <20020130102458.B763@lynx.adilger.int> <20020130093459.P23269@work.bitmover.com> <20020130130319.G763@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130130319.G763@lynx.adilger.int>; from adilger@turbolabs.com on Wed, Jan 30, 2002 at 01:03:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:03:19PM -0700, Andreas Dilger wrote:
> > Please see the response to Ingo and see if you could do what I suggested
> > there.  I believe that would work fine, if not, let me know.
> 
> Yes, technically it works fine, but practically not.  For example, I want
> to test _all_ of the changes I make, and to test them each individually
> is a lot of work.  Putting them all in the same tree, and testing them
> as a group is a lot less work.  More importantly, this is how people do
> their work in real life, so we don't want to change how people work to
> fit the tool, but vice versa.

There is a subtle point that this comment misses, it's worth thinking about.

This thread has been about the idea of being able to send any one of those
changes out in isolation, right?  That's the problem we are solving.  But
your statement is that you want to test them all at once, testing them one
at a time is too much work.

Doesn't that mean that you don't even know if these changes compile, let
alone run, when you send them out individually?  You haven't tested them,
you've only tested the set of them as one unit.

In many environments, BK is doing exactly the right thing.  It lets you send
the stuff you've tested together.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
