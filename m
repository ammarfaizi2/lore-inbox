Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752217AbWCPHOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbWCPHOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 02:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbWCPHOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 02:14:05 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:8176 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752215AbWCPHOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 02:14:03 -0500
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
In-Reply-To: Your message of "Thu, 16 Mar 2006 14:41:27 +0800."
             <3ACA40606221794F80A5670F0AF15F840B37A678@pdsmsx403> 
Date: Thu, 16 Mar 2006 07:14:01 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJmgL-0000PX-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I found the common code in _PSV and _AC0
>    Store (DerefOf (Index (DerefOf (MODP (0x01)), Local1)), Local0)
> Could you just comment out that?

It doesn't hang.  Though it seemed close to hanging a couple times,
but after a 5-10 second pause always managed to go to sleep.  I tried
about 15 sleep cycles, with a few echo 1 > polling_frequency thrown in.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
