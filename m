Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161753AbWKHXxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161753AbWKHXxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161755AbWKHXxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:53:55 -0500
Received: from rtr.ca ([64.26.128.89]:8965 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161753AbWKHXxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:53:54 -0500
Message-ID: <45526E11.9000503@rtr.ca>
Date: Wed, 08 Nov 2006 18:53:53 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Saulo <slima@tse.gov.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE cs5530 hda: lost interrupt
References: <455254B8.4000704@tse.gov.br>
In-Reply-To: <455254B8.4000704@tse.gov.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saulo wrote:
> Hi all,
> 
> any help is wellcome...
> 
> --------------------
> CPU: NSC Geode(TM) Integrated Processor by National Semi stepping 02
> ...
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> CS5530: ide CONTROLLER AT pci SLOT 0000:00:12.2
> CS5530: chipset revision 0
> CS5530: not 100% native mode: will probe irqs later
> PCI: Enabling bus mastering for device 0000:00:12.2
> PCI: Setting latency timer of device 0000:00:12.2 to 64
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
> hda: CF 32MB, CFA DISK drive
> hda: IRQ probe failed (0xfeba)    >>> I think my problem may start here, 
> but when I fix to IRQ 14 in try_to_identify() to hda the problem persist
> ide0 at 0x1f0-0x1f7,0x3f6 on irq14
> hdc: Hitachi CV 5.1.1, CFA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15 (serialized with ide0)
> hda: max request size: 128KiB
> hda: 62976 sectors (32MB) w/1KiB Cache, CHS=492/4/32
> hda:<4>hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> ...
...

Send me one of those devices and I'll fix it.

Cheers
