Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVBRRAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVBRRAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVBRRAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:00:09 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:42682 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261404AbVBRRAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:00:04 -0500
Date: Fri, 18 Feb 2005 18:00:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Oliver Neukum <oliver@neukum.org>, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218170036.GA1672@ucw.cz>
References: <20050213004729.GA3256@stusta.de> <047401c515bb$437b5130$0f01a8c0@max> <20050218132651.GA1813@elf.ucw.cz> <200502181436.01943.oliver@neukum.org> <20050218160153.GC12434@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218160153.GC12434@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 05:01:53PM +0100, Pavel Machek wrote:

> > > It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,
> > > and it will not work on i386/APM, anyway. I still believe right
> > > solution is to add input interface to ACPI. /proc/acpi/events needs to
> > > die, being replaced by input subsystem.
> > 
> > But aren't there power events (battery low, etc) which are not
> > input events?
> 
> Yes, there are. They can probably stay... Or we can get "battery low"
> key.
 
We even have an event class for that, EV_PWR in the input subsystem.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
