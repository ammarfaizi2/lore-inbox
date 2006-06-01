Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWFAUau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWFAUau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWFAUau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:30:50 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:1880 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964933AbWFAUat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:30:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BgRpQJ8fFf8hrvClHLksiKHFvcVCn87v/QQFCG/rXmt7v8MQEn5NVoEBmfFZ2Ue1guretRZYm2KDyV+/nIaGHdBygAbNJQ86xGWQePrkFnB6d+CsNn4L1msOGLsqntmxbnUuMLhOT3l7H2oDJ/gHfRMNzyJgdnfvue+3dfOLOLU=
Message-ID: <a44ae5cd0606011330w3158f00bwbe6119943bbc4e2@mail.gmail.com>
Date: Thu, 1 Jun 2006 16:30:48 -0400
From: "Miles Lane" <miles.lane@gmail.com>
To: "Alistair John Strachan" <s0348365@sms.ed.ac.uk>
Subject: Re: 2.6.17-rc5-mm2 -- PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200606012045.29146.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0606010752n637c6411l805115f8170f0ebb@mail.gmail.com>
	 <200606012045.29146.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, my machine is a dv1240us HP laptop.  The machine appears to be
working fine.  I haven't tested all the devices, but the ones I am
using regularly are all happy campers.

0000:00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, fast devsel, latency 0
        Memory at <unassigned> (32-bit, prefetchable)
        Capabilities: [40] #09 [a105]

0000:00:00.1 System peripheral: Intel Corporation 82852/82855
GM/GME/PM/GMV Processor to I/O Controller (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, fast devsel, latency 0

0000:00:00.3 System peripheral: Intel Corporation 82852/82855
GM/GME/PM/GMV Processor to I/O Controller (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, fast devsel, latency 0

0000:00:02.0 VGA compatible controller: Intel Corporation 82852/855GM
Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 1800 [size=8]
        Capabilities: [d0] Power Management version 1

0000:00:02.1 Display controller: Intel Corporation 82852/855GM
Integrated Graphics Device (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, fast devsel, latency 0
        Memory at f0000000 (32-bit, prefetchable) [disabled] [size=128M]
        Memory at e0080000 (32-bit, non-prefetchable) [disabled] [size=512K]
        Capabilities: [d0] Power Management version 1

0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03) (prog-if 00
[UHCI])
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1820 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03) (prog-if 00
[UHCI])
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 0, IRQ 3
        I/O ports at 1840 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03) (prog-if 00
[UHCI])
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 0, IRQ 4
        I/O ports at 1860 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM
(ICH4/ICH4-M) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 0, IRQ 3
        Memory at e0100000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge
(rev 83) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=06, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: e0200000-e02fffff
        Prefetchable memory behind bridge: 50000000-51ffffff

0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC
Interface Bridge (rev 03)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 0, IRQ 4
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1810 [size=16]
        Memory at 52000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: medium devsel, IRQ 5
        I/O ports at 1880 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 1c00 [size=256]
        I/O ports at 18c0 [size=64]
        Memory at e0100c00 (32-bit, non-prefetchable) [size=512]
        Memory at e0100800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03) (prog-if 00
[Generic])
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: medium devsel, IRQ 5
        I/O ports at 2400 [size=256]
        I/O ports at 2000 [size=128]
        Capabilities: [50] Power Management version 2

0000:02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at 3000 [size=256]
        Memory at e0207800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

0000:02:06.0 Network controller: Intel Corporation PRO/Wireless 2200BG
(rev 05)        Subsystem: Hewlett-Packard Company: Unknown device
12f5
        Flags: bus master, medium devsel, latency 64, IRQ 4
        Memory at e0206000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

0000:02:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at e0209000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 50000000-51fff000 (prefetchable)
        Memory window 1: 54000000-55fff000
        I/O window 0: 00003400-000034ff
        I/O window 1: 00003800-000038ff
        16-bit legacy interface ports at 0001

0000:02:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant
IEEE 1394 Host Controller (prog-if 10 [OHCI])
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 64, IRQ 4
        Memory at e0207000 (32-bit, non-prefetchable) [size=2K]
        Memory at e0200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

0000:02:09.3 Mass storage controller: Texas Instruments PCIxx21
Integrated FlashMedia Controller
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at e0204000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [44] Power Management version 2

0000:02:09.4 0805: Texas Instruments PCI6411, PCI6421, PCI6611,
PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD)
Controller
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at e0208400 (32-bit, non-prefetchable) [size=256]
        Memory at e0208000 (32-bit, non-prefetchable) [size=256]
        Memory at e0207c00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2


On 6/1/06, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> On Thursday 01 June 2006 15:52, Miles Lane wrote:
> > ACPI: setting ELCR to 0200 (from 0c38)
> > PM: Adding info for No Bus:platform
> > NET: Registered protocol family 16
> > ACPI: bus type pci registered
> > PCI: PCI BIOS revision 2.10 entry at 0xfd9c2, last bus=2
> > Setting up standard PCI resources
> > ACPI: Subsystem revision 20060310
> > ACPI: Interpreter enabled
> > ACPI: Using PIC for interrupt routing
> > PM: Adding info for acpi:acpi
> > ACPI: PCI Root Bridge [PCI0] (0000:00)
> > PCI: Probing PCI hardware (bus 00)
> > PM: Adding info for No Bus:pci0000:00
> > Boot video device is 0000:00:02.0
> > PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
> > PCI quirk: region 1180-11bf claimed by ICH4 GPIO
> > PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> > PCI: Transparent bridge - 0000:00:1e.0
> > PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02)
> > (try 'pci=assign-busses')
> > Please report the result to linux-kernel to fix this permanently
>
> Is this an HP/Compaq notebook by any chance?
>
> --
> Cheers,
> Alistair.
>
> Third year Computer Science undergraduate.
> 1F2 55 South Clerk Street, Edinburgh, UK.
>
