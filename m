Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282684AbRLUOIZ>; Fri, 21 Dec 2001 09:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284246AbRLUOIQ>; Fri, 21 Dec 2001 09:08:16 -0500
Received: from unicef.org.yu ([194.247.200.148]:25872 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S282684AbRLUOIC>;
	Fri, 21 Dec 2001 09:08:02 -0500
Date: Fri, 21 Dec 2001 15:07:33 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Peter Svensson <petersv@psv.nu>
cc: Iain McClatchie <iain@TrueCircuits.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Promise Ultra ATA 133 TX2 support for the 2.2 kernel series
In-Reply-To: <Pine.LNX.4.33.0112211432280.1086-100000@cheetah.psv.nu>
Message-ID: <Pine.LNX.4.33.0112211440530.10437-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If your Promise ATA100 card is PDC20265/PDC20267 then it should work

in patch ide.2.2.19.05042001.patch you can read

+  Promise Ultra100 or PDC20265/PDC20267
+
+  This requires CONFIG_IDEDMA_AUTO to be enabled.
+
+  Please read the comments at the top of drivers/block/pdc202xx.c
+
+  If unsure, say N.
+
+Special UDMA Feature
+PDC202XX_FORCE_BURST_BIT
+  For PDC20246 and PDC20262 Ultra DMA chipsets.
+  Designed originally for PDC20246/Ultra33 that has BIOS setup failures
+  when using 3 or more cards.
+
+   Please read the comments at the top of drivers/block/pdc202xx.c
+
+   If unsure, say N.
+Special Mode Feature (EXPERIMENTAL)
+PDC202XX_FORCE_MASTER_MODE
+  For PDC20246 and PDC20262 Ultra DMA chipsets.
+  This is reserved for possible Hardware RAID 0,1 for the FastTrak
Series.
+
+  Say N.
+



On Fri, 21 Dec 2001, Peter Svensson wrote:



> Does this patch support lba48 commands? For which ide adapters? (I read an
> announcement from Intel that with a patch and a new driver their i8xx
> chipsets could use lba48.
>
> Specifically, I am interested in the Promise ATA100 cards since I own one.
>
> Peter
> --
> Peter Svensson      ! Pgp key available by finger, fingerprint:
> <petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
> ------------------------------------------------------------------------
> Remember, Luke, your source will be with you... always...
>
>

