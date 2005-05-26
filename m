Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVEZMjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVEZMjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVEZMjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:39:55 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:52939 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261356AbVEZMjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:39:52 -0400
Date: Thu, 26 May 2005 08:39:51 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.12-rc5 build failure
In-reply-to: <200505261634.17849.adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Message-id: <200505260839.51153.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200505260750.57571.gene.heskett@verizon.net>
 <200505261634.17849.adobriyan@gmail.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 08:34, Alexey Dobriyan wrote:
>On Thursday 26 May 2005 15:50, Gene Heskett wrote:
>> Just now, trying to build 2.6.12-rc5, I'm getting this:
>>   CC      drivers/char/ipmi/ipmi_devintf.o
>> drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_new_smi':
>> drivers/char/ipmi/ipmi_devintf.c:532: warning: passing arg 1 of
>> `class_simple_device_add' from incompatible pointer type
>> drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_smi_gone':
>> drivers/char/ipmi/ipmi_devintf.c:537: warning: passing arg 1 of
>> `class_simple_device_remove' makes integer from pointer without a
>> cast drivers/char/ipmi/ipmi_devintf.c:537: error: too many
>> arguments to function `class_simple_device_remove'
>
>Fixed in 2.6.12-rc5-dca79a046b93a81496bb30ca01177fb17f37ab72.
>

Aarrrhhggg... Thats about 150 chars longer than I can copy-paste here.

I'll wait for rc6 I think.

>http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2
>.6.git;a=commitdiff;h=dca79a046b93a81496bb30ca01177fb17f37ab72;hp=5d
>af05fbf73fc199e7a93a818e504856d07c5586 -
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
