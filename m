Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbWF2VLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWF2VLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWF2VLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:11:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:5091 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932464AbWF2VL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:11:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Thu, 29 Jun 2006 23:11:51 +0200
User-Agent: KMail/1.9.3
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>,
       "Rahul Karnik" <rahul@genebrew.com>, "Jens Axboe" <axboe@suse.de>,
       linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <84144f020606282219n269fffe2i27bdd789758cc268@mail.gmail.com> <200606291544.18392.nigel@suspend2.net>
In-Reply-To: <200606291544.18392.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606292311.51703.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 29 June 2006 07:44, Nigel Cunningham wrote:
> On Thursday 29 June 2006 15:19, Pekka Enberg wrote:
> > On 6/29/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > > Sure, I know where I'd be headed, but it would be a huge waste of time
> > > and effort.
> >
> > Perhaps to you Nigel.  For the rest of us reviewing your patches, it's
> > much better.  I suspect it would be better for the users down the road
> > as well.  I don't know if you realize it, but what you're doing now
> > is, "here's a big chunck of code, take it or leave it".  And at least
> > historically people have had hard time doing getting stuff merged like
> > that.
> 
> I did try really hard not to do that (big chunk of code, take it or leave it). 
> That's why it's split up into so many little patches. The problem seems to be 
> that it's not split up in the way some people wanted, rather than not split 
> up at all. I want to make it easier on you guys, but it just seems to me like 
> regardless of what I do, it's not the right thing.

I think the problem is that you want it merged all at once, and it's too much
code for doing so.  The splitting is a separate thing - previously the patches
were too big, now they are too small, but from the reviewer's point of view
it's about the same: you can't get a grip on what's going on and why.

> I can understand wanting small changes to swsusp to transform it into 
> suspend2, but I also understand that I've spent approximately 5 years of 
> developing from the point Pavel forked the code base until today, and part of 
> that has been two complete reworkings of the way in which the data is stored 
> and the thing operates - irreducible complexity that just doesn't fit into 
> the incremental change model. So I'm trying to do what seems to me to be the 
> next best thing. Having arranged functions that deal with particular parts of 
> the system into individual files, I've broken the files up into logical parts 
> and submitted them in groups. If we consider the more primitive parts first, 
> then move to the increasingly abstract operations (or vice versa), I think 
> we'll have a good approach with what's already done.

No.  The additional work on your part _is_ _needed_ so that _other_ _people_
may feel comfortable with your code in the kernel.  Now, apparently, they are
not, for various reasons, and you're just refusing to help them.

Greetings,
Rafael
