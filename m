Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWIVP5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWIVP5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWIVP5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:57:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53685 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964775AbWIVP5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:57:32 -0400
Subject: Re: GFS2 & DLM merge request
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060922143627.GA24953@infradead.org>
References: <1158935874.11901.408.camel@quoit.chygwyn.com>
	 <20060922143627.GA24953@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 22 Sep 2006 17:02:24 +0100
Message-Id: <1158940944.11901.417.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-09-22 at 15:36 +0100, Christoph Hellwig wrote:
> On Fri, Sep 22, 2006 at 03:37:54PM +0100, Steven Whitehouse wrote:
> > Hi,
> > 
> > Linus, I believe that all the outstanding issues raised by Christoph,
> > Jan and others relating to GFS2 and DLM are now settled. Please
> > therefore consider pulling from:
> 
> Clear NACK from me.  The mails I replied to where only the mails Jan started
> nitpicking and I looked a little deeper at what he already quoted, maybe
> 5% of the codebase.  Given the horrors I found there I'm pretty sure there
> will be quite a few more.  And given the amount of junk Andrew plans to push
> to Linus for 2.6.19 I'll be pretty busy to look at that, aswell as looking
> at things I promised David for month now, so I'm a little busy.
> 
Well I hope that we don't have too many more "horrors" left in the code.
It has after all been out for review many times in the last year and I
hope we've not done too bad a job of incorporating all the suggested
changes so far.

When I spoke to you at OLS you did promise me that you'd look at the
code in more detail and that was more than a month ago now. I know there
is a lot else to be reviewed as well as GFS2 and we need to wait our
place in the queue as it were, but it would be helpful to know where
that place is, so we can then try our best to work with the process.

> >  include/linux/fs.h                 |    3 
> >  include/linux/iflags.h             |  102 
> >  include/linux/kernel.h             |    1 
> >  mm/filemap.c                       |    3 
> >  mm/readahead.c                     |    1 
> 
> And while we're at it, please don't push core change as part of a subsystem
> tree ever.  They should go into clearly marked and separately patches via
> -mm.

Ok, I'm quite happy to do that. They are pretty minor changes, but the
usual argument is that such changes are not acceptable until there is
something in the kernel that makes use of them, and they have to happen
one way around or the other,

Steve.


