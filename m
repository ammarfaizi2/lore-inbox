Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753482AbWKCTTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbWKCTTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbWKCTTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:19:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:6358 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1753482AbWKCTTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:19:50 -0500
Message-ID: <454B962F.9020601@gmx.net>
Date: Fri, 03 Nov 2006 20:19:11 +0100
From: otto Meier <gf435@gmx.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jeff@garzik.org
Subject: NCQ for sata_promise
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:468b128da021a7447d21877842847db4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I have Promise NCQ info, just waiting for the chance to use it :)
>
> Plus I have a nagging suspicion that the SATA II cards have a few
> differences from the SATA I cards that have yet to be coded into
> sata_promise.c.
>
> 	Jeff

If have a sata 300TX4 card from Promise and a SATA-II Disk.

<7>sata_promise 0000:02:06.0: version 1.04
<4>ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
<6>GSI 17 sharing vector 0xB9 and IRQ 17
<6>ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [APC1] -> GSI 16 (level,
low) -> IRQ 185
<6>ata5: SATA max UDMA/133 cmd 0xFFFFC20000022200 ctl 0xFFFFC20000022238
bmdma 0x0 irq 185
<6>ata6: SATA max UDMA/133 cmd 0xFFFFC20000022280 ctl 0xFFFFC200000222B8
bmdma 0x0 irq 185
<6>ata7: SATA max UDMA/133 cmd 0xFFFFC20000022300 ctl 0xFFFFC20000022338
bmdma 0x0 irq 185
<6>ata8: SATA max UDMA/133 cmd 0xFFFFC20000022380 ctl 0xFFFFC200000223B8
bmdma 0x0 irq 185
<6>scsi4 : sata_promise
<6>ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata5.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)
<6>ata5.00: configured for UDMA/133SCSI device sde: 488397168 512-byte
hdwr sectors (250059 MB)
<5>sde: Write Protect is off
<7>sde: Mode Sense: 00 3a 00 00
<5>SCSI device sde: drive cache: write back
<5>SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
<5>sde: Write Protect is off
<7>sde: Mode Sense: 00 3a 00 00
<5>SCSI device sde: drive cache: write back
<6> sde: sde1 sde2 < sde5 >
<5>sd 4:0:0:0: Attached scsi disk sde
<5>sd 4:0:0:0: Attached scsi generic sg4 type 0
<5>  Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05


As far as  I read this messages NCQ should generaly work, but for some
reason
it is not enabled.

So how can I do this?
Or is still some coding missing as Jeff addressed in his statement from
May, which
I found searching the web for a hint.

It would be nice if someone could give me some info about it.




