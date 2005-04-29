Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVD2Fk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVD2Fk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 01:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVD2Fk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 01:40:29 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:23243 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262387AbVD2Fjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 01:39:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=N2LLajnPRtEpJHJ51Axanb1f0KgEDS+eKrAfDgJEfcrzlM8FZY6eAP5J32WzlVGrmK2FjYuG1IEbRrRmmpaCckTj6046GPvJqjgZmJOgb+rGhmjnxxC9oiJbdsPkq+yCcZXJdha8ByhImNBXz/VK8KVJP4oYSy26iMOiRO9w3rI=
Message-ID: <b0fbeec405042822394a17a11f@mail.gmail.com>
Date: Fri, 29 Apr 2005 17:39:41 +1200
From: John Duthie <beyondgeek@gmail.com>
Reply-To: John Duthie <beyondgeek@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Intel E7221 Server Board SATA
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_64_22129099.1114753181127"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_64_22129099.1114753181127
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have a Server here with no working SATA drives=20

( Intel Server board SE7221BK1-E )

I've tried 2.6.11 and then 2.6.12-pre3=20

*grumble intel bleading edge products*

anyway does anyone have any clue or patches that might make this beast
tick (I'm supposed to be installing a file server on Tuesday :(   )

if i get really desperate i might have to try the Redhat drivers - but
I don't really want software raid just pain SATA .....
=20
attached is a lspci output=20

any other info needed ?=20

TIA

------=_Part_64_22129099.1114753181127
Content-Type: text/plain; name=lspci.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 05)
	Subsystem: Intel Corp. Server Memory Controller Hub
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] #09 [2109]

00:02.0 VGA compatible controller: Intel Corp. Graphics Controller (rev 05) (prog-if 00 [VGA])
	Subsystem: Intel Corp.: Unknown device 3444
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at dfe00000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at de00 [size=8]
	Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Memory at dfe80000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [d0] Power Management version 2

00:1c.0 PCI bridge: Intel Corp. I/O Controller Hub PCI Express Port 0 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1d.0 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3444
	Flags: bus master, medium devsel, latency 0, IRQ 23
	I/O ports at de80 [size=32]

00:1d.1 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3444
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at df00 [size=32]

00:1d.2 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3444
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at df80 [size=32]

00:1d.7 USB Controller: Intel Corp. I/O Controller Hub USB2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Intel Corp. I/O Controller Hub USB2
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at dfeffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: dff00000-dfffffff
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corp. I/O Controller Hub LPC (rev 03)
	Subsystem: Intel Corp. I/O Controller Hub LPC
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. I/O Controller Hub PATA (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 3444
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at fff0 [size=16]

00:1f.3 SMBus: Intel Corp. I/O Controller Hub SMBus (rev 03)
	Subsystem: Intel Corp.: Unknown device 3444
	Flags: medium devsel, IRQ 10
	I/O ports at 0400 [size=32]

01:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 64, IRQ 21
	I/O ports at ee00 [size=256]
	Memory at dffdbc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

01:03.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller (rev 05)
	Subsystem: Intel Corp.: Unknown device 3444
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
	Memory at dffe0000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at ef80 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.

02:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=48
	Capabilities: [44] #10 [0071]
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] 
02:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	Capabilities: [44] #10 [0071]
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] 
Linux servert 2.6.12-rc3 #1 SMP Thu Apr 29 17:17:10 NZST 2004 i686 unknown unknown GNU/Linux

------=_Part_64_22129099.1114753181127--
