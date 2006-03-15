Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWCOIXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWCOIXx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 03:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWCOIXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 03:23:53 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:58046 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1750795AbWCOIXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 03:23:53 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 15 Mar 2006 09:23:01 +0100
MIME-Version: 1.0
Subject: Q: pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
Message-ID: <4417DCFD.18906.5800CF8@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.02.0+V=4.02+U=2.07.127+R=06 February 2006+T=119095@20060315.082335Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my board (Gigabyte K8N Pro SLI) has the latest Award BIOS ("F9"), but the kernel 
(SuSE Linux 10.0) keeps telling me during boot:

[...]
<7>PCI: Setting latency timer of device 0000:00:0b.0 to 64
<4>pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[pcie00]
<7>PCI: Setting latency timer of device 0000:00:0c.0 to 64
<4>pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[pcie00]
<7>PCI: Setting latency timer of device 0000:00:0d.0 to 64
<4>pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[pcie00]
<7>PCI: Setting latency timer of device 0000:00:0e.0 to 64
<4>pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[pcie00]
[...]

What is the message really about, and how does a proper BIOS fix look like? What 
is the name of that invalid IRQ? ;-) I can only assume that an unpopulated PCI 
express slot has no IRQ assigned at all.

Regards,
Ulrich Windl
P.S. Please CC: me for any replies as I'm not subscribed to the list.

