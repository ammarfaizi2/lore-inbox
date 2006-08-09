Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWHIPI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWHIPI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWHIPI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:08:58 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:47851 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1750937AbWHIPIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:08:55 -0400
Date: Wed, 9 Aug 2006 18:08:51 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Time to forbid non-subscribers from posting to the list?
Message-ID: <20060809150851.GH3021@mea-ext.zmailer.org>
References: <44D871DE.1040509@garzik.org> <MDEHLPKNGKAHNMBLJOLKIECNNKAB.davids@webmaster.com> <20060809143429.GD5815@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809143429.GD5815@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 04:34:30PM +0200, Folkert van Heusden wrote:
> > > The kernel developers who need to keep the barrier to bug reports low
> > > like the current policy.
> > > Get a good spam filter, I only get 1-2 pieces a day in my LKML folder.
> > 	How is everyone individually spam filtering better than one central spam
> > filter? More likelihood that at least one relevent person will get the bug
> > report? Certainly a single central spam filter can get more resources aimed
> > at it to make sure it doesn't suppress anything important.
> 
> What about just using the spamhaus.org blocklist at vger? Stops quite a
> bit of spam over here (http://keetweej.vanheusden.com/nspam_graph.png).

I have seen these lists classify major ISP relays as spam sources(*),
even classify VGER as one.  Their maintenance standards are varying,
some demand ridiculous things out of DNS zone SOA timers, some are
otherwise retarded in their "we are the world police, beware or be
sorry"..   and then they simply evaporate into the bit heaven.

(*) ISP user's main relays are spam fan-out sources way more often
than system keepers would like, but very few MTAs provide rate-limits
for anonymous ( = "non autenticated" ) users to keep a high-jacked
Windows machine from being effective spam-sources and utterly killing
the ISP relay..  (See "ASTA Recommendation".)
(Limiting spam-sending to 60 messages per hour of 240 rcpt per hour
can still get the relay to spam lists, but it won't flood internal
queues as badly as completely unlimited feed rates.)


Spamhouse and Spamcop have long(er) existence compared to most
DNS BLs, but still I am utterly worried...
("Many times burned, forever distrustful..")

> Folkert van Heusden
> www.vanheusden.com/multitail - multitail is tail on steroids. multiple
>                windows, filtering, coloring, anything you can think of

  /Matti Aarnio
