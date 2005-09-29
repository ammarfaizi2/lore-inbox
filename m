Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVI2TME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVI2TME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVI2TMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:12:03 -0400
Received: from [67.137.28.189] ([67.137.28.189]:59264 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S932274AbVI2TMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:12:00 -0400
Message-ID: <433C2A11.9090506@utah-nac.org>
Date: Thu, 29 Sep 2005 11:53:21 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Nuno Silva <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
References: <Pine.LNX.4.63.0509290916450.20827@p34> <433C31C8.1030901@vgertech.com> <Pine.LNX.4.63.0509291433340.13272@p34>
In-Reply-To: <Pine.LNX.4.63.0509291433340.13272@p34>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Someone needs to fix SATA drive ordering in the kernel so it matches 
GRUBs ordering, or perhaps GRUB needs fixing. I have run into
several situation where hd0,hd1 are in reverse order from what is 
reported when the Intel PII drivers load from the kernel, making in
necessary to swap the two values in the grub config.

Jeff

Justin Piszcz wrote:

> I will have to give this a shot, any idea when it will be merged into 
> mainline?
>
> Thanks,
>
> Justin.
>
> On Thu, 29 Sep 2005, Nuno Silva wrote:
>
>> Justin Piszcz wrote:
>>
>>> Under 2.6.13.2,
>>>
>>> Is there any utility that I can use to put a SATA HDD to sleep?
>>> Secondly, I notice I cannot access any of the HDD's S.M.A.R.T. 
>>> functions on SATA drives?
>>
>>
>> Search for Jeff's patch 2.6.12-git4-passthru1.patch
>> I think this will be included RSN. This solves your two issues.
>>
>> Regards,
>> Nuno Silva
>>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
>

