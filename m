Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314496AbSEUNCX>; Tue, 21 May 2002 09:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314499AbSEUNCW>; Tue, 21 May 2002 09:02:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29458 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314496AbSEUNCV>; Tue, 21 May 2002 09:02:21 -0400
Subject: Re: cardbus/pcmcia/pci bridge problems?
To: pbd@op.net (Paul Davis)
Date: Tue, 21 May 2002 14:22:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205210353.g4L3rpk24320@op.net> from "Paul Davis" at May 20, 2002 11:53:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17A9ax-0007o9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >May 16 15:15:32 badass-bukvic kernel: PCI: Found IRQ 5 for device
> >02:03.0
> >May 16 15:15:33 badass-bukvic kernel: Hammerfall memory allocator:
> >buffers allocated for 1 cards
> >May 16 15:15:33 badass-bukvic kernel: PCI: No IRQ known for interrupt
> >pin A of device . Please try using pci=biosirq.

The $PIR table in the BIOS provided no useful information on what IRQ
to use, or we didn't know the IRQ router concerned to set it up.

Alan
