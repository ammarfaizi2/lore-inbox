Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTFTQUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTFTQUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:20:15 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:50643 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263277AbTFTQUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:20:08 -0400
Date: Fri, 20 Jun 2003 09:33:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Larry McVoy <lm@bitmover.com>,
       Lawrence Walton <lawrence@the-penguin.otak.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Message-ID: <20030620163349.GG17563@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>, Larry McVoy <lm@bitmover.com>,
	Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030619165916.GA14404@work.bitmover.com> <20030620001217.G6248@almesberger.net> <20030620120910.3f2cb001.skraw@ithnet.com> <20030620142436.GB14404@work.bitmover.com> <20030620143012.GC14404@work.bitmover.com> <87vfv0bxsb.fsf@sanosuke.troilus.org> <20030620153410.GC17563@work.bitmover.com> <20030620155003.GA2600@the-penguin.otak.com> <20030620160211.GF17563@work.bitmover.com> <20030620161331.GB3960@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620161331.GB3960@gtf.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, CASHCASHCASH, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 12:13:31PM -0400, Jeff Garzik wrote:
> On Fri, Jun 20, 2003 at 09:02:11AM -0700, Larry McVoy wrote:
> > Creating new software:  $$$$$$$$$$
> > Copying existing software:       $
> 
> Agreed.  Except maybe that one dollar sign is too much :)

:-)

> > Revenue from commercial software: $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
> > Revenue from open source:                                        $ (at best)
> 
> This is misleading.  Revenue has nothing to do with whether the software
> is open source or not.  

No argument.

> There is a pool of money that businesses have, that can be spent on
> total IT.  At the end of the day, businesses don't give a damn whether
> they are spending 80% on service, 10% on hardware, and 10% on software,
> or, 10% of service, 20% on hardware, and 70% on software.  

I don't think businesses think like you think they think.

The world of business is a strange place.  I'm an engineer just like you
who has been forced to learn about business.  The business world is an
ecosystem and it has rules which makes the ecosystem work.  Some of the
rules are quite counterintuitive until you think it through.

For example, the original commercial BK contract had a clause which said
that if you hit a 1/1 bug (i.e., a showstopper, you couldn't get your
job done and it was BK's fault) and we either couldn't or wouldn't fix
it promptly (2-3 days at the very most) then we would drop what we were
doing, come to your site, get the data out of BitKeeper and import it
into the SCM system of your choice.  At our expense.

This clause raised all sorts of red flags with businesses and it took
me forever to figure out why.  Can you guess why?  If you think like
a business you will see that while that clause seems like it is the
ultimate in support it actually puts the business at risk.  Say what?
Here's how: suppose we're in at XYZ big company.  We're working a deal
with RST big company and they know we're in at the other big company.
RST's fear is that XYZ will hit some problem and we'll all be off at XYZ
doing the import into SVN or whatever for the next month.  During which
time RST isn't getting supported.

The much shorter version is that there is a fundamental principle in
business: the health of your suppliers is critical.  Anything which
puts them at risk buts you at risk.  IT managers/purchasing people are
_experts_ at sniffing out the health of their suppliers, that's how they
manage their risk.

OK, so what does this have to do with your point above?  It counters
the claim that businesses don't give a damn.  The correct statement is
that they don't really care what the mix is as long as the end result
is that they are dealing with a healthy supplier.

Another way to put it is they don't really buy products based on how good
they are, the IT guys frequently are nowhere near qualified to determine
if a product is good enough.  So they buy products based on knowing that
the vendor is healthy, there is a revenue stream going to that vendor,
there are lots of other people buying the product, so if the product
sucks in version 3.x, that's not the end of the world, the vendor will
fix it in 4.x and it will still be a good choice.

Very different way of looking at from how an engineer would look at
it, eh?

All of this is problematic for open source based business models because
if the product is truly open source then the vendor is standing on much
shakier ground.  What guarentee does the buyer have that the vendor will
make it to next year and support the product?  No matter how you slice it,
it's a much higher risk equation for the buyer than a commercial choice.

The good news is that money talks.  Microsoft has gotten so greedy
that they are forcing people to look at open source as an alternative.
If they actually priced their products fairly I don't think any IT
shop would even think of looking at Linux.  Windows isn't that bad
these days, I run on it part of the time and with a little work it's
fairly close to Linux in some respects, I can rlogin in, I have bash,
I can get an X11 server, it's OK.  Don't get me wrong, I'd much prefer
to see Linux as the kernel in Windows, that would be a much better world
for a programmer, but the reality is that Windows works well enough in
many cases.  It's the economics which are causing people to look at Linux.
Hard to resist Linux when you are looking at something which is "free"
versus something which is clearly overpriced.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
