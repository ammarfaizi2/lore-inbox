Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTJLVwS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 17:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTJLVwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 17:52:18 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:49294 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261188AbTJLVwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 17:52:17 -0400
Date: Sun, 12 Oct 2003 22:52:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: retu <retu834@yahoo.com>
Cc: Kenn Humborg <kenn@linux.ie>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model
Message-ID: <20031012215200.GA15749@mail.shareable.org>
References: <20031012115900.GC13427@mail.shareable.org> <20031012160419.30891.qmail@web13007.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031012160419.30891.qmail@web13007.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

retu wrote:
> What's the solution out of this - a clean, open object
> model designed by the core folks, extensible and free
> of licensing issues - and that in the next months.  

You still haven't said a single word about why this is good.
You haven't explained a _single_ advantage.

If you want anyone to take you seriously, you have to do this.  Give
real, convincing examples of what could be done, and why it's much
better, to justify the work of creating the model.

Perhaps you think your idea is self-evidently great, so you don't need
to explain why it is?  Well, it isn't.  I've seen startups fail due to not
grasping this basic point.

Almost everyone here does not think this is a good idea.  But we're
all old and prejudiced around here.  Perhaps we are mistaken, but if
so it's up to you to explain _why_.  Just saying "we need an object
model" will not convince anyone.

If you look into the kernel right now, you see that it's one of the
most object oriented C programs you will find.  There's even a type
called "kobject".  Another well known polymorphic object is called
"fd".  "pid_t" really is an object.  Filesystems, buses, devices,
network cards, protocols, timers and many other things have
hierarchies of object types inside the kernel.

It seems to me we _already_ have an object model in the kernel, and
it's a pretty good one because people figure out how to use it very
easily.  So what is wrong with the object model we already have?
Convince us, because what we have seems to be working quite well.

-- Jamie
