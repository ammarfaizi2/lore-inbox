Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSKODs1>; Thu, 14 Nov 2002 22:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265752AbSKODs1>; Thu, 14 Nov 2002 22:48:27 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:6411 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S265736AbSKODsY>; Thu, 14 Nov 2002 22:48:24 -0500
Date: Thu, 14 Nov 2002 22:58:09 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Thomas Molina <tmolina@cox.net>
cc: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
In-Reply-To: <Pine.LNX.4.44.0211142132500.2229-100000@dad.molina>
Message-ID: <Pine.LNX.4.44.0211142252590.13759-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Thomas Molina wrote:

> On Thu, 14 Nov 2002, Andrew Morton wrote:
>
> > "Martin J. Bligh" wrote:
> > >
> > > > While I have this on my mind I want to express this now since the
> > > > very first bug that hit my mailbox had this issue.
> > > >
> > > > I want to suggest that all reported bug in the database must be
> > > > reporducable with some release done by Linus or his BK sources.
> > > > And also that we can automatically close any BUG submissions that
> > > > have other patches applied.
> > >
> > > Hmmm ... I'm not sure that being that restrictive is going to help.
> > > Whilst bugs against any randomly patched version of the kernel
> > > probably aren't that interesting, things in major trees like -mm,
> > > -ac, -dj etc are likely going to end up in mainline sooner or later
> > > anyway ... wouldn't you rather know of the breakage sooner rather
> > > than later?
> >
> > So people will need to use their judgement as to whether the
> > problem is in 2.5.47, or in the -bk snapshot which was taken from
> > Linus, or in the -mm addons.
> >
> > If in doubt, people should go for the mailing list first.   Because
> >
> > a) the response time will be better
> > b) more people will see it
> > c) the owners of the add-on patches can screen it quickly.
>
> Has my 2.5 Problem Report Status postings been useful?  If so, when I
> discussed this with Martin one of the roles we agreed I would play was
> taking bug reports from the list and adding them to bugzilla.  I'll also
> be a "filter" for some of the issues discussed in this thread, sort of a
> janitor if you will.
>
> My question is how should compile failures figure into the bug database?
> Most of the compile failures are typos or thinkos that get quickly fixed.
> Should they get tracked, or dismissed quickly unless they linger on.  I
> didn't track simple compile failures in my list.

It'd be nice if people simply tried compiling a patched kernel (all
affected modules) before they submitted the patch, I'm betting you'd catch
a lot of typos.  Also, compiling _everything_, even as a module, at
least once before sumbitting the patch would probably help.

I'm sure people will miss one or two still, but so far I've found a fairly
high hit rate of things that simply won't compile in 2.5.x - also the main
reason that I hadn't actually used a 2.5.x kernel until now.

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu


