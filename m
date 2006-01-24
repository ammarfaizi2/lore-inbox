Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWAXWOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWAXWOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWAXWOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:14:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11927 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750772AbWAXWOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:14:36 -0500
Date: Tue, 24 Jan 2006 23:14:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060124221426.GB1602@elf.ucw.cz>
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org> <20060124213010.GA1602@elf.ucw.cz> <20060124135843.739481e7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124135843.739481e7.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > This patch introduces a user space interface for swsusp.
> > > 
> > > How will we know if/when this feature is ready for mainline?  What criteria
> > > can we use to judge that?
> > 
> > It was stable for me last time I tested. I do not think it needs
> > longer -mm testing than usual patches.
> 
> One we've shipped the interface we're kinda stuck with it for ever, so it
> does want to be pretty mature.

Well, I think we got the interface pretty much right -- and it is
really pretty simple. It survived pretty nasty stress testing at one
point.

Of course, bad things happen. Having it merged but disabled in
Makefile would certainly be preferred than not merged at
all. Plus... stable kernel or not, it is new feature, and userland
suspending programs are quite closely tied to the kernel. I think it
is reasonable to expect users to have matching version of kernel and
userland-swsusp tools, at least before dust settles.
								Pavel
-- 
Thanks, Sharp!
