Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUIWO6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUIWO6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 10:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUIWO6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 10:58:42 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:19867 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S267508AbUIWO5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 10:57:18 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.9-rc2-mm2 vs glxgears
Date: Thu, 23 Sep 2004 10:57:15 -0400
User-Agent: KMail/1.7
Cc: Frank Phillips <fphillips@linuxmail.org>
References: <20040923052338.C1D0C21B32F@ws5-6.us4.outblaze.com> <200409230327.11531.gene.heskett@verizon.net> <21d7e997040923011927860bb2@mail.gmail.com>
In-Reply-To: <21d7e997040923011927860bb2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231057.15120.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.51.220] at Thu, 23 Sep 2004 09:57:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 September 2004 04:19, Dave Airlie wrote:
>> Which even I have to agree is pretty pathetic.
>
>What do you get on a Linus kernel, I'm not tracking -mm as much as I
>should, the missing pci_enable_device might have caused some
> issues...

I hadn't even built 2.6.9-rc2 due to the widespread and constant hang 
reports.

>On my 2.6.8.1 at the moment glxgears stays constant enough, I'll
> boot into a 2.6.9 later on and check it out...
>
I'm not sure if I have a 2.6.8.1 in my grub.conf still.  This brings 
up a minor question:  How many entries can one actually have in the 
grub.conf before something overflows?  I'd set a rather abitrary 
limit of 16 here, but I have more room in the /boot partition than 
that, and the 2.6.8.1 kernel still exists I believe.

>What graphics card you have?
>Dave.

X-tacy version of an ATI Radeon 9200SE, 128 megs of ram.  And these 
lines from messages at about the time I did the startx I've not seen 
before:
Sep 23 03:19:55 coyote kernel: agpgart: Found an AGP 3.0 compliant 
device at 0000:00:00.0.
Sep 23 03:19:55 coyote kernel: agpgart: Putting AGP V3 device at 
0000:00:00.0 into 4x mode
Sep 23 03:19:55 coyote kernel: agpgart: Putting AGP V3 device at 
0000:02:00.0 into 4x mode
Sep 23 03:19:55 coyote kernel: [drm] Loading R200 Microcode

So this is something new with rc2-mm2 (new to me anyway).  The card, 
and its mobo socket are supposedly 8X, so why the setting to 4X?  Not 
that this has very much to do with this problem since 10fps can be 
done on AGP 0.05X :)

[...]

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
