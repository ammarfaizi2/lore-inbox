Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVBOBFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVBOBFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVBOBDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:03:47 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:12173 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261582AbVBOBBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:01:09 -0500
Subject: Re: [BK] upgrade will be needed
From: Steven Rostedt <rostedt@goodmis.org>
To: Larry McVoy <lm@bitmover.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050215003535.GB32158@bitmover.com>
References: <3586df11f3bb037ab4b0284109ff9c0a@dalecki.de>
	 <200502140923.03155.rmiller@duskglow.com>
	 <20050214174932.GB8846@bitmover.com>
	 <1108406835.8413.20.camel@localhost.localdomain>
	 <20050214190137.GB16029@bitmover.com>
	 <1108415541.8413.48.camel@localhost.localdomain>
	 <20050214231148.GP13174@bitmover.com>
	 <1108425420.8413.78.camel@localhost.localdomain>
	 <20050215000028.GS13174@bitmover.com>
	 <1108426451.8413.84.camel@localhost.localdomain>
	 <20050215003535.GB32158@bitmover.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 14 Feb 2005 20:00:59 -0500
Message-Id: <1108429259.8413.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 16:35 -0800, Larry McVoy wrote:
> On Mon, Feb 14, 2005 at 07:14:11PM -0500, Steven Rostedt wrote:
> > On Mon, 2005-02-14 at 16:00 -0800, Larry McVoy wrote:
> > > How about this?
> > > 
> > > http://lkml.org/lkml/2003/12/14/47
> > 
> > I don't know about others, but it solves my issues.  I'm one of the many
> > that use BK not for the changes, but just for the snapshots. This seems
> > to do it.  Warning, you will still not please a lot of the complainers
> > on the list, but myself (and others) would be satisfied.
> 
> Well it would sure help if you said that in public.  Unless people ask
> for this we aren't going to go build it and support it on bkbits.net.
> It needs to solve problems for a pile of people or we can't afford to do
> it.
> 

I wasn't very active on the list back then, but post something like this
again and I'll second it publicly. You may have already done so, but I
might have missed it. I'll cc the LKML to make this public anyway.

> > As someone mentioned. Still do what you were going to do (keep BK free
> > for Open Source albeit the restriction). But have this for those of us
> > that can't go with the restriction, but still like the latest snapshots
> > of the kernel. In essence, two free versions, where one is "more free"
> > but also "crippled".
> 
> There are HUGE costs with maintaining multiple versions, I'd like to
> avoid that.  We've specced out what it would cost us to maintain 
> old/new versions that talked to each other and it's more or less twice
> as much engineering because you have to backport each new feature needed
> for compat, you have to figure out which bugs have to be backported,
> etc., etc.  It is very very expensive and takes up the resources of our
> most important people.

I don't know the architecture of the tool, but I've worked on some
pretty big projects, that could disable most of the tool with just a
simple config option. Heck, the Linux kernel does this.  But if the
design of the tool is such that you can't disable features without
destroying others (like removing IE from Windows),  then I guess this is
not an option. 

I guess you are dealing with three groups of people.

1) The ones paying you. The companies that spend money to get things
done.  -- Needs full version of BK.

2) The Open Source developers, Linus and others that like BK and will
work with it with whatever license you give it. -- Needs strong version
of BK. Probably no more than 100 users (or less).

3) The Open Source users, tweakers, hackers that are not the core
developers. -- Needs only to checkout the kernel. Probably over 1000
users.  I fall in this category.

This is why we have asked about three versions. Obviously, Linus and
friends are the most important part for the Linux community, so even if
it hurts 2000 other people that only want to download the lastest
snapshots from BK, it really doesn't matter.  Let us complain, but
unless Linus decides to go elsewhere, we are stuck.  So don't do the
crippled version if it hurts Linus.

-- Steve


