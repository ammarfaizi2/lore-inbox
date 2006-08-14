Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751957AbWHNI3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbWHNI3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 04:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWHNI3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 04:29:36 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:32651 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751948AbWHNI3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 04:29:35 -0400
Message-ID: <44E0346A.3040705@garzik.org>
Date: Mon, 14 Aug 2006 04:29:30 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Eric Schoeller <eric@junker.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: sata_sil driver dev 0 failed to IDENTIFY (INIT_DEV_PARAMS failed)
References: <20060814034028.C66081@junker.org>
In-Reply-To: <20060814034028.C66081@junker.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Schoeller wrote:
> howdy,
> 
> i am using the sata_sil driver with a Silicon Image, Inc. SiI 3112
> Controller and have recently started receiving these messages on driver
> load:
> 
> [17179867.424000] libata version 1.20 loaded.
> [17179958.936000] sata_sil 0000:02:0b.0: version 0.9
> [17179958.936000] ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link [LNKA] ->
> GSI 3 (level, low) -> IRQ 3
> [17179958.936000] ata1: SATA max UDMA/100 cmd 0xD0838080 ctl 0xD083808A
> bmdma 0xD0838000 irq 3
> [17179958.936000] ata2: SATA max UDMA/100 cmd 0xD08380C0 ctl 0xD08380CA 
> bmdma 0xD0838008 irq 3
> [17179966.296000] ata1 is slow to respond, please be patient
> [17179975.928000] ata1: SATA link up 1.5 Gbps (SStatus 113)
> [17179975.928000] ata1: dev 0 failed to IDENTIFY (INIT_DEV_PARAMS failed)
> [17179975.928000] scsi0 : sata_sil
> [17179976.132000] ata2: SATA link down (SStatus 0)
> 
> As a result, the maxtor 250gb drive fails to be detected   :(
> I'm  roughly 1900 miles away from this box so I have no ability to
> physically inspect the device. I'm worried that the drive is blown (sure
> wish smartmontools was compatible with libata so I might have seen this
> coming sooner!) but  after checking the usual sources I'm still not

smartmontools works just fine with libata, and has for quite a while.


> Any insights are greatly appreciated!

Switch out the drive and/or cable and see what happens...

	Jeff



