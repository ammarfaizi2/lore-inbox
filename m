Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVGXOXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVGXOXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 10:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVGXOXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 10:23:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63176 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261205AbVGXOX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 10:23:29 -0400
Date: Sun, 24 Jul 2005 16:23:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christian Hesse <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org, Jan De Luyck <lkml@kcore.org>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [2.6.12.3] dyntick 050610-1 breaks makes S3 suspend
Message-ID: <20050724142318.GA1778@elf.ucw.cz>
References: <200507231435.05015.lkml@kcore.org> <200507231451.04630.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507231451.04630.mail@earthworm.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I recently tried out dyntick 050610-1 against 2.6.12.3, works great, it
> > actually makes a noticeable difference on my laptop's battery life. I don't
> > have hard numbers, lets just say that instead of the usual ~3 hours i get
> > out of it, i was ~4 before it started nagging, usual use pattern at work.
> >
> > The only gripe I have with it that it stops S3 from working. If the patch
> > is compiled in the kernel, it makes S3 suspend correctly, but resuming goes
> > into a solid hang (nothing get's it back alive, have to keep the
> > powerbutton for ~5 secs to shutdown the system)
> >
> > Anything I could test? The logs don't give anything useful..
> 
> I reported this some time ago [1], but there's no sulution so far...
> 
> [1] http://groups.google.com/groups?selm=4b4NI-7mJ-9%40gated-at.bofh.it

Does it also break if swsusp? Does it break if you replace enter sleep
function with some kind of dummy functions? (Or perhaps S1 is enough
for this test?)
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
