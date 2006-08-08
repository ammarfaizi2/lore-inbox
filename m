Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWHHLhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWHHLhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWHHLhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:37:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55943 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964845AbWHHLhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:37:53 -0400
Date: Tue, 8 Aug 2006 13:37:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dave Jones <davej@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: annoying frequent overcurrent messages.
Message-ID: <20060808113737.GH4442@elf.ucw.cz>
References: <20060713120815.GA5727@elf.ucw.cz> <Pine.LNX.4.44L0.0607131027200.6702-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0607131027200.6702-100000@iolanthe.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Well, overcurrent is a potentially dangerous situation.  That's why it 
> > > gets reported with dev_err priority.
> > 
> > Well, I see overcurrents all the time while doing suspend/resume...
> > 
> > Why is it dangerous? USB should survive plugging something that
> > connects +5V and ground. It may turn your machine off, but that should
> > be it...?
> 
> The key words here are "potentially", "should", and "may".
> 
> BTW, what sort of overcurrents do you see during suspend/resume?

Okay, that was on X32, and I'm not using it for now, sorry about
that. "Overcurrent on port XY" was the message, IIRC, but...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
