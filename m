Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbVKBVOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbVKBVOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbVKBVOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:14:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35033 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965246AbVKBVOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:14:08 -0500
Date: Wed, 2 Nov 2005 22:13:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: vojtech@suse.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051102211334.GH23943@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102202622.GN23316@pengutronix.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > yellow off: 	not charging
> > yellow on:	charging
> > yellow fast blink: charge error
> > 
> > I think even slow blinking was used somewhere. I have some code from
> > John Lenz (attached); it uses sysfs interface, exports led collor, and
> > allows setting different frequencies.
> > 
> > Is that acceptable, or should some other interface be used?
> 
> IMHO reducing digital outputs to LEDs goes not far enough. All System-
> on-Chip CPUs have General Purpose I/O pins today, which can act as
> inputs or outputs and may be used for LEDs, matrix keyboard lines,

We have some leds that are *not* on GPIO pins (like driven by
ACPI). We'd like to support those, too.
								Pavel
-- 
Thanks, Sharp!
