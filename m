Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVBRQCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVBRQCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVBRQCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:02:24 -0500
Received: from gprs215-230.eurotel.cz ([160.218.215.230]:4773 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261393AbVBRQCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:02:21 -0500
Date: Fri, 18 Feb 2005 17:01:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Richard Purdie <rpurdie@rpsys.net>, Vojtech Pavlik <vojtech@suse.cz>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218160153.GC12434@elf.ucw.cz>
References: <20050213004729.GA3256@stusta.de> <047401c515bb$437b5130$0f01a8c0@max> <20050218132651.GA1813@elf.ucw.cz> <200502181436.01943.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502181436.01943.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,
> > and it will not work on i386/APM, anyway. I still believe right
> > solution is to add input interface to ACPI. /proc/acpi/events needs to
> > die, being replaced by input subsystem.
> 
> But aren't there power events (battery low, etc) which are not
> input events?

Yes, there are. They can probably stay... Or we can get "battery low"
key.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
