Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbTBXRzw>; Mon, 24 Feb 2003 12:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbTBXRzw>; Mon, 24 Feb 2003 12:55:52 -0500
Received: from air-2.osdl.org ([65.172.181.6]:42880 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266806AbTBXRzu>; Mon, 24 Feb 2003 12:55:50 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: "Timothy D. Witham" <wookie@osdl.org>
To: Larry McVoy <lm@bitmover.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030222161356.GA11953@work.bitmover.com>
References: <96700000.1045871294@w-hlinder>
	 <20030222001618.GA19700@work.bitmover.com> <306820000.1045874653@flay>
	 <20030222024721.GA1489@work.bitmover.com> <14450000.1045888349@[10.10.2.4]>
	 <20030222050514.GA3148@work.bitmover.com>
	 <1045903113.26056.6.camel@rth.ninka.net>
	 <20030222143440.GA10546@work.bitmover.com>
	 <26210000.1045928873@[10.10.2.4]>
	 <20030222161356.GA11953@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Sourcre Development Lab, Inc
Message-Id: <1046109605.1962.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 10:00:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 08:13, Larry McVoy wrote:
> On Sat, Feb 22, 2003 at 07:47:53AM -0800, Martin J. Bligh wrote:
> > >> > Let's see, Dell has a $66B market cap, revenues of $8B/quarter and 
> > >> > $500M/quarter in profit.    
> > >> 
> > >> While I understand these numbers are on the mark, there is a tertiary
> > >> issue to realize.
> > >> 
> > >> Dell makes money on many things other than thin-margin PCs.  And lo'
> > >> and behold one of those things is selling the larger Intel based
> > >> servers and support contracts to go along with that.  
> > > 
> > > I did some digging trying to find that ratio before I posted last night
> > > and couldn't.  You obviously think that the servers are a significant
> > > part of their business.  I'd be surprised at that, but that's cool,
> > > what are the numbers?  PC's, monitors, disks, laptops, anything with less
> > > than 4 cpus is in the little bucket, so how much revenue does Dell generate
> > > on the 4 CPU and larger servers?
> > 
> > It's not a question of revenue, it's one of profit. Very few people buy
> > desktops for use with Linux, compared to those that buy them for Windows.
> > The profit on each PC is small, thus I still think a substantial proportion
> > of the profit made by hardware vendors by Linux is on servers rather than
> > desktop PCs. The numbers will be smaller for high end machines, but the
> > profit margins are much higher.
> 
> That's all handwaving and has no meaning without numbers.  I could care less
> if Dell has 99.99% margins on their servers, if they only sell $50M of servers
> a quarter that is still less than 10% of their quarterly profit.  
> 
> So what are the actual *numbers*?  Your point makes sense if and only if
> people sell lots of server.  I spent a few minutes in google: world wide
> server sales are $40B at the moment.  The overwhelming majority of that
> revenue is small servers.  Let's say that Dell has 20% of that market,
> that's $2B/quarter.  Now let's chop off the 1-2 CPU systems.  I'll bet
> you long long odds that that is 90% of their revenue in the server space.
> Supposing that's right, that's $200M/quarter in big iron sales.  Out of
> $8000M/quarter.  
> 
  The numbers that I have seen are covered under an NDA so I can' put 
them out but an important point to note is that while there is a very
sharp decrease in the number of servers sold as you go hight up into
the price bands the total $ in revenue is hourglass shaped.  With
the neck being in a price band that corresponds to a 4 way server.

  The total $ spent on the highest band of servers is about equal
to the total $ spent on the lowest price band of servers.  But the
margins for the high end are much better than the margins for the
lowest band.

> I'd love to see data which is different than this but you'll have a tough
> time finding it.  More and more companies are looking at the cost of 
> big iron and deciding it doesn't make sense to spend $20K/CPU when they
> could be spending $1K/CPU.  Look at Google, try selling them some big
> iron.  Look at Wall Street - abandoning big iron as fast as they can.

  Oh, you can see it, it will just cost you about $50,000 to get the
survey from the company that spends all the money putting it together.

  On the size of the system, every system should be as big as it needs
to be.  Some problems partition nicely, like Google but other ones
do not, like accounts receivable.  It all seems to come down to the
question, "Does the data _naturally_ partition?"  If it does then
you should either use lots of small servers or a s/390 type solution
with lots of instances.  However if the data doesn't naturally partition
you should use one large machine as you will spend more money on
people trying to manage the servers than you would of spent initially
on the hardware.

  Also you need to look at the backend systems in places like Wall
Street, those are big machines, have been for a long time and
aren't changing out.  But it doesn't make a good story.

Tim 


-- 
Timothy D. Witham <wookie@osdl.org>
Open Sourcre Development Lab, Inc
