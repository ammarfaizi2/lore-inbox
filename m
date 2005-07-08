Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVGHUEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVGHUEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVGHUEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:04:09 -0400
Received: from bay20-f19.bay20.hotmail.com ([64.4.54.108]:2803 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262861AbVGHUDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:03:07 -0400
Message-ID: <BAY20-F1980D736F5F72579794A3DC4DB0@phx.gbl>
X-Originating-IP: [128.252.233.247]
X-Originating-Email: [jonschindler@hotmail.com]
In-Reply-To: <p734qb5p04e.fsf@verdi.suse.de>
From: "Jon Schindler" <jonschindler@hotmail.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of RAM
Date: Fri, 08 Jul 2005 16:03:04 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Jul 2005 20:03:05.0859 (UTC) FILETIME=[0DEB7530:01C583F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Thanks for the quick reply.  I'm at work, so I won't be able to test USB 
until I get home in a few hours.  I have an ssh connection to the machine, 
but that's it for now.  Just in case you are wondering what address it's 
using for DMA, below it a copy of my lspci -v.

Thanks again for replying.

Jon

00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [c0] AGP version 3.0

00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Flags: bus master, 66Mhz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev 
a1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Flags: 66Mhz, fast devsel, IRQ 11
	I/O ports at fc00 [size=32]
	I/O ports at 4c00 [size=64]
	I/O ports at 4c40 [size=64]
	Capabilities: [44] Power Management version 2

00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) 
(prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 185
	Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) 
(prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 193
	Memory at fe02e000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller 
(rev a2) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 177
	Memory at fe02d000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2

00:05.0 Bridge: nVidia Corporation CK8S Ethernet Controller (rev a2)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 193
	Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at f000 [size=8]
	Capabilities: [44] Power Management version 2

00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 
Audio Controller (rev a1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7585
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 209
	I/O ports at ec00 [size=256]
	I/O ports at e800 [size=128]
	Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller 
(v2.5) (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Flags: bus master, 66Mhz, fast devsel, latency 0
	I/O ports at dc00 [size=16]
	Capabilities: [44] Power Management version 2

00:09.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) 
(rev a2) (prog-if 85 [Master SecO PriO])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 177
	I/O ports at 09e0 [size=8]
	I/O ports at 0be0 [size=4]
	I/O ports at 0960 [size=8]
	I/O ports at 0b60 [size=4]
	I/O ports at c800 [size=16]
	I/O ports at c400 [size=128]
	Capabilities: [44] Power Management version 2

00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) 
(rev a2) (prog-if 85 [Master SecO PriO])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 185
	I/O ports at 09f0 [size=8]
	I/O ports at 0bf0 [size=4]
	I/O ports at 0970 [size=8]
	I/O ports at 0b70 [size=4]
	I/O ports at b000 [size=16]
	I/O ports at ac00 [size=128]
	Capabilities: [44] Power Management version 2

00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge 
(rev a2) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 16
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=10
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: fa000000-fcffffff
	Prefetchable memory behind bridge: e0000000-efffffff

00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev 
a2) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=128
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: fdf00000-fdffffff
	Prefetchable memory behind bridge: fde00000-fdefffff

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
	Flags: fast devsel

01:00.0 VGA compatible controller: nVidia Corporation NV40 [GeForce 6800 GT] 
(rev a1) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 201
	Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 3.0

02:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 02)
	Subsystem: ATI Technologies Inc: Unknown device 0001
	Flags: bus master, medium devsel, latency 32, IRQ 217
	Memory at fdeff000 (32-bit, prefetchable) [size=4K]

02:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 02)
	Subsystem: ATI Technologies Inc TV-Wonder
	Flags: bus master, medium devsel, latency 32, IRQ 217
	Memory at fdefe000 (32-bit, prefetchable) [size=4K]

02:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: Unknown device 0574:086c
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 225
	Memory at fdfff000 (32-bit, non-prefetchable) [size=2K]
	I/O ports at 8c00 [size=128]
	Capabilities: [50] Power Management version 2

02:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
Gigabit Ethernet (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 025c
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 201
	I/O ports at 8800 [size=256]
	Memory at fdffe000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [dc] Power Management version 2



>From: Andi Kleen <ak@suse.de>
>To: "Jon Schindler" <jonschindler@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of 
>RAM
>Date: 08 Jul 2005 21:29:37 +0200
>
>"Jon Schindler" <jonschindler@hotmail.com> writes:
> >
> > This mainly seems to be an issue with USB mass storage devices like
> > USB memory sticks and USB hard drives (I've tried both, and neither is
> > assigned a scsi device properly).  I am still able to use my USB mouse
> > when I have 3GB installed.  I'm not sure if that makes it a USB 1.1
> > issue or a USB storage issue, but hopefully someone will have some
> > insight after looking at the logs.  Thanks in advance for any help.
>
>It sounds like the Nvidia EHCI controller has trouble DMAing to high
>addresses. Would be a bad bug if true.
>
>Does it work when you disable EHCI and only enable OHCI? (this will
>limit you to USB 1.1)
>
>-Andi


