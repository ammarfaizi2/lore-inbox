Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264432AbUE2T5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbUE2T5T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 15:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUE2T5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 15:57:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38615 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264432AbUE2T5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 15:57:08 -0400
Message-ID: <40B8EB07.6000700@pobox.com>
Date: Sat, 29 May 2004 15:56:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1: libata flooding my log
References: <40B8E8D4.1010905@gmx.de>
In-Reply-To: <40B8E8D4.1010905@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Hi,
> 
> I noticed following messages appearing very often in my log:
> 
> FAILED
>   status = 1, message = 00, host = 0, driver = 08
>   Current sd: sense = 70  5
> ASC=20 ASCQ= 0
> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
> 0x00 0x20 0x00
> FAILED
>   status = 1, message = 00, host = 0, driver = 08
>   Current sd: sense = 70  5
> ASC=20 ASCQ= 0
> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
> 0x00 0x20 0x00
> FAILED
>   status = 1, message = 00, host = 0, driver = 08
>   Current sd: sense = 70  5
> ASC=20 ASCQ= 0
> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
> 0x00 0x20 0x00
> FAILED
>   status = 1, message = 00, host = 0, driver = 08
>   Current sd: sense = 70  5
> ASC=20 ASCQ= 0
> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
> 0x00 0x20 0x00
> FAILED
>   status = 1, message = 00, host = 0, driver = 08
>   Current sd: sense = 70  5
> ASC=20 ASCQ= 0
> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
> 0x00 0x20 0x00
> FAILED
>   status = 1, message = 00, host = 0, driver = 08
>   Current sd: sense = 70  5
> ASC=20 ASCQ= 0
> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
> 0x00 0x20 0x00
> 
> 
> Any idea of what is going on? Is dmesg output needed? The system seesm 
> to behave rel normal, beside a bit performance degration, I think.

Reading REPORTING-BUGS for the info that is needed.

I wonder if you have a bad SATA cable, initially, though.


> BTW, the new libata version does two good things:
> - write back is activated

this is cosmetic, it was always activated.


> - now hdparm -t /dev/sda gives high throughoutput straight form the 
> first time.

this is because Andrew Morton fixed a bug unrelated to libata :)

	Jeff



