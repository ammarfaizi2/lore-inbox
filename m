Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUEJSLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUEJSLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 14:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUEJSLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 14:11:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61870 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261159AbUEJSLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 14:11:35 -0400
Message-ID: <409FC5C9.1000805@pobox.com>
Date: Mon, 10 May 2004 14:11:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Singer <elf@buici.com>
CC: sean <seandarcy@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: can't see drive on promise 20375 ATA card
References: <c7hgrq$5bv$1@sea.gmane.org> <409FAB04.5070006@pobox.com> <20040510180312.GC27648@buici.com>
In-Reply-To: <20040510180312.GC27648@buici.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer wrote:
> On Mon, May 10, 2004 at 12:17:08PM -0400, Jeff Garzik wrote:
> 
>>sean wrote:
>>
>>>libata version 1.02 loaded.
>>>sata_promise version 0.92
>>>ata1: SATA max UDMA/133 cmd 0xE1863200 ctl 0xE1863238 bmdma 0x0 irq 19
>>>ata2: SATA max UDMA/133 cmd 0xE1863280 ctl 0xE18632B8 bmdma 0x0 irq 19
>>>ata1: no device found (phy stat 00000000)
>>>ata1: thread exiting
>>>scsi0 : sata_promise
>>>ata2: no device found (phy stat 00000000)
>>>ata2: thread exiting
>>>scsi1 : sata_promise
>>>
>>>
>>>So it can see the SATA ports.
>>>
>>>How do I get the kernel to see the ATA port on the card?
>>
>>
>>The driver does not support the PATA ports.
> 
> 
> Do you think it is reasonable to include support for PATA ports in
> your code?


It is very reasonable :)  I just haven't had the time to do it yet.

	Jeff



