Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTITUPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 16:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTITUPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 16:15:16 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:15763 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261959AbTITUPK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 16:15:10 -0400
Date: Sat, 20 Sep 2003 13:14:56 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Larry McVoy <lm@bitmover.com>, Bernd Schmidt <bernds@redhat.com>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Gateways (was Re: Fix for wrong OOM killer trigger?)
Message-ID: <20030920201456.GA22065@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jamie Lokier <jamie@shareable.org>, Larry McVoy <lm@bitmover.com>,
	Bernd Schmidt <bernds@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20030919191613.36750de3.bless@tm.uka.de> <20030919192544.GC1312@velociraptor.random> <20030919203538.D1919@flint.arm.linux.org.uk> <20030919200117.GE1312@velociraptor.random> <20030919205220.GA19830@work.bitmover.com> <20030920033153.GA1452@velociraptor.random> <20030920043026.GA10836@work.bitmover.com> <Pine.LNX.4.55.0309201305430.21919@host140.cambridge.redhat.com> <20030920135430.GA17559@work.bitmover.com> <20030920195610.GB8953@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030920195610.GB8953@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20, 2003 at 08:56:10PM +0100, Jamie Lokier wrote:
> Larry McVoy wrote:
> > Nonsense.  This isn't closed source issue at all because the issue is the
> > CVS gateway.  You don't need source to write that gateway and you could
> > have (and recall that Linus said you should have) written the gateway 
> > yourself, hosted it yourself, and maintained it yourself.
> 
> I was prepared to write such a gatway.
> 
> We discussed it, and found that the combination of BitKeeper license
> and BitMover's control over the kernel repository prevents it.  This
> was the subject of a heated debate.
> 
> I believe that debate was the reason BitMover wrote and now host the
> BK->CVS gateway, which other gateways are built upon.
> 
> It's a brilliant solution, and thank you, I am glad of your work,
> but let's not pretend that a 3rd party is in a position to offer such
> a gateway.

Anyone who obeys the license is welcome to write a gateway.  Lots of
people have done lots of interesting things around BK without violating
the license.  You explicitly stated an intent that violated the license,
so no, _you_ can't write one but plenty of other people can.

Let's also not pretend that it is an easy task or that keeping it
working is easy.  We're going from a system that works to a system that
is extremely fragile.  When it breaks it takes about 4-5 hours of a
2.1Ghz Athlon with a GB of ram to rebuild the gateway.

Let's also not pretend that it is cheap to host this.

It's all well and good to complain that you weren't allowed or whatever,
but unless you are going to build the gateway, make it work, make it
keep working, host it, and maintain that host, then you need to stop
pretending that you were going to solve the problem.  You were prepared
to _attempt_ to write such a gateway.  Pavel was going to write one,
Daniel was just dieing to write a BK replacement, etc.  Lots of people
would love to have a BK replacement but they all go look at the problem
space and find out it's a lot harder than they thought and they go work
on something more fun.

I'd really like to know what all you guys would do if you were in
my shoes.  Over and over you are willing to throw stones but not one
of you has done 1/100th of the SCM work required to replace BK or even
build a gateway.  Complaining is fun and all, but I'd sure like to see
you come up with and actually execute on a plan that provides everything
we provide and has a GPLed result.  That would be an amazing feat and
I'd come work for you.  Until you do, however, how about backing down
a bit?  In spite of all the flames, we have an excellent track record
of providing you free service, providing you free tools, and providing
you free support.  In the face of your non-stop complaining that's pretty
amazing and is it really so much to ask you to leave off the flaming?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
