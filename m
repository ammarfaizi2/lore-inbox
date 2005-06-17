Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVFQVWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVFQVWf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVFQVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 17:22:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2732 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262083AbVFQVW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 17:22:28 -0400
Date: Fri, 17 Jun 2005 23:23:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: kernel bugzilla
Message-ID: <20050617212338.GA16852@suse.de>
References: <20050617001330.294950ac.akpm@osdl.org> <1119016223.5049.3.camel@mulgrave> <20050617142225.GO6957@suse.de> <20050617141003.2abdd8e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050617141003.2abdd8e5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17 2005, Andrew Morton wrote:
> 
> (Seeing as I did all this typing I added linux-kernel and changed the
> subject.  I trust that's OK).
> 
> Jens Axboe <axboe@suse.de> wrote:
> >
> > > If bugzilla can now collect email, just have it forward the bug reports
> > > to linux-scsi as through it were from the reporter with itself on the cc
> > > list.
> 
> It can be set up to report scsi bugs to a mailing list.  So we can replace
> andmike with linux-scsi@vger.kernel.org as the person who gets notification
> emails for scsi-related bug reports.

That would help.

> And, apparently, bugzilla will now accept emails and will file them away in
> the right place.  I've asked Martin to help set bugzilla up so that people
> who don't have a bugzilla account will be accepted into the database as well.

See, that is very useful. The SUSE bugzilla used to be able to do that
as well (it probably still does but requires password etc, already too
much hassle) and I loved it. The thing about this kind of bug tracking
is that it must be just as easy and convenient to use as email. And
jumping to a browser and waving the mouse around scrolling to the right
place to input text is already cumbersome imho compared to just
answering an email (which can be done clickity-less).

> > imho, the kernel.org bugzilla should be abandoned.
> 
> That's what I used to think.  Until I started trying to keep track of open
> bugs against late -rc kernels.  Now, the ability which bugzilla has to keep
> track of open bugs and to keep track of all the correspondence associated
> with a bug is looking really attractive.

I never disputed that it isn't useful. It is/was just a bother to use.

> That's why I want it to integrate seamlessly with our normal email-based
> processes.  So we can get the best of both worlds.

Indeed, that is the key to making it useful.

> > is anyone
> > (developers) using it successfully?
> 
> The ACPI team use bugzilla a lot.
> 
> For those bugs which are handled in bugzilla rather than via random emails,
> yeah, I'm finding bugzilla preferable.
> 
> 
> I haven't tested this yet, but hopefully I will now be able to:
> 
> - get an email from bugme
> 
> - reply to it and cc linux-kernel and a maintainer
> 
> - Other people will comment in the normal manner with reply-to-all
> 
> - bugzilla will capture everything.
> 
> Suddenly, my ability to track open bugs gets a heap better, and nobody is
> impacted at all - just an additional Cc.

That is the way it should work.

> One thing I haven't worked out is how to get a bug which is initially
> reported via email *into* the bugzilla system for tracking purposes.  One
> could just ask the originator to raise a bugzilla entry, as lots of other
> projects do.  But I don't think we want to do that - it's in our interest
> to make bug reporting as easy as possible for the reporter, rather than
> putting up barriers.

Depends... Sometimes it's quite ok to put the onus on the reported to
file it in bugzilla, since it should be considered in his best interest
to do so - he obviously filed the bug, because the issue bothers him in
some way. As long as it is 'easy enough' to do so, I think we are
alright. The question is if this can't be automated fairly easily. A
good bugzilla interface helps a _lot_.

> Another problem is: what happens if a bug has been discussed via email
> which is cc'ed to linux-kernel and bugzilla, and then someone comes along
> and updates the bug record via the bugzilla web interface?  I suspect those
> people who had been following the discussion via email wouldn't see the
> update.  So bugzilla needs to a) automatically add all incoming Cc's to the
> records's cc list and b) automatically add all known cc's to outgoing
> notifications.

At the risk of making bugzilla just a little too annoying, if you find
yourself having to manually remove the cc in selected bug entries just
because you participated in the thread at some point.

-- 
Jens Axboe

