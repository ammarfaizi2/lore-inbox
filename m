Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWIBVr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWIBVr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 17:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWIBVr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 17:47:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62650 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751627AbWIBVr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 17:47:27 -0400
Subject: Re: 2.6.18-rc5 + pata-drivers on MSI K9N Ultra report, AMD64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
In-Reply-To: <m3psee58lg.fsf@defiant.localdomain>
References: <m3psee58lg.fsf@defiant.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 02 Sep 2006 23:09:03 +0100
Message-Id: <1157234944.6271.400.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-02 am 22:14 +0200, ysgrifennodd Krzysztof Halasa:
> ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
> ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
> 
> There is no secondary IDE connector on this motherboard, I think
> it's just disabled by BIOS.

Its there if it got that far. May not be wired.

> scsi3 : pata_amd
> ata4: port is slow to respond, please be patient
> ata4: port failed to respond (30 secs)

Please send me an lspci -vxxx. This might be BIOS or might be us
misparsing disable/enable bits.



-- 
VGER BF report: U 0.5
