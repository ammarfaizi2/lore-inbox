Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVAMXEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVAMXEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVAMXB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:01:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54243 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261779AbVAMW5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:57:39 -0500
Date: Thu, 13 Jan 2005 17:28:14 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: security contact draft
Message-ID: <20050113192814.GA8176@logos.cnet>
References: <20050113125503.C469@build.pdx.osdl.net> <1105647058.4624.134.camel@localhost.localdomain> <Pine.LNX.4.58.0501131325560.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501131325560.2310@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 01:31:19PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 13 Jan 2005, Alan Cox wrote:
> > 
> > It's not documenting the stuff Linus seems to be talking about which is
> > a public list ? Or does Linus want both ?
> 
> I see myself as pretty extreme when it comes to my approach to security.
> 
> And I actually distrust extremes. I'm at one end of the spectrum, and
> vendor-sec is at the other (I'm not even counting the head-in-the-sand
> approach as part of the spectrum ;). Knowing that, I'd expect that most
> people are somewhere in between.
> 
> Which to me implies that while what I personally _want_ is total openness, 
> that's not necessarily what makes the most sense in real life.

Gooood :) 

> So I want to give people choice. I want to encourage openness. But hell, 
> if we have a closed list with a declared short embargo that is known to 
> not play games (ie clock starts ticking from original discovery, not from 
> somebody elses embargo), that's good too.
> 
> Let people vote with their feet. If vendor-sec ends up being where all the
> "important" things are discussed - so be it. We've not lost anything, and
> at worst a "kernel-security" list would be a way to discuss stuff that was
> already released by vendor-sec.

On my understanding we are about to win several things.

I rather prefer having vendorsec NOT deal with these issues because 
it gives autonomy to the kernel team. It wont depend on "suspicious" criteria
of embargo's - but instead have a clear written policy for embargo's.

And the timeframe, as Alan says, has to be acceptable for the vendors to 
generate their updates and run the QA process, otherwise things will 
continue to be discussed at vendorsec.

Other than that, by not "wrapping" the fixes with non descritive changelogs,
we will have an official list of security problems. Hey, this is a serious 
operating system.

Wrapping up fixes means "disclosure" for the better informed people 
(the bad guys) who read the changesets, and means "lack of knowledge" 
for the less informed - users who dont run the latest kernel and only 
upgrade in case of public security issues (the majority of them?).

So the argument of "wrapping" up fixes for "better and safer code" is actually
very bad if you think about it. 

Once we have that, there will be a "official" list of known issues.

Those MANY who ask
"I'm using v2.6.12 on my customized kernel and I can't upgrade to the latest
v2.6.20 kernel, which security bugs exist that I need fixed?"

Will have an easy answer.

This is better for the Linux kernel developers, better for vendors and better
for users.


