Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTD2CGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 22:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbTD2CGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 22:06:04 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:57552 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261506AbTD2CGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 22:06:02 -0400
Date: Mon, 28 Apr 2003 19:18:11 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: dev@bitmover.com
Subject: bkbits.net future directions
Message-ID: <20030429021811.GD27729@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dev@work.bitmover.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're working on a second generation bkbits infrastructure.  There were
some things we did wrong the first time around (not surprising, it was
a weekend hack attack to provide the PPC kernel folks with a place to
stash their stuff).

We need a more formal database for all the non-BK stuff like ssh keys,
admin lists, user lists, project descriptions, etc.  When we have this,
we can trivially restore a server or bring up a new one.

We need to have a terms of use agreement (I apologize in advance for the
legalese but even some of you have asked for it and it's unprofessional
that we don't have one).  We need to have some weasel words that say
if you upload source which contains child porn or instructions on how
to overthrow the government then we get to kick you off.  It's the same
sort of stuff that IBM's s390 Linux system has or Sourceforge has, etc.
We aren't making any sort of play to own your bits or any other nasty
thing and I'll post the terms of use here if people want me to so you
can comment on it, just ask.  If noone does, I won't bother you with it,
you'll see it on the new system.

We need to have email contacts for the people in charge of each project
so we have someone to mail if we want to delete a repo.  Right now, one
of us looks through the ssh keys for email addresses and/or searches
for people posting references to bkbits.net to find the admins, that's
a bit too time consuming and error prone.

We are also migrating the system to a new server with faster CPUs (yeah,
more than one) and faster disks (much to my surprise, SCSI really is
faster than IDE, Maxstor turned me on to the fact that they put more
expensive magnets in the SCSI drives which is a big factor in the faster
seek times).  It's either going to be at unnamed-large-distro-company
or at rackspace.com or both (primary one place and secondary somewhere
else).

Here's how I'd like to do the transition.  There are a few projects
which are clearly critical, like the main linux, ppc, and mysql trees.
We'll migrate those manually.  For the other ones, what we would propose
is that we leave all this stuff at *.bkprojects.net but restrict access
to only the project admins (i.e. the ssh interface).  The admins can
move the data to the new system.

We're shooting for some time in May for the transition, we'll send out
mail when we're ready, this is just a heads up to let you know that 
change is coming.  If the timing is bad we can delay it...

If you have requests for the new infrastructure, dev@bitmover.com
wants to hear them.

Cheers,
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
