Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbULHUjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbULHUjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbULHUjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:39:04 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:51371 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261349AbULHUic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:38:32 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-2
Date: Wed, 8 Dec 2004 15:38:28 -0500
User-Agent: KMail/1.7
Cc: john cooper <john.cooper@timesys.com>
References: <OFD07DEEA4.7C243C76-ON86256F5F.007976EC@raytheon.com> <200412072005.37486.gene.heskett@verizon.net> <41B75A94.90709@timesys.com>
In-Reply-To: <41B75A94.90709@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412081538.29007.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [141.153.76.102] at Wed, 8 Dec 2004 14:38:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 December 2004 14:48, john cooper wrote:
>Gene Heskett wrote:
>> ...I'd had that happen twice
>> before and panic'd, even hitting the reset button once and doing a
>> cold powerdown once, this before I noticed there was some disk
>> activity going on, so I figured what the hell and walked away to
>> go see what the missus was watching on the telly.  And when I came
>> back half an hour later I was looking at a login prompt once I'd
>> moved the mouse.
>
>Interesting to read the above.  I found similar
>repeatable behavior when I launched a "make -j"
>build on an arbitrary kernel tree when running
>-V0.7.32-2.  I originally suspected the OOM
>behavior to differ (somehow) with the 32-2 patch
>compared to vanilla 2.6.10-rc2-mm3, but that was
>a red herring.

Or a reasonable facsimily...  This was during the boot cycle as it was
just finished with the listing of the cursory checking as its
mounting the devices, and then hung for an extended period of time
with a low level of disk activity, as if its doing a slow e2fsck with
the output being fed to /dev/null.  Thats the best way I could
describe it.

FWIW, when it did that the first time, one of the boots I tried was
to 2.6.10-rc2, which I knew for a fact was a good boot file. 
Whatever was causing it was still doing it, which was when I walked
away to let it sort its own personal box of rattlesnakes.  Once
booted, the system seemed none the worse for wear, so other than
advising that its happened here 4 times now over the last couple of
weeks, its otherwise a <shrug>.

>-john

-- 
Cheers John, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

