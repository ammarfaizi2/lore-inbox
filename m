Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVAAAIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVAAAIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 19:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVAAAIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 19:08:04 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:54672 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262166AbVAAAH5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 19:07:57 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Date: Fri, 31 Dec 2004 19:07:55 -0500
User-Agent: KMail/1.7
Cc: Tom Felker <tfelker2@uiuc.edu>, ofeeley@gmail.com,
       William <wh@designed4u.net>
References: <200412311741.02864.wh@designed4u.net> <200412311322.14359.gene.heskett@verizon.net> <200412311548.11614.tfelker2@uiuc.edu>
In-Reply-To: <200412311548.11614.tfelker2@uiuc.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412311907.55626.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.52.185] at Fri, 31 Dec 2004 18:07:56 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 December 2004 16:48, Tom Felker wrote:
>On Friday 31 December 2004 12:22 pm, Gene Heskett wrote:
>> There are some times when the usual 5 second flush schedule should
>> be tossed out the window, and the data written immediately.  A
>> quickly unpluggable usb memory dongle is a prime candidate to bite
>> the user precisely where it hurts.  Floppies also fit this same
>> scenario, I don't know at the times I've written an image with dd,
>> got up out of my chair and went to the machine and slapped the
>> eject button to discover to my horror, that when my hand came away
>> from the button with disk in hand, the frigging access led was now
>> on that wasn't when I tapped the button.
>
>For that you should add "sync" as an option when mounting the
> filesystem, in which case writes won't return until the data has
> actually been written.  man mount doesn't mention that being
> implemented for FAT, though - is that accurate, and if so,
> shouldn't it be?

Don't know about vfat, which is how I mount a floppy, but I just put 
that in the options list in /etc/fstab & will test it the next time I 
need to sneakernet something small around here.  Many thanks for what 
might be a valuable bit of info!

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
