Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283246AbRK2OaW>; Thu, 29 Nov 2001 09:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283252AbRK2OaN>; Thu, 29 Nov 2001 09:30:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51975 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283247AbRK2O37>; Thu, 29 Nov 2001 09:29:59 -0500
Subject: Re: cs4281 dead after BIOS upgrade
To: aer-list@mailandnews.com (Anders Eriksson)
Date: Thu, 29 Nov 2001 14:38:02 +0000 (GMT)
Cc: audio@crystal.cirrus.com (gw boynton), linux-kernel@vger.kernel.org
In-Reply-To: <200111291247.fATClEX23157@milou.dyndns.org> from "Anders Eriksson" at Nov 29, 2001 01:47:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169SKB-0000A3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just upgraded the BIOS on my Dell L400 laptop from rev A01 to A03. Now the cs4281 module refuses to load. I used to load perfectly.
> 
> Nov 29 13:19:40 devil kernel: cs4281: version v1.13.32 time 17:15:07 Nov 28 2001
> Nov 29 13:19:40 devil kernel: PCI: Found IRQ 10 for device 00:08.0
> Nov 29 13:19:41 devil kernel: cs4281: DLLRDY failed!
> Nov 29 13:19:41 devil kernel: cs4281: cs4281_hw_init() failed. Skipping part.
> Nov 29 13:19:41 devil kernel: cs4281: probe()- no device allocated
> 
> Any suggestions as to how to track down the offending changes?

Ask dell what they did to your BIOS, or go back to the old one probably.
The driver tried to initialize the clocking for the chip and it never 
reported back as stabilized.

Alan

