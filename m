Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUALXrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUALXrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:47:12 -0500
Received: from [192.35.37.50] ([192.35.37.50]:62868 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S263596AbUALXrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:47:08 -0500
Message-ID: <400331F0.5020609@atl.lmco.com>
Date: Mon, 12 Jan 2004 18:46:56 -0500
From: Aron Rubin <arubin@atl.lmco.com>
Organization: Lockheed Martin ATL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031021
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.1]  Silicon Image 3512 SATA Controller - Tested
References: <4002B314.2010502@atl.lmco.com> <40030F52.4070000@pobox.com>
In-Reply-To: <40030F52.4070000@pobox.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I am not really sure how to force one or the other do I just 
say hda=sata_sil or something?

Jeff Garzik wrote:
> Aron Rubin wrote:
> 
>> This patch enables the Silicon Image 3512 SATA Controller and has been 
>> tested and functioning without any apparent bugs (I do not have a full 
>> test suite but I am not booting off a device attached to this 
>> controller). This patch is against the Dave Jones 2.6.1-1.34 kernel 
>> source rpm.
>>
>> You may remember I was trying to get help on this chipset before. My 
>> patch is simply a duplicate of the entries for the 3112 chipset. It 
>> did not work fully with prior kernels, giving me a "Interrupt Lost" 
>> errors. Whatever else was done to 2.6.1 had made it happy again. Also 
>> I did not have to use any special commandline options.
> 
> 
> 
> Did you test the sata_sil driver as well?
> 
> It's patch should just be one line...  No need to add a duplicate 
> ata_host_info entry when you could instead just reference the sil_3112 
> settings...
> 
> Thanks,
> 
>     Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 

ssh aron@rubinium.org cat /dev/brain | grep ^work:

Aron Rubin                       Member, Engineering Staff
Lockheed Martin                  E-Mail: arubin@atl.lmco.com
Advanced Technology Laboratories Phone:  856.792.9865
3 Executive Campus               Fax:    856.792.9930
Cherry Hill, NJ USA 08002        Web:    http://www.atl.lmco.com

