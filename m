Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVBRUPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVBRUPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVBRUPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:15:10 -0500
Received: from gprs215-250.eurotel.cz ([160.218.215.250]:23266 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261482AbVBRUO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:14:59 -0500
Date: Fri, 18 Feb 2005 21:14:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218201429.GA1403@elf.ucw.cz>
References: <20050213004729.GA3256@stusta.de> <20050218160153.GC12434@elf.ucw.cz> <20050218170036.GA1672@ucw.cz> <200502181805.13129.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502181805.13129.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Yes, there are. They can probably stay... Or we can get "battery low"
> > > key.
> >  
> > We even have an event class for that, EV_PWR in the input subsystem.
> 
> Over that route we'd arrive at a situation where power management
> without the input layer is impossible. Think about embedded stuff I wonder
> whether this is viable.

I'd say it is: you need some support to get it into userspace. And I'd
certianly prefer input infrastructure over ACPI infrastructure...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
