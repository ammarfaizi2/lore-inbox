Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVICR35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVICR35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 13:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVICR35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 13:29:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:23773 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751082AbVICR34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 13:29:56 -0400
Message-ID: <4319DD7A.7000702@pobox.com>
Date: Sat, 03 Sep 2005 13:29:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tyler <pml@dtbb.net>
CC: Brett Russ <russb@emc.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <4319AE7B.3010304@dtbb.net>
In-Reply-To: <4319AE7B.3010304@dtbb.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tyler wrote:
> Brett Russ wrote:
> 
>> Some (non-functional) cleanup modifications since the version 0.10
>> driver I sent out 2005-08-30.  Also adding signed-off-by for Jeff's
>> upstream push.  This is my libata compatible low level driver for
>> the Marvell SATA family.  Currently it successfully runs in PIO mode
>> on a 6081 chip.  EDMA support is in the works and should be done
>> shortly.  Review, testing (especially on other flavors of Marvell),
>> comments welcome.
>>
>> Thank you,
>> BR
>>
>> Signed-off-by: Brett Russ <russb@emc.com>
>>
>>  
>>
> [snip..]
> 
> Please find attached patches that add the Adaptec 1420SA controller to 
> the PCI ID list in the driver, and a small note in the kernel config 
> option to state so.  This is untested as of currently, if anyone has a 
> 1420SA to try, that would be great..  The one I had access to is now 
> gone to a remote location out of reach for testing.  I read in one post 
> I found with google, that the 1420SA uses a 6541 chip instead of a 6041, 
> but I am not able to verify this, and also don't know if it may still 
> work as a 6041.  The card is still a Sata2, PCI-X card, with 4 ports, 
> the same as the 6041 based cards.  This patch may or may not be 
> useful..  The card comes with a manufacturer ID of 9005 according to a 
> linux PCI-ID list, which is a secondary id of Adaptec's known as 
> ADAPTEC2, and an actual PCI Id of 0241.

I would prefer to have it tested, before accepting this patch...

	Jeff



