Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVFQVqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVFQVqF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 17:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVFQVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 17:46:04 -0400
Received: from dvhart.com ([64.146.134.43]:65450 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262094AbVFQVpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 17:45:43 -0400
Date: Fri, 17 Jun 2005 14:45:39 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: kernel bugzilla
Message-ID: <491950000.1119044739@flay>
In-Reply-To: <20050617212338.GA16852@suse.de>
References: <20050617001330.294950ac.akpm@osdl.org> <1119016223.5049.3.camel@mulgrave> <20050617142225.GO6957@suse.de> <20050617141003.2abdd8e5.akpm@osdl.org> <20050617212338.GA16852@suse.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It can be set up to report scsi bugs to a mailing list.  So we can replace
>> andmike with linux-scsi@vger.kernel.org as the person who gets notification
>> emails for scsi-related bug reports.
> 
> That would help.

The other thing we can do is set up "spoof" users per category, then 
anyone can just set up that spoof user to watch, and they'll see things
for each category. Some of them are like that already.

Frankly, I think a lot of people would prefer to subscribe to
bugme-new@lists.osdl.org, and then filter on the X- headers that give 
you category and subcategory nicely. That way you get one email for
each NEW bug. depends what you want.
 
>> And, apparently, bugzilla will now accept emails and will file them away in
>> the right place.  I've asked Martin to help set bugzilla up so that people
>> who don't have a bugzilla account will be accepted into the database as well.
> 
> See, that is very useful. The SUSE bugzilla used to be able to do that
> as well (it probably still does but requires password etc, already too
> much hassle) and I loved it. The thing about this kind of bug tracking
> is that it must be just as easy and convenient to use as email. And
> jumping to a browser and waving the mouse around scrolling to the right
> place to input text is already cumbersome imho compared to just
> answering an email (which can be done clickity-less).

Is done now. Please try, but be gentle with it. And send beer to Kees ;-)
 
>> I haven't tested this yet, but hopefully I will now be able to:
>> 
>> - get an email from bugme
>> 
>> - reply to it and cc linux-kernel and a maintainer
>> 
>> - Other people will comment in the normal manner with reply-to-all
>> 
>> - bugzilla will capture everything.
>> 
>> Suddenly, my ability to track open bugs gets a heap better, and nobody is
>> impacted at all - just an additional Cc.
> 
> That is the way it should work.

I think it will now. We probably need some more crap-filtering (rmk
pointed out signatures, for instance, not sure if we do that already).
Apologies this has taken a while.
 
>> One thing I haven't worked out is how to get a bug which is initially
>> reported via email *into* the bugzilla system for tracking purposes.  One
>> could just ask the originator to raise a bugzilla entry, as lots of other
>> projects do.  But I don't think we want to do that - it's in our interest
>> to make bug reporting as easy as possible for the reporter, rather than
>> putting up barriers.
> 
> Depends... Sometimes it's quite ok to put the onus on the reported to
> file it in bugzilla, since it should be considered in his best interest
> to do so - he obviously filed the bug, because the issue bothers him in
> some way. As long as it is 'easy enough' to do so, I think we are
> alright. The question is if this can't be automated fairly easily. A
> good bugzilla interface helps a _lot_.

The external one is infintely simpler than the internal IBM one, and
the distro ones. I *really, really* prefer to keep it that way. Having 
said that, it does have a few fields (eg version, and category/subcategory) that should be filled out properly, and that's not easy to do via email.
For now, my intent is to allow bug filing via web only, and followup 
comments by email. If lots of people scream and curse at me, I'll
reconsider I suppose.

>> Another problem is: what happens if a bug has been discussed via email
>> which is cc'ed to linux-kernel and bugzilla, and then someone comes along
>> and updates the bug record via the bugzilla web interface?  I suspect those
>> people who had been following the discussion via email wouldn't see the
>> update.  So bugzilla needs to a) automatically add all incoming Cc's to the
>> records's cc list and b) automatically add all known cc's to outgoing
>> notifications.
> 
> At the risk of making bugzilla just a little too annoying, if you find
> yourself having to manually remove the cc in selected bug entries just
> because you participated in the thread at some point.

I think this could easily be a per-user preference. I think akpm would
like it to default to on, which would be OK by me, at least.

Apologies for neglecting Bugzilla a bit recently, I shall get back on it.
Kudos to Jon Tollefson (IBM) and Kees Cook (OSDL) for doing most of
the technical work recently.

M.
