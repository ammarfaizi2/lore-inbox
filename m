Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVGZRH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVGZRH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVGZRFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:05:01 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:59347 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261634AbVGZRDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:03:44 -0400
Date: Tue, 26 Jul 2005 13:03:39 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-reply-to: <42E65B34.9080700@pobox.com>
To: linux-kernel@vger.kernel.org
Message-id: <200507261303.40052.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050726150837.GT3160@stusta.de> <42E65B34.9080700@pobox.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 July 2005 11:48, Jeff Garzik wrote:
>Adrian Bunk wrote:
>> This patch schedules obsolete OSS drivers (with ALSA drivers that
>> support the same hardware) for removal.
>>
>>
>> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>>
>> ---
>>
>> I've Cc'ed the people listed in MAINTAINERS as being responsible
>> for one or more of these drivers, and I've also Cc'ed the ALSA
>> people.
>>
>> Please tell if any my driver selections is wrong.
>>
>>  Documentation/feature-removal-schedule.txt |    7 +
>>  sound/oss/Kconfig                          |   79
>> ++++++++++++--------- 2 files changed, 54 insertions(+), 32
>> deletions(-)
>
>Please CHECK before doing this.
>
>ACK for via82cxxx.

I'm still running a box that needs this one.  The darned thing refuses 
to die. :)

>NAK for i810_audio:  ALSA doesn't have all the PCI IDs (which must
> be verified -- you cannot just add the PCI IDs for some hardware)
>
> Jeff
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
