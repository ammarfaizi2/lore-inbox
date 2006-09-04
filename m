Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWIDWgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWIDWgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWIDWgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:36:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13992 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932169AbWIDWgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:36:14 -0400
Date: Tue, 5 Sep 2006 00:35:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: x60 - spontaneous thermal shutdown
Message-ID: <20060904223520.GB1958@elf.ucw.cz>
References: <20060904214059.GA1702@elf.ucw.cz> <20060904222614.GA1614@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060904222614.GA1614@rhlx01.fht-esslingen.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > x60 shut down after quite a while of uptime, in period of quite heavy
> > load:
> > 
> > Sep  4 23:33:01 amd kernel: ACPI: Critical trip point
> > Sep  4 23:33:01 amd kernel: Critical temperature reached (128 C), shutting down.
> > Sep  4 23:33:01 amd shutdown[32585]: shutting down for system halt
> > Sep  4 23:34:42 amd init: Switching to runlevel: 0
> > 
> > I do not think cpu reached 128C, as I still have my machine... Did
> > anyone else see that?
> 
> Could this be in any way related to the (in)famous Random Shutdown issues
> on a little too many Apple MacBooks?
> (since the x60 incidentally just happens to be Core Duo
 > architecture, too)

Well, but those macbooks were really overheating, no? This seems like
sensor failure, because I do not think cpu had 128 Celsius, without
going through 100 Celsius, first.

> Those Random Shutdown issues at least in several cases appear to happen
> due to trouble with the temperature sensor or mainboard issues.
> Thermal management is in quite some trouble there, judging from
> the rather diverse aspects of machine shutdown failure...
> (fan not working, CPU overheating, NOT overheating but shutting down
> directly after boot, ...)

I had fan working at the time of shutdown, and machine was able to
boot immediately afterwards. That means that 128 celsius was sensor
error.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
