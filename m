Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbSKOCpM>; Thu, 14 Nov 2002 21:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSKOCpL>; Thu, 14 Nov 2002 21:45:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:38380 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265628AbSKOCpL>;
	Thu, 14 Nov 2002 21:45:11 -0500
Message-ID: <3DD4614B.A57EE8C5@digeo.com>
Date: Thu, 14 Nov 2002 18:51:55 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
References: <1037325839.13735.4.camel@rth.ninka.net> <396026666.1037298946@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 02:51:56.0493 (UTC) FILETIME=[F5DCE7D0:01C28C51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> > While I have this on my mind I want to express this now since the
> > very first bug that hit my mailbox had this issue.
> >
> > I DO NOT want to be working on bugs on anything other than Linus's
> > actualy sources.  The first bug I got was a networking bug with
> > Andrew Morton's -mm patches applied.
> >
> > This isn't going to work if that is what people are going to be
> > allowed to do.
> >
> > I want to suggest that all reported bug in the database must be
> > reporducable with some release done by Linus or his BK sources.
> > And also that we can automatically close any BUG submissions that
> > have other patches applied.
> 
> Hmmm ... I'm not sure that being that restrictive is going to help.
> Whilst bugs against any randomly patched version of the kernel
> probably aren't that interesting, things in major trees like -mm,
> -ac, -dj etc are likely going to end up in mainline sooner or later
> anyway ... wouldn't you rather know of the breakage sooner rather
> than later?

Well for that particular tree, the diff from mainline is quite
small, and those diffs are avowedly experimental.  That's why
it exists - the get fresh code some testing and exposure.

So people will need to use their judgement as to whether the
problem is in 2.5.47, or in the -bk snapshot which was taken from
Linus, or in the -mm addons.

If in doubt, people should go for the mailing list first.   Because

a) the response time will be better
b) more people will see it
c) the owners of the add-on patches can screen it quickly.

But hey.  It's early days yet, and it is easy to overdesign this 
sort of thing.  I'd say just start using the thing, and adapt
the work processes later on, based on some experience.
