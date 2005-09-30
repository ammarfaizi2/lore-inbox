Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbVI3Ogl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbVI3Ogl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVI3Ogl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:36:41 -0400
Received: from dvhart.com ([64.146.134.43]:36239 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030308AbVI3Ogk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:36:40 -0400
Date: Fri, 30 Sep 2005 07:36:35 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm2
Message-ID: <14500000.1128090994@[10.10.2.4]>
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
References: <20050929143732.59d22569.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hangs on boot on x86_64 (-mm1 did the same, -git8 is fine)

http://test.kernel.org/13722/debug/console.log

eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:09:3d:00:c9:fe
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[769f0000]
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 26 (level, low) -> IRQ 21
eth1: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:09:3d:00:c9:ff
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[769f0000]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f<4>logips2pp: Detected unknown logitech mouse model 0
, BIOS settings: hdc:DMA, hdd:pio
input: PS/2 Logitech Mouse on isa0060/serio1
-- 0:conmux-control -- time-stamp -- Sep/29/05 15:38:00 --



