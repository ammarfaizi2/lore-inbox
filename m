Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263426AbSJGV1A>; Mon, 7 Oct 2002 17:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263425AbSJGV0o>; Mon, 7 Oct 2002 17:26:44 -0400
Received: from bitmover.com ([192.132.92.2]:53433 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263417AbSJGVZ5>;
	Mon, 7 Oct 2002 17:25:57 -0400
Date: Mon, 7 Oct 2002 14:31:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Pavel Machek <pavel@ucw.cz>, Ben Collins <bcollins@debian.org>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: BK is *evil* corporate software [was Re: New BK License Problem?]
Message-ID: <20021007143134.V14596@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Mike Galbraith <efault@gmx.de>, Pavel Machek <pavel@ucw.cz>,
	Ben Collins <bcollins@debian.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20021005112552.A9032@work.bitmover.com> <20021007001137.A6352@elf.ucw.cz> <5.1.0.14.2.20021007204830.00b8b460@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20021007204830.00b8b460@pop.gmx.net>; from efault@gmx.de on Mon, Oct 07, 2002 at 08:51:16PM +0200
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 08:51:16PM +0200, Mike Galbraith wrote:
> At 12:11 AM 10/7/2002 +0200, Pavel Machek wrote:
> >Hi!
> >
> > > We're a business.  We're a business which happens to be committed to
> > > helping the kernel team because we think that the kernel is vital to
> > > the world at large.  Helping the kernel absolutely does not translate
> > > to helping people who happen to be our competitors.  By your own
> >
> >Stop lying. Your job is to make lots of money and you are using Linux
> >as cheap advertising. You are trying to make people pay *you* to do
> >kernel development (as it stands you want $5000 for any bk-using
> >developer inside RedHat and SuSE).
> 
> More info on $5k assertion please?

Let's clear this one up right away.  The commercial licenses can be
perpetual (you bought it, you own that version forever) or annual lease.
The lease includes the right to use, support, and upgrades for as long as
you maintain the lease.  The buy includes a year of support & upgrades;
after that you can buy support or not as you so choose.  So you have the
buy vs buy+support vs lease options.

We vary our prices based on volume and everyone gets the same price.
We don't publish the prices because engineers will reject the product
based on any price more than $100/seat.  Management is far more
reasonable, they want to know how much they spend and how much it
saves them, and are pretty unconcerned with what an engineer thinks.
They just want to see bottom line return on investment.

Because our support costs are higher per seat at low volumes, the product
is priced accordingly.  We really hate to sell less than lots of 15 seats
or so, it's not cost effective.  When we come across those situations
we try and steer them towards CVS (can't beat the price), single user
(also free), or we may give them an extended eval license and tell them
to come back when they are bigger.  At our end, the cost of rolling out
a new commercial customer is about $10 - $15K in salaries.  Part of that
is normal support, part of that is that we almost always sweeten a sale
by letting the customer say "I'm not going to buy unless it does XYZ"
provided that XYZ is something we think is generically useful.  So the
sale gets to shuffle our priorities a bit and that ends up costing
us extra money.  It's all good, it just means that if a sale is less than
$15K we probably don't want it.  We love the level of support we give,
it's a huge part of why our users love BK, so we price where we have to
price.  We're not a low end, low service shop, quite the opposite.

The annual lease prices vary from $1K/seat for lots of seats to
$2.4K/seat for one seat (nobody leases or buys one seat, they use it in
single user mode).  The buy prices range from $2800/seat to $5800/seat.
The buy vs lease trade off is such that it is between 4 and 6 years before
it becomes cheaper to have bought than to have leased so everyone leases.
A seat is defined as a person who makes changes and floats automatically
every three months (to handle employee turnover, that sort of thing).

Noone has ever given us $5K for a seat and I doubt very much that anyone
ever will.  Everyone leases and they lease at high enough volumes that 
the lease price is around $1.5K.  

A couple things are worth noting.  We compete mostly with <insert market
leader here, we'll call them BIG>.  Our lease prices, at high enough
volumes, are the same as or lower than BIG annual support prices.
BIG runs around $5K/seat plus 20% / year in support.  So we're quite
competitive on the licensing costs.  But it gets much, much better.
The BIG architecture is centralized so performance bottlenecks are
also centralized.  As you add users you have to add server hardware.
It's very common to spend $300K on a big Sun SMP box to keep up with
the load.  A $2K PC can do the same thing with BK, look at bkbits.net,
it's a 750Mhz Athlon, it has about 2000 different users.  The next cost
center is administration.  Again, the centralized architecture means
that you pay people a lot of money to make sure that the BIG server
never dies because everyone goes home if it does.

We had a customer who had a site license for BIG and they wanted a 4 site
multisite config.  They asked us to price it for BIG and for BK.  They
already had some of the hardware and some of the people they would need,
and they didn't have to pay for BIG, just support, so these numbers are 
lower than they should.  Doesn't matter.  The costs for them worked out
to about $218K to get started plus $144K/year to keep going.  The BK
costs worked out to $8K to get started and $52K/year to keep going. 
5 year cost of ownership: BIG: $938, BK: $268.    The customer looked 
at our math and said "Your BIG costs are way too low but it doesn't 
matter, you made your point" and they bought BK seats.  Who wouldn't
if the numbers work out like that and the product suits your needs?

So, to reiterate, we don't publish our prices because an engineer will
look at $2000 and say "bug off, I'm not paying that much for that".  They
don't think that $2K is 1-2% of what their management pays them in a 
year, they don't think about the hardware costs, they don't think about
the people costs, they just go "I wouldn't pay for that so forget that".
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
