Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265097AbUGIKax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbUGIKax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUGIKax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:30:53 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:21472 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S265097AbUGIKal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:30:41 -0400
Subject: Re: 2.6.7-mm7
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040708235025.5f8436b7.akpm@osdl.org>
References: <20040708235025.5f8436b7.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089369159.3198.4.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 09 Jul 2004 12:32:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 08:50, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> 
My EHCI controller still won't come back to life. I have tried 
various boot options to no avail. I still gives:

ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
ehci_hcd 0000:00:1d.7: can't reset
ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
ehci_hcd: probe of 0000:00:1d.7 failed with error -95
USB Universal Host Controller Interface driver v2.2

Booting with 'nosmp' make it stop booting at:

<snip>
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1200JB-00EVA0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

Jurgen


