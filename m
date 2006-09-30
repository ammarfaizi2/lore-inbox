Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWI3Dlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWI3Dlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 23:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWI3Dlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 23:41:36 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7113 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750740AbWI3Dlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 23:41:35 -0400
Message-ID: <451DE76C.5090504@garzik.org>
Date: Fri, 29 Sep 2006 23:41:32 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Prakash Punnoor <prakash@punnoor.de>
Subject: Re: SATA status reports update
References: <fa.qX++qRit8w9OM0g1pdrG/oO2vt0@ifi.uio.no> <fa.Rp+FWnZ2aDKMZggJQPBaMZJIiTk@ifi.uio.no> <fa.mf96kUVw9JlcVmzGTV5ysiCiT3E@ifi.uio.no> <fa.qyxVQ/280iu/YZsbUzTDjAygfL4@ifi.uio.no> <fa.BuZY3hsao85GkcEIgE6/7ZlG40A@ifi.uio.no> <451DE4BF.70906@shaw.ca>
In-Reply-To: <451DE4BF.70906@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Jeff Garzik wrote:
>> Prakash Punnoor wrote:
>>> Well, how would one debug it w/o hw docs? Or is it possible to 
>>> compare the patch with a working driver for another chipset?
>>
>> Well, it is based off of the standard ADMA[1] specification, albeit 
>> with modifications.  There is pdc_adma.c, which is also based off 
>> ADMA.  And the author (from NVIDIA) claims that the driver worked at 
>> one time, so maybe it is simply bit rot that broke the driver.
>>
>> If I knew the answer, it would be fixed, so the best answer 
>> unfortunately is "who knows".
>>
>> I wish I had the time.  But I also wish I had a team of programmers 
>> working on libata, too ;-)
> 
> Do you know exactly what is allegedly broken in that version? I see that 
> there are some functions which are just "TODO"..

I just know it was a working driver at one time.

	Jeff



