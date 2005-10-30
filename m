Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVJ3AXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVJ3AXL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVJ3AXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:23:11 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:39310 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751032AbVJ3AXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:23:09 -0400
Date: Sat, 29 Oct 2005 20:23:01 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch 0/5] HW RNG cleanup & new drivers
In-reply-to: <4363F31F.2040303@pobox.com>
To: linux-kernel@vger.kernel.org
Message-id: <200510292023.01984.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20051029191229.562454000@omelas> <4363F31F.2040303@pobox.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 18:09, Jeff Garzik wrote:
>Deepak Saxena wrote:
>> This patch adds support to the kernel for some more HW RNG devices
>> and cleans up the code a bit.  My basic goal was to keep the same
>> user space interface as exists, but not have to reproduce all
>> the same 100 lines of user space interface code across every new
>> driver (as we currently do with watchdogs...)
>>
>> The new code separates the HW specific driver from the user
>> interface code and just adds a few function pointers so that
>> the two can talk to each other. I opted out of using a sysfs
>> class and all that complication b/c there will be one and only
>> one RNG device at a time on a given system.
>>
>> I've added drivers for Intels' IXP4xx and for the TI OMAP and
>> these have both been tested.
>
>I would prefer to let this live in -mm at least for a little while.
>Confirmation from AMD, Intel and VIA owners would be really nice, too.
>AMD and Intel might be a little bit hard to find.  I think Peter Anvin
>had an Intel ICH w/ RNG at one time...

Does anyone know if there is a hardware RNG in my Athlons?  XP-2800
here, XP-1400 in the shop box, & a K6-III in the firewall.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Free OpenDocument reader/writer/converter download:
http://www.openoffice.org
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

