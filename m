Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRAaBUQ>; Tue, 30 Jan 2001 20:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRAaBUG>; Tue, 30 Jan 2001 20:20:06 -0500
Received: from [64.160.188.242] ([64.160.188.242]:2821 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S132027AbRAaBTw>; Tue, 30 Jan 2001 20:19:52 -0500
Date: Tue, 30 Jan 2001 17:18:54 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: David Raufeisen <david@fortyoz.org>, linux-kernel@vger.kernel.org
Subject: Re:  VT82C686A corruption with 2.4.x
In-Reply-To: <Pine.LNX.4.10.10101301743180.30535-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.21.0101301716490.3105-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here is the output of lspci -v on the SMP box I'm having trouble with
as requested...


00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Flags: bus master, medium devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d4000000-d7ffffff
	Prefetchable memory behind bridge: d8000000-d9ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at a000
	Capabilities: [c0] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel
	Capabilities: [68] Power Management version 2

00:0c.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at ac00
	I/O ports at b000
	I/O ports at b400
	I/O ports at b800
	I/O ports at bc00
	Memory at db000000 (32-bit, non-prefetchable)
	Capabilities: [58] Power Management version 1

00:0e.0 SCSI storage controller: Advanced System Products, Inc ABP940-UW
	Flags: bus master, medium devsel, latency 32, IRQ 15
	I/O ports at c000
	Memory at db020000 (32-bit, non-prefetchable)

00:10.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at c400
	Memory at db021000 (32-bit, non-prefetchable)

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
	Flags: 66Mhz, fast devsel
	Memory at d4000000 (32-bit, non-prefetchable)
	Memory at d8000000 (32-bit, prefetchable)
	I/O ports at 9000
	Capabilities: [54] AGP version 1.0
	Capabilities: [60] Power Management version 1


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
