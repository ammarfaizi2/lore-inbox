Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUKKGBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUKKGBl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 01:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbUKKGBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 01:01:40 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:26607 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262175AbUKKGBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 01:01:34 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: DEVFS_FS
Date: Thu, 11 Nov 2004 01:01:30 -0500
User-Agent: KMail/1.7
Cc: Greg KH <greg@kroah.com>, Alexandre Costa <alebyte@gmail.com>,
       linux-os@analogic.com
References: <Pine.LNX.4.61.0411101544080.19616@chaos.analogic.com> <200411101906.37328.gene.heskett@verizon.net> <20041111001909.GA18269@kroah.com>
In-Reply-To: <20041111001909.GA18269@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411110101.30463.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.59.10] at Thu, 11 Nov 2004 00:01:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 November 2004 19:19, Greg KH wrote:
>On Wed, Nov 10, 2004 at 07:06:37PM -0500, Gene Heskett wrote:
>> On Wednesday 10 November 2004 16:03, Alexandre Costa wrote:
>> >On Wed, 10 Nov 2004 15:46:06 -0500 (EST), linux-os
>> >
>> ><linux-os@chaos.analogic.com> wrote:
>> >> What is the approved substitute for DEVFS_FS that is marked
>> >> obsolete?
>> >
>> >udev
>> >http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html
>>
>> Humm, I'm not sure I'm entirely happy with that choice.  I have an
>> FC3RC5 install on an old P-II running at 233mhz, and the udev
>> start in the bootup is the slowest single thing to get started by
>> an order of magnitude.
>>
>> Can someone tell me a good reason udev wastes as much time as the
>> post does checking 383 megs of memory, which is very nearly a
>> minute even just for udev?
>
>It's all up to the rules you are using for udev.  If you have udev
> rules that call out to scripts for every device (like I think the
> SuSE default install does), udevstart can take a long time.
>
This is a box stock FC3RC5 install, Greg.  I haven't touched a thing 
in how it works because I don't know anything about it, other than 
its about 1/3rd of the total boot time.

>If you don't have any external dependancies, udevstart is fast.
>
>> If its to be used, its got to speed itself up, a LOT!.
>
>Please post what version of udev you are using, and what your udev
> rules file looks like.

Probably see the FC3 release, but I don't know how much diff there is 
between RC5 and the final, rsync is trying to convert mine to final 
right now.  Where is this rules file?

>thanks,
>
>greg k-h

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
