Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265184AbUFBIKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265184AbUFBIKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 04:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUFBIKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 04:10:37 -0400
Received: from imap.gmx.net ([213.165.64.20]:21416 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265184AbUFBIKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 04:10:34 -0400
X-Authenticated: #4512188
Message-ID: <40BD8B7A.2010901@gmx.de>
Date: Wed, 02 Jun 2004 10:10:34 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1: libata flooding my log
References: <40B8E8D4.1010905@gmx.de> <40B8EB07.6000700@pobox.com> <40B8F601.2000600@gmx.de>
In-Reply-To: <40B8F601.2000600@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Jeff Garzik wrote:
> 
>> Prakash K. Cheemplavam wrote:
>>
> [snip]
> 
>>> FAILED
>>>   status = 1, message = 00, host = 0, driver = 08
>>>   Current sd: sense = 70  5
>>> ASC=20 ASCQ= 0
>>> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
>>> 0x00 0x20 0x00
>>> FAILED
>>>   status = 1, message = 00, host = 0, driver = 08
>>>   Current sd: sense = 70  5
>>> ASC=20 ASCQ= 0
>>> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
>>> 0x00 0x20 0x00
>>> FAILED
>>>   status = 1, message = 00, host = 0, driver = 08
>>>   Current sd: sense = 70  5
>>> ASC=20 ASCQ= 0
>>> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
>>> 0x00 0x20 0x00
>>>
>>>
>>

> 
> 
>>
>> I wonder if you have a bad SATA cable, initially, though.
> 
> 
> I don't think so, because previous mm kernels didn't show anything like 
> this.
> 

I tried again a 2.6.6 based mm kernel and all is OK. Furthermore I am 
not the only one getting these messages with the 2.6.7-rcX mm kernels. 
Any idea? I tried to copy the older libata to the new kernel, but didn't 
work as I got a compilation failure...

Prakash
