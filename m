Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132050AbQKSAml>; Sat, 18 Nov 2000 19:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132089AbQKSAmb>; Sat, 18 Nov 2000 19:42:31 -0500
Received: from pm3-4-40.apex.net ([209.250.40.247]:7684 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S132050AbQKSAmT>; Sat, 18 Nov 2000 19:42:19 -0500
Date: Sat, 18 Nov 2000 18:11:10 -0600
From: Steven Walter <srwalter@hapablap.dyn.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: "No IRQ known for interrupt pin A..." error message
Message-ID: <20001118181110.A424@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During boot, I get the message:

PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try
using pci=biosirq.

If I boot with pci=biosirq, as the error message suggests, I get the
same error, save the part about trying with pci=biosirq.  This is with
version 2.4.0-test11-pre7 and as far back at least as test10-final.  I
don't remember seeing this error on earlier versions, though I may have
glossed over it.  Another possibly relevant part of the boot messages
is:

PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1039/0008] at 00:01.0
PCI: Cannot allocate resource region 9 of bridge 00:02.0

My motherboard uses the SiS530 chipset, and the bridge at 00:02.0 is the
AGP bridge.  If anyone's interested, I have the entire boot log.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
