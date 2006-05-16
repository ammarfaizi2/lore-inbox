Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWEPDvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWEPDvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 23:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWEPDvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 23:51:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:61402 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751239AbWEPDvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 23:51:47 -0400
Message-ID: <44694C4F.3000008@garzik.org>
Date: Mon, 15 May 2006 23:51:43 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Avuton Olrich <avuton@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org>	 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>	 <446914C7.1030702@garzik.org> <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
In-Reply-To: <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich wrote:
> On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
>> Avuton Olrich wrote:
>> > On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
>> >> * sata_sil and ata_piix also need healthy re-testing of all basic
>> >> functionality.
>> >
>> > I'm testing it right now, but with 2.6.17-rc4-git2 I was getting:
>>
>> Testing what?  sata_sil?  Please provide full dmesg, there's a lot of
>> missing information.
> 
> More followup, it did finally error out on me:
> 
> Not sure if it helps any, but this is a sata2 disk with a sata
> interface. This is rc4-git2 with the libata patch from the beginning
> of this thread, using sata_sil.

Can you configure your interrupts so that ethernet and SATA are not on 
the same irq?

Also, please provide _full_ dmesg and _full_ lspci, not just the 
SATA-related stuff.  This looks motherboard- or hardware-related.

	Jeff



