Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbTIRMQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 08:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTIRMQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 08:16:56 -0400
Received: from mail.id.cbs.dk ([130.226.47.91]:34056 "EHLO www-v61.id.cbs.dk")
	by vger.kernel.org with ESMTP id S261221AbTIRMQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 08:16:44 -0400
Date: Thu, 18 Sep 2003 14:16:38 +0200 (CEST)
Message-Id: <20030918.141638.104060144.dh@id.cbs.dk>
To: linux-kernel@vger.kernel.org
Subject: Cirrus Logic Crystal CS4281 PCI Audio
From: Daniel Hardt <dh@id.cbs.dk>
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an IBM X21 thinkpad with a Cirrus Logic Crystal CS4281 PCI
Audio sound chip.  Our system guy has not been able to get it to work
under linux.  below is the lspci output.  any ideas would be much
appreciated.  Please cc me.

thanks!

dan

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 64
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f4100000-f5ffffff

00:07.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at 1800 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 1820 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 03)
	Flags: medium devsel, IRQ 9

00:08.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: IBM: Unknown device 0185
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:08.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: IBM: Unknown device 0185
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 50100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=07, sec-latency=176
	Memory window 0: 10800000-10bff000 (prefetchable)
	Memory window 1: 10c00000-10fff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

00:0a.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0c)
	Subsystem: Intel Corp.: Unknown device 2205
	Flags: bus master, medium devsel, latency 66, IRQ 11
	Memory at f4010000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 1840 [size=64]
	Memory at f4020000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

00:0a.1 Serial controller: Lucent Microelectronics: Unknown device 045c (rev 01) (prog-if 00 [8250])
	Subsystem: Intel Corp.: Unknown device 2205
	Flags: medium devsel, IRQ 11
	I/O ports at 1810 [size=8]
	Memory at f4011000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:0b.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio (rev 01)
	Subsystem: IBM: Unknown device 0183
	Flags: medium devsel, IRQ 11
	Memory at f4012000 (32-bit, non-prefetchable) [size=4K]
	Memory at f4000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0182
	Flags: bus master, stepping, medium devsel, latency 66, IRQ 11
	Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at 2000 [size=256]
	Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>



Daniel Hardt                            Phone:        +45 38 15 31 26
Dept. of Computational Linguistics      Fax:          +45 38 15 38 20
Copenhagen Business School              email:           dh@id.cbs.dk
Denmark                                 web:        www.id.cbs.dk/~dh
