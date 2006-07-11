Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWGKViM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWGKViM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWGKViM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:38:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12237 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750836AbWGKViL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:38:11 -0400
Date: Tue, 11 Jul 2006 23:37:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 on thinkpad x32
Message-ID: <20060711213738.GA1732@elf.ucw.cz>
References: <20060709225208.GA1787@elf.ucw.cz> <20060711123048.522ba85c.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711123048.522ba85c.kristen.c.accardi@intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> > * acpi problems are gone, good -- it now boots with acpi=off and boots
> > with enabled pci hotplugging.
> > 
> > 	(that uncovered other problem where machine dies if I try to
> > 	undock it... This has worked before. I'll report it properly.)
> >
> 
> When you get your report for this ready, try to observe whether it happens
> if you boot undocked, then dock and then undock, or whether it will
> happen if you boot docked, then undock.  I do have an outstanding issue
> with some docks that have ide ports on the station where if you boot
> docked, then undock, we can't properly remove the ide device.  I am 
> working on that one, but it's not solved yet.

I guess you can disregard this. I have mess between -rc1 and
-rc1-mm1. -rc1 has some lockups that may be because of hotplug, but
-rc1-mm1 seems to be okay.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
