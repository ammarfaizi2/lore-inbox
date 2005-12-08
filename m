Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbVLHXEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbVLHXEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbVLHXEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:04:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6056 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932701AbVLHXEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:04:24 -0500
Date: Fri, 9 Dec 2005 00:04:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [RFC/RFT] suspend from userland
Message-ID: <20051208230407.GB3970@elf.ucw.cz>
References: <20051207011753.GA2526@elf.ucw.cz> <200512082352.07659.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512082352.07659.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd like to get some testing and comments on this. I know that
> > userland part is messy and will not work on x86-64 etc, and I should
> > obviously remove some extra printk's... but otherwise it should be okay.
> > 
> > Testing would be nice, too, but be a bit careful. It should not be
> > more dangerous than /sys/power/resume, but... If you suspect something
> > unusual, be sure to force fsck.
> 
> Could we please postpone it for some time?

Well, it is probably not going into -mm before your changes are in
mainline. That means 2.6.17 earliest.

> First, the patch doesn't apply to the current -mm and the userland part is
> incompatible with the code there to the extent of a serious breakage
> (let alone the x86-64 issue).

Of course I'm going to fix up breakage before the merge. At least all
the kernel parts and enough userland to test that it still works.

> Second, if I had some time to get my solution ready, we could compare the
> alternatives instead of just discussing one of them.

Well, I'm trying to gently push you. I'd like to get some solution in
1-2 months timeframe, so that work on userland parts can start.
									Pavel
-- 
Thanks, Sharp!
