Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281369AbRKLJPz>; Mon, 12 Nov 2001 04:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281163AbRKLJOq>; Mon, 12 Nov 2001 04:14:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41995 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281077AbRKLJOO>; Mon, 12 Nov 2001 04:14:14 -0500
Subject: Re: Who sees "IRQ routing conflict" in dmesg?
To: miles@megapathdsl.net (Miles Lane)
Date: Mon, 12 Nov 2001 09:21:46 +0000 (GMT)
Cc: miles@megapathdsl.net (Miles Lane), linux-kernel@vger.kernel.org (LKML),
        manfred@colorfullife.com (Manfred Spraul)
In-Reply-To: <1005442525.14433.1.camel@stomata.megapathdsl.net> from "Miles Lane" at Nov 10, 2001 05:35:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163DHm-0005E5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PCI: PCI BIOS revision 2.10 entry at 0xfdad1, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Error 89 when fetching IRQ routing table.
> 
> As you can see below, I wasn't encountering this problem with
> 2.4.14.

PCI bios buffer too small. The BIOS seems to want to give you back a config
file over 4K long. That seems odd to say the least
