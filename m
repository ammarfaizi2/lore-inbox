Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUILUnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUILUnP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 16:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUILUnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 16:43:15 -0400
Received: from gprs40-135.eurotel.cz ([160.218.40.135]:30051 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261474AbUILUnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 16:43:10 -0400
Date: Sun, 12 Sep 2004 22:42:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: swsusp: kill crash when too much memory is free
Message-ID: <20040912204255.GA3168@elf.ucw.cz>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409101926.30902.rjw@sisk.pl> <20040910222915.GC1347@elf.ucw.cz> <200409111150.28457.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409111150.28457.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hmm, I do not know what nForce3 is (it should use better name at the
> > minimum), but that driver probably needs some work.
> 
> It is the sound chip (ie snd-intel8x0).  If I unload it after resume, 
> everything's fine and dandy.  Moreover, if I unload it before suspend, the 
> box wakes up with no problems (of course, I have to unload the other modules 
> too, as I said before).
> 
> However, I think the problem is with the hardware, not with the driver: if the 
> sound driver is unloaded before suspend and loaded again after resume, the 
> box behaves as though it were loaded all the time (ie IRQ #5 goes mad).  Are 
> there any boot options that may help get around this?

Hmm, I do not think it is hardware problem. Does snd-intel8x0 have any
suspend/resume support?

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
