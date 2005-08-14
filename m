Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVHNB1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVHNB1y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 21:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVHNB1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 21:27:54 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:48326 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751370AbVHNB1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 21:27:53 -0400
Subject: 2.6.13-rc6-git5 : PCI mem resource alloc failure
From: Parag Warudkar <kernel-stuff@comcast.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 13 Aug 2005 21:27:50 -0400
Message-Id: <1123982870.2779.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.13-rc6-git5 I started getting the below errors. Despite of the
errors everything works fine. (only problem is that I have to
disconnect /reconnect the usb mouse for it to get detected..)


[    0.000000] Allocating PCI resources starting at 60000000 (gap:
60000000:9ff80000)
.
.
.
[   47.883970] PCI: Failed to allocate mem resource #10:2000000@e2000000
for 000 0:02:04.0
[   47.884002] PCI: Failed to allocate mem resource #10:2000000@e2000000
for 000 0:02:04.1
[   47.884030] PCI: Bus 3, cardbus bridge: 0000:02:04.0
[   47.884035]   IO window: 00003000-00003fff
[   47.884042]   IO window: 00004000-00004fff
[   47.884050]   PREFETCH window: 60000000-61ffffff
[   47.884056] PCI: Bus 7, cardbus bridge: 0000:02:04.1
[   47.884061]   IO window: 00005000-00005fff
[   47.884067]   IO window: 00006000-00006fff
[   47.884074]   PREFETCH window: 62000000-63ffffff
[   47.884080] PCI: Bridge: 0000:00:0a.0
[   47.884085]   IO window: 3000-7fff
[   47.884092]   MEM window: e0100000-e17fffff
[   47.884127]   PREFETCH window: 60000000-63ffffff
[   47.884137] PCI: Bridge: 0000:00:0b.0
[   47.884140]   IO window: disabled.
[   47.884148]   MEM window: e2000000-e2ffffff
[   47.884155]   PREFETCH window: f0000000-f80fffff
[   47.884170] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[   47.884806] ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 19
[   47.884818] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNK1] -> GSI
19 (lev el, low) -> IRQ 177
[   47.885434] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 18
[   47.885442] ACPI: PCI Interrupt 0000:02:04.1[B] -> Link [LNK2] -> GSI
18 (lev el, low) -> IRQ 185
[   47.886005] agpgart: Detected AGP bridge 0
[   47.886017] agpgart: Setting up Nforce3 AGP.
[   47.893822] agpgart: AGP aperture is 128M @ 0xe8000000

