Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUBTETe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 23:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbUBTETe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 23:19:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6830 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267517AbUBTETb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 23:19:31 -0500
Message-ID: <40358AC5.90103@pobox.com>
Date: Thu, 19 Feb 2004 23:19:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: David Mosberger-Tang <David.Mosberger@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel x86-64 support merge
References: <1qK5k-7g2-67@gated-at.bofh.it> <1qK5k-7g2-69@gated-at.bofh.it> <1qK5k-7g2-71@gated-at.bofh.it> <1qK5k-7g2-73@gated-at.bofh.it> <1qK5k-7g2-65@gated-at.bofh.it> <40353382.8010505@tmr.com>
In-Reply-To: <40353382.8010505@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> David Mosberger-Tang wrote:
> 
>>>>>>> On Thu, 19 Feb 2004 00:40:24 +0100, Arjan van de Ven 
>>>>>>> <arjan@fenrus.demon.nl> said:
>>
>>
>>
>>   Arjan> On Wed, 2004-02-18 at 23:57, H. Peter Anvin wrote:
>>   >>  Because they were caught by surprise and just hacked the chips
>>   >> they had in the pipeline, presumably.
>>
>>   Arjan> fair enough; I hope this means the next generation has this
>>   Arjan> wart fixed...
>>
>> I wouldn't hold my breath.  My impression was that the Intel chipset
>> folks don't want I/O MMU because (a) Windows doesn't need it and (b)
>> real machines use (close-to-)64-bit-capable hardware.
> 
> 
> Doesn't need it? Does that mean the Win64 uses bounce buffers for 
> everything? Or am I totally misreading this?


Well, for 32-bit PCI hardware on a 64-bit OS, you pretty much have to 
bounce, without an IOMMU.

I doubt Win64 bounces for 64-bit PCI hardware, but who knows...

	Jeff



