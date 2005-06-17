Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVFQVkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVFQVkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVFQVkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 17:40:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262097AbVFQVjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 17:39:12 -0400
Date: Fri, 17 Jun 2005 14:39:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: kernel bugzilla
Message-Id: <20050617143946.00f387d0.akpm@osdl.org>
In-Reply-To: <20050617212338.GA16852@suse.de>
References: <20050617001330.294950ac.akpm@osdl.org>
	<1119016223.5049.3.camel@mulgrave>
	<20050617142225.GO6957@suse.de>
	<20050617141003.2abdd8e5.akpm@osdl.org>
	<20050617212338.GA16852@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > One thing I haven't worked out is how to get a bug which is initially
> > reported via email *into* the bugzilla system for tracking purposes.  One
> > could just ask the originator to raise a bugzilla entry, as lots of other
> > projects do.  But I don't think we want to do that - it's in our interest
> > to make bug reporting as easy as possible for the reporter, rather than
> > putting up barriers.
> 
> Depends... Sometimes it's quite ok to put the onus on the reported to
> file it in bugzilla, since it should be considered in his best interest
> to do so - he obviously filed the bug, because the issue bothers him in
> some way. As long as it is 'easy enough' to do so, I think we are
> alright. The question is if this can't be automated fairly easily. A
> good bugzilla interface helps a _lot_.

Agree.  We should encourage people to use bugzilla as the initial
entry-point.  But if someone instead uses email as the first contact I'm
just a little bit reluctant to say "thanks, now go and try again".

Perhaps we could find some nice volunteer (hint) who could take the task of
transferring such reports into bugzilla.  There wouldn't be very many, really.

> > Another problem is: what happens if a bug has been discussed via email
> > which is cc'ed to linux-kernel and bugzilla, and then someone comes along
> > and updates the bug record via the bugzilla web interface?  I suspect those
> > people who had been following the discussion via email wouldn't see the
> > update.  So bugzilla needs to a) automatically add all incoming Cc's to the
> > records's cc list and b) automatically add all known cc's to outgoing
> > notifications.
> 
> At the risk of making bugzilla just a little too annoying, if you find
> yourself having to manually remove the cc in selected bug entries just
> because you participated in the thread at some point.

Yeah, maybe I'm a little unsympathetic about other people's email volume
problems ;)

