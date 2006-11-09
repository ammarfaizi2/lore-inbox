Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965965AbWKINAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965965AbWKINAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 08:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965974AbWKINAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 08:00:47 -0500
Received: from dexter.tse.gov.br ([200.252.157.99]:14810 "EHLO
	dexter.tse.gov.br") by vger.kernel.org with ESMTP id S965965AbWKINAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 08:00:46 -0500
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	NOD32 for Linux Mail Server.
	For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	for Linux Server. For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
Message-ID: <4553345A.3090305@tse.gov.br>
Date: Thu, 09 Nov 2006 10:59:54 -0300
From: Saulo <slima@tse.gov.br>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE cs5530 hda: lost interrupt
References: <455254B8.4000704@tse.gov.br> <45526E11.9000503@rtr.ca>
In-Reply-To: <45526E11.9000503@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:

> Saulo wrote:
>
>> Hi all,
>>
>> any help is wellcome...
>>
>> --------------------
>> CPU: NSC Geode(TM) Integrated Processor by National Semi stepping 02
>> ...
>> ide: Assuming 33MHz system bus speed for PIO modes; override with 
>> idebus=xx
>> CS5530: ide CONTROLLER AT pci SLOT 0000:00:12.2
>> CS5530: chipset revision 0
>> CS5530: not 100% native mode: will probe irqs later
>> PCI: Enabling bus mastering for device 0000:00:12.2
>> PCI: Setting latency timer of device 0000:00:12.2 to 64
>>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
>>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
>> hda: CF 32MB, CFA DISK drive
>> hda: IRQ probe failed (0xfeba)    >>> I think my problem may start 
>> here, but when I fix to IRQ 14 in try_to_identify() to hda the 
>> problem persist
>> ide0 at 0x1f0-0x1f7,0x3f6 on irq14
>> hdc: Hitachi CV 5.1.1, CFA DISK drive
>> ide1 at 0x170-0x177,0x376 on irq 15 (serialized with ide0)
>> hda: max request size: 128KiB
>> hda: 62976 sectors (32MB) w/1KiB Cache, CHS=492/4/32
>> hda:<4>hda: lost interrupt
>> hda: lost interrupt
>> hda: lost interrupt
>> ...
>
> ...
>
> Send me one of those devices and I'll fix it.
>
> Cheers
> -

Sorry... I would like but I can´t send one of this device to you. If you 
have any idea about this problem, any help is wellcome.

Saulo
