Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270831AbUJUUhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270831AbUJUUhw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270897AbUJUUdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:33:09 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:40838 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S270939AbUJUU0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:26:51 -0400
Message-ID: <41781B13.3030803@rtr.ca>
Date: Thu, 21 Oct 2004 16:24:51 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE
 CF adaptor
References: <41780393.3000606@rtr.ca> <58cb370e041021121317083a3a@mail.gmail.com>
In-Reply-To: <58cb370e041021121317083a3a@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, patch withdrawn.

I'll just apply it to my own kernels for my own use.

Whatever happended to the days when Linux *wanted* more
drivers and such?

Oh well..
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

Bartlomiej Zolnierkiewicz wrote:
> please also cc: linux-ide@vger.kernel.org
> 
> 
>>An equivalent patch for 2.6.xx is being worked on.
> 
> 
> generally it should be like that: 2.6.x first, 2.4.x later
> 
> 
>>+ *  This is slightly peculiar, in that it is a PCI driver,
>>+ *  but is NOT an IDE PCI driver -- the IDE layer does not directly
>>+ *  support hot insertion/removal of PCI interfaces, so this driver
>>+ *  is unable to use the IDE PCI interfaces.  Instead, it uses the
>>+ *  same interfaces as the ide-cs (PCMCIA) driver uses.
>>+ *  On the plus side, the driver is also smaller/simpler this way.
> 
> 
> IDE layer doesn't support hot insertion/removal of _any_ interfaces
> 
> ide_unregister() calls are not allowed unless somebody fixes locking
> (Alan fixed many issues but some more work is still needed)
> 
> Bartlomiej
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

