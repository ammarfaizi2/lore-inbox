Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319507AbSIJPZV>; Tue, 10 Sep 2002 11:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319547AbSIJPZV>; Tue, 10 Sep 2002 11:25:21 -0400
Received: from bitmover.com ([192.132.92.2]:56711 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S319507AbSIJPZU>;
	Tue, 10 Sep 2002 11:25:20 -0400
Date: Tue, 10 Sep 2002 08:29:59 -0700
From: Larry McVoy <lm@bitmover.com>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: jbradford@dial.pipex.com, ookhoi@humilis.net, Dieter.Nuetzel@hamburg.de,
       linux-kernel@vger.kernel.org, erin_hartin@maxtor.com,
       sales-mkt@maxtor.com
Subject: Re: ide drive dying?
Message-ID: <20020910082959.F4462@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Mike Dresser <mdresser_l@windsormachine.com>,
	jbradford@dial.pipex.com, ookhoi@humilis.net,
	Dieter.Nuetzel@hamburg.de, linux-kernel@vger.kernel.org,
	erin_hartin@maxtor.com, sales-mkt@maxtor.com
References: <200209101456.g8AEuwAV000592@darkstar.example.net> <Pine.LNX.4.33.0209101115060.20848-100000@router.windsormachine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0209101115060.20848-100000@router.windsormachine.com>; from mdresser_l@windsormachine.com on Tue, Sep 10, 2002 at 11:21:24AM -0400
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 11:21:24AM -0400, Mike Dresser wrote:
> On Tue, 10 Sep 2002 jbradford@dial.pipex.com wrote:
> 
> > According this this announcement:
> >
> > http://www.shareholder.com/maxtor/news/20020909-89588.cfm
> >
> > some of their new ATA drives will carry a three-year warranty.
> >
> > John.
> 
> Right.  Only the MaxLine II.  The rest, not including SCSI, are 1 year.
> 
> It looks to me that Maxtor is exiting the consumer market.  They sell
> their crippled DiamondMax 9/16's, and the existing product lines, to the
> OEM's who don't care about warranty as much.

Well can you blame them?  Drive prices are coming down faster than processor
prices and it costs a lot more to produce a drive than a processor (production
costs, not development costs).  Drives have parts.  The head assembly isn't
free.  It's unbelieveable that we can get drives for $1/GB, at least it is
to me.  And if any of us think we're getting reliable drives at this price,
a visit from the tooth fairy can't be far behind.

What we do here is mark the date we put a drive into production on the drive
then cycle the drive out of production use in 24 months.  We have lots of
build machines so the "old" drives go into those.  We also put in 4 drives
for any data we care about (on a 3ware escalade in JBOD mod) and then 
mirror the data nightly to /nightly, /weekly, or /monthly.  If I'm really
being paranoid, I mix manufacters and release dates in the set of 4 drives
so I drop the likelihood of them all failing at once.

Don't get me wrong, there is no love lost between BitMover and Maxtor, 
they aren't a customer and we've had our own problems dealing with them
in the past.  However, it seems unfair to get too unhappy with a product
that works as well as it does for the price that you pay.  I'd hate to
be in the drive business, it looks like a losing proposition to me.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
