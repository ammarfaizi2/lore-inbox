Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268922AbRHPWTG>; Thu, 16 Aug 2001 18:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268923AbRHPWS4>; Thu, 16 Aug 2001 18:18:56 -0400
Received: from h24-68-82-46.vc.shawcable.net ([24.68.82.46]:41480 "HELO
	brewt.org") by vger.kernel.org with SMTP id <S268922AbRHPWSq>;
	Thu, 16 Aug 2001 18:18:46 -0400
Date: Thu, 16 Aug 2001 15:19:05 -0700 (PDT)
From: BH <xcp@brewt.org>
To: <linux-kernel@vger.kernel.org>
Subject: PDC20268 Ultra100TX2
Message-ID: <Pine.LNX.4.30.0108161518170.2001-100000@stinky.brewt.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does 2.4.9 support the Promise Ultra100 TX2 IDE controller?
The title suggests it does, yet the Help for that option does not.
Is this card still only supported in the -ac series?

>From kernel config:

ATA/IDE/MFM/RLL support  --->
IDE, ATA and ATAPI Block devices  --->
PROMISE PDC202{46|62|65|67|68} support

-->Help

Linux Kernel v2.4.9 Configuration

PROMISE PDC202{46|62|65|67|68} support

CONFIG_BLK_DEV_PDC202XX:
Promise Ultra33 or PDC20246
Promise Ultra66 or PDC20262
Promise Ultra100 or PDC20265/PDC20267        *** does not say PDC20268 ***

This driver adds up to 4 more EIDE devices sharing a single
interrupt. This add-on card is a bootable PCI UDMA controller. Since
multiple cards can be installed and there are BIOS ROM problems that
happen if the BIOS revisions of all installed cards (three-max) do
not match, the driver attempts to do dynamic tuning of the chipset
at boot-time for max-speed. Ultra33 BIOS 1.25 or newer is required
for more than one card. This card may require that you say Y to
"Special UDMA Feature (EXPERIMENTAL)".

If you say Y here, you need to say Y to "Use DMA by default when
available" as well.

Please read the comments at the top of drivers/ide/pdc202xx.c
If unsure, say N.

