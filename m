Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVB0SHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVB0SHl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 13:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVB0SGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 13:06:46 -0500
Received: from cantor.suse.de ([195.135.220.2]:15551 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261497AbVB0SEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 13:04:14 -0500
Message-ID: <42220B96.30301@suse.de>
Date: Sun, 27 Feb 2005 19:04:06 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Norbert Preining <preining@logic.at>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <20050222220828.GB538@hell.org.pl> <20050224123716.GD28961@gamma.logic.tuwien.ac.at> <20050227165701.GE1441@elf.ucw.cz>
In-Reply-To: <20050227165701.GE1441@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>> 	this server crashes when switching to the console or shutting
>> 	down (crashing is sometimes, not always), very nice screen which
>> 	slowly turns white
> 
> Hmm, it would be nice to be able to trigger "go white" on purpose --
> it looks like screen is burning and could scare quite  a lot of people
> :-).

BTW: turning white does not necessarily mean "screen is dying" but can
also mean "LCD is powered off and slowly turning transparent but the
backlight is still on" which brings me back to the original subject:

Sharp PC-AR10 (ATI rage mobility P/M AGP 2x), which is sort of the
crappiest hardware i have ever seen, has working S3 without any tricks.
The backlight is not turned off at S3 but in fact it is explicitly
turned on (if i do "xset dpms force off" before suspend, it turns back
on after  or shortly before entering suspend) and the screen slowly goes
white (because TFT power is turned off), but if you enter S3 via
lidswitch this does not matter since the lidswitch turns off the
backlight :-)
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX, Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
