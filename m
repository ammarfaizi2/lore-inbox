Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWGMMIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWGMMIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWGMMIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:08:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38093 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751434AbWGMMIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:08:44 -0400
Date: Thu, 13 Jul 2006 14:08:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dave Jones <davej@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: annoying frequent overcurrent messages.
Message-ID: <20060713120815.GA5727@elf.ucw.cz>
References: <200607111747.13529.david-b@pacbell.net> <Pine.LNX.4.44L0.0607121012570.6607-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0607121012570.6607-100000@iolanthe.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have a box that's having its dmesg flooded with..
> > 
> > hub 1-0:1.0: over-current change on port 1
> > hub 1-0:1.0: over-current change on port 2
> > hub 1-0:1.0: over-current change on port 1
> > hub 1-0:1.0: over-current change on port 2
> ...
> 
> > over and over again..
> > The thing is, this box doesn't even have any USB devices connected to it,
> > so there's absolutely nothing I can do to remedy this.
> 
> Well, overcurrent is a potentially dangerous situation.  That's why it 
> gets reported with dev_err priority.

Well, I see overcurrents all the time while doing suspend/resume...

Why is it dangerous? USB should survive plugging something that
connects +5V and ground. It may turn your machine off, but that should
be it...?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
