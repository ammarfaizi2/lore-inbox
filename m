Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVANWxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVANWxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVANWxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:53:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:18320 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261398AbVANWvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:51:52 -0500
Date: Fri, 14 Jan 2005 14:51:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050114221343.GA18140@thunk.org>
Message-ID: <Pine.LNX.4.58.0501141444360.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
 <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain>
 <20050113194246.GC24970@beowulf.thanes.org> <20050113200308.GC3555@redhat.com>
 <Pine.LNX.4.58.0501131206340.2310@ppc970.osdl.org>
 <1105644461.4644.102.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org> <20050114183415.GA17481@thunk.org>
 <Pine.LNX.4.58.0501141047470.2310@ppc970.osdl.org> <20050114221343.GA18140@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jan 2005, Theodore Ts'o wrote:
> 
> I disagree.  First of all, we can't know what motivates someone, and
> presuming that we know their motivation is something that should only
> be done with the greatest of care.  Secondly, someone who does want
> cheap PR can do so without delaying their disclosure; they can issue a
> breathless press release or "security advisory" about a DOS attack
> just easily with a zero-day disclosure as they can with a two-week
> delayed disclosure.

Your "secondly" is bogus.

Sure, you can do that, and if you do that, then the world recognizes you 
for what you are - nothing but a publicity-seeking creep.

THAT is why vendor-sec is bad. It allows publicity-seeking creeps to take 
on the mantle of being "good".

I'm arguing for exposing them for what they are. If that hurts some 
feelings, tough ;)

> >  (a) accepting that bugs happen, and that they aren't news, but making 
> >      sure that the very openness of the process means that people know
> >      what's going on exactly because it is _open_, not because some news 
> >      organization had to make a big stink about it just to make a vendor
> >      take notice.
> 
> A one or two week delay is hardly cause for "a news organization to
> make a big stick so vendors will take notice". 

You ignore reality.

It's not a one- or two-week delay. Once the vendor-sec mentality takes 
effect, the delay inevitably grows. You _always_ have excuses for 
delaying, and as shown by this thread, a _lot_ of people believe them.

Also, even a one- or two-week delay _is_ actually detrimental. It means 
that you can't handle the problem when it happens, so it gets queued up. 
People cannot inform unrelated third parties about their patches (because 
they are embargoed), which means that they get out of sync, and suddenly 
the thing that open source is so good at - namely making communication 
work well - becomes a problem.

> > And let's not kid ourselves: the security firms may have resources that 
> > they put into it, but the worst-case schenario is actual criminal intent. 
> > People who really have resources to study security problems, and who have 
> > _no_ advantage of using vendor-sec at all. And in that case, vendor-sec is 
> > _REALLY_ a huge mistake. 
> 
> Nah.  If you have criminal intent, generally there are far easier ways
> to target a specific company.

The spam-viruses clearly show that that isn't always true, though. The 
advantage to targeting the whole infrastructure _is_ clearly there.

			Linus
