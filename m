Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWF3SBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWF3SBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932986AbWF3SBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:01:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35040 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932240AbWF3SBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:01:16 -0400
Date: Fri, 30 Jun 2006 19:58:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@suspend2.net, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
Message-ID: <20060630175837.GA9225@elf.ucw.cz>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606280019.32045.rjw@sisk.pl> <200606280947.58916.nigel@suspend2.net> <200606290035.12177.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606290035.12177.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm not sure I get what you're saying. Do you mean you'd prefer them to 
> > coexist for a time in mainline? If so, I'd point out that suspend2 uses 
> > different parameters at the moment precisely so they can coexist, so that 
> > wouldn't be any change.
> 
> No, I'd like it to be done in small steps.  Actually as small as possible, so
> that it's always clear what we are going to do and why.
> 
> If you want to start right now, please submit a bdevs freezing patch without
> any non-essential additions.

Actually that's quite a good plan. Or better yet fix XFS so that bdev
freezing is not neccessary. Or maybe _force someone_ to fix XFS...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
