Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUAHM5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUAHM5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:57:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:2544 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264409AbUAHM5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:57:31 -0500
Message-ID: <3FFD51ED.7080209@die-strassers.de>
Date: Thu, 08 Jan 2004 13:49:49 +0100
From: Dominik Strasser <dominik@die-strassers.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI in 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:7996899f8b3439e83b57f413cfdb276d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
when I tried to activate ACPI on my computer, I received the mssage, 
that my BIOS is too old, and ACPI is automatically disabled.

I have a GigaByte 5AA mobo, which is a combined AT/ATX mobo (it has an 
ATX power socket, however it is in AT size).

Afterwards I tried acpi=force, which was proposed in the avove message.

The effect was:

ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control 
Methods:......................................................
..............................................
Table [DSDT](id F004) - 281 Objects with 29 Devices 100 Methods 17 Regions
ACPI Namespace successfully loaded at root c0428bdc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode 
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 
000000000
0004018 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 
000000000
000401C on int 9
Completing Region/Field/Buffer/Package 
initialization:............................
....................
Initialized 17/17 Regions 0/0 Fields 22/22 Buffers 9/9 Packages (289 nodes)
Executing all Device _STA and_INI methods:............ exfldio-0142 [23] 
ex_setup_
region       : Field [PS2E] access width (4 bytes) too large for region 
[PSRG] (le
ngth 1)
 exfldio-0153 [23] ex_setup_region       : Field [PS2E] 
Base+Offset+Width 0+0+4 is
 beyond end of region [PSRG] (length 1)
 psparse-1120: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.PS2M._STA] (Nod
e cbf448c8), AE_AML_REGION_LIMIT
  uteval-0098: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.PS2M._STA] (Nod
e cbf448c8), AE_AML_REGION_LIMIT
..................
30 Devices found containing: 29 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 exfldio-0142 [21] ex_setup_region       : Field [PS2E] access width (4 
bytes) too
 large for region [PSRG] (length 1)
 exfldio-0153 [21] ex_setup_region       : Field [PS2E] 
Base+Offset+Width 0+0+4 is
 beyond end of region [PSRG] (length 1)
 psparse-1120: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.PS2M._STA] (Nod
e cbf448c8), AE_AML_REGION_LIMIT
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f73f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6cc6, dseg 0xf0000
pnp: match found with the PnP device '00:00' and the driver 'system'
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
 pci_irq-0302 [22] acpi_pci_irq_derive   : Unable to derive IRQ for 
device 0000:00
:0f.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:0f.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'

which looks rather promising.

However, later, when my SCSI contoller probed its devices, the following 
message was printed:

Losing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.

Since then, some operations take _much_ longer.

So should I forget ACPI ?

Regards

Dominik


