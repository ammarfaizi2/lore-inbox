Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSDTIX1>; Sat, 20 Apr 2002 04:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314587AbSDTIX0>; Sat, 20 Apr 2002 04:23:26 -0400
Received: from vaak.stack.nl ([131.155.140.140]:27401 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S314584AbSDTIXZ>;
	Sat, 20 Apr 2002 04:23:25 -0400
Date: Sat, 20 Apr 2002 10:23:22 +0200 (CEST)
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.8: ACPI: PCI IRQ remapping goes wrong.
Message-ID: <20020420101214.I33806-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

My SCSI card didn't work anymore, my NIC was unable to connect and my SB
Live! didn't work anymore. I thought 2.5.8 was a huge mess :)

Anyway: ACPI sets up IRQ remapping to IRQs > 15, but all PCI devices claim
the old =< 15 IRQ's. My guess is that the ACPI code doesn't update the pci
irq data.

If it matters: The system I talk about is a dual PII 333, on an Intel LX
chipset. 2.5.6 did boot fine.

Jos

