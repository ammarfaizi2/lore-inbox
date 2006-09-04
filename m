Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWIDV7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWIDV7Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWIDV7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 17:59:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47491 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751310AbWIDV7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 17:59:24 -0400
Date: Mon, 4 Sep 2006 23:56:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       moreau francis <francis_moreau2000@yahoo.fr>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re : [HELP] Power management for embedded system
Message-ID: <20060904215647.GA1975@elf.ucw.cz>
References: <20060824093739.5085.qmail@web25802.mail.ukl.yahoo.com> <1156414325.5555.11.camel@localhost.localdomain> <20060824162034.GB19753@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824162034.GB19753@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It would be nice to move that to some arch independent generic
> > implementation of these things and to leave the APM emulation behind.
> > The battery information should be a sysfs class (see the backlight/led
> > classes as examples of sysfs classes). The suspend/resume event handling
> > would be something new as far as I know and ideally should support
> > suspending/resuming individual sections of device hardware as well as
> > the whole system.
> 
> Triggering suspend/resume is already generic in the form of the 
> /sys/power/state interface. There's been discussion of producing a 
> generic battery class lately. There's some trend towards tying suspend 
> requests into the input layer, but how appropriate that is may
> > depend on 

suspend requests into input layer.. No, I do not think Dmitry will
allow us to do that.

Yes, we definitely want some kind of "generic battery" layer.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
