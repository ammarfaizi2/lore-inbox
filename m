Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWCJN1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWCJN1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 08:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWCJN1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 08:27:24 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:1760 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750806AbWCJN1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 08:27:23 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       "Duncan" <1i5t5.duncan@cox.net>, "Pavlik Vojtech" <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Fri, 10 Mar 2006 14:46:29 +0800."
             <3ACA40606221794F80A5670F0AF15F840B280323@pdsmsx403> 
Date: Fri, 10 Mar 2006 13:27:20 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FHheK-0002iN-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What do you mean of "slither away" ? 
> bug go away?

I can no longer trigger it, at least not with the usual procedure.  I
doubt that it goes away (i.e. that it is solved), only that it
slithers into hiding, like bugs that disappear when compiling a C
program with -g but show up when compiling without -g.

> echo -n 0x10 > /proc/acpi/debug_layer
> echo -n 0x10 > /proc/acpi/debug_level

Oh, I always have more info turned on in my sleep.sh script
(debug_layer = 0xFFFF3FFF to begin with, and the script sets
debug_level to 0x1F).  I'll attach the slightly trimmed log file to
the bugme report.  If it's too much information, let me know and I'll
retest with just the above settings.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
