Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbULZMXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbULZMXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 07:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbULZMXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 07:23:08 -0500
Received: from gprs212-75.eurotel.cz ([160.218.212.75]:56448 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261644AbULZMXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 07:23:05 -0500
Date: Sun, 26 Dec 2004 13:22:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: bkcvs seems to have stale data [was Re: lease.openlogging.org is unreachable]
Message-ID: <20041226122251.GB1590@elf.ucw.cz>
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com> <1103977484.22653.11.camel@localhost.localdomain> <20041226011545.GB1896@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226011545.GB1896@work.bitmover.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > lease.openlogging.org is unreachable today.
> > > 
> > > So I guess I need to set up a cron job to renew my lease every
> > > minute/hour/day/whatever so I can actually download new kernel
> > > releases when they come out?  I can't even examine the code I
> > > downloaded yesterday without that lease...  Now that's what I call
> > > having my source code held hostage!
> > 
> > The tar ball edition works perfectly 8)
> 
> And a very Merry Christmas to you too Alan.  You're welcome for all that
> BK has done for you and the kernel effort, always a pleasure to work with
> such polite people.

:-)

Is something wrong with bkcvs? 2.6.10 was released 40 hours ago, but I
still see -rc3 when I update... I'm doing

time rsync -zav --delete rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5 .

and cvs update.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
