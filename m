Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTKNUGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbTKNUGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:06:12 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:20418 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S264398AbTKNUGJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:06:09 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Andries Brouwer <aebr@win.tue.nl>, Patrick Beard <patrick@scotcomms.co.uk>
Subject: Re: 2.6.0-test9 VFAT problem
Date: Fri, 14 Nov 2003 15:06:07 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <09A92EA4A9D2D51182170004AC96FE7A1216BB@mercury.scotcomms> <20031114190337.GA18107@win.tue.nl>
In-Reply-To: <20031114190337.GA18107@win.tue.nl>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311141506.07784.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.12.17] at Fri, 14 Nov 2003 14:06:07 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 November 2003 14:03, Andries Brouwer wrote:
>On Fri, Nov 14, 2003 at 11:51:57AM -0000, Patrick Beard wrote:
>> > > My fstab entry is;
>> > > /dev/sda    /mnt/smedia    vfat    rw,user,noauto    0,0
>> >
>> > I would guess that you have to mount /dev/sda1 or perhaps
>> > /dev/sda4. Isn't that what you do under 2.4?
>>
>> Yes, with 2.4 I used sda1. When I first compiled 2.6 I used sda1
>> but I got the 'wrong fs..' error. This was a clean install of
>> debian so I didn't have my original fstab. I checked the web and
>> noticed people using sda. so I tried that - same error. In trying
>> to get this to work I've used sda and sda1 at different times both
>> gave the same errors.
>
>Good.
>
>Maybe you know already, but just to be sure:
>You must use sda if the thing has no partition table.
>You must use sda1 if the thing has a partition table.
>
>So, if sda1 works under 2.4, then sda is certainly wrong under 2.6 -
>your device would just look like garbage and the error messages are
>meaningless.
>Only try sda1, and report whatever goes wrong in that case.
>
>Andries

I just played 210 monkeys, and /dev/sda doesn't work for mount, but 
sda1 does.  Both work for a read by dd FWTW.  Links suitably 
restored.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

