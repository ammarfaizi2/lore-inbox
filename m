Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWCQHcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWCQHcf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbWCQHce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:32:34 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:41437 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752554AbWCQHcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:32:33 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Fri, 17 Mar 2006 14:57:38 +0800."
             <3ACA40606221794F80A5670F0AF15F84041AC264@pdsmsx403> 
Date: Fri, 17 Mar 2006 07:32:30 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FK9Rm-00047O-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about re-testing dummy _PSV and dummy _AC0 in DSDT?

Just retested and you were right.  This time I managed to get it to
hang, after many cycles of sleep.sh and "modprobe -r thermal ;
modprobe thermal" mixed in.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
