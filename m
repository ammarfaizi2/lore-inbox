Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSKTKys>; Wed, 20 Nov 2002 05:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbSKTKys>; Wed, 20 Nov 2002 05:54:48 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:32664 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265402AbSKTKyq>; Wed, 20 Nov 2002 05:54:46 -0500
Message-Id: <4.3.2.7.2.20021120111430.00b57300@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 20 Nov 2002 12:02:03 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Linux 2.4.20 ACPI
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I think that I would rather see SNIP2 (from Suse 8.1 distro) than
SNIP1 from 2.4.20-rc2.
And I hear that there are MB's that won't boot without ACPI.
While I take the point that we are talking about a stable kernel
series, one shouldn't forget that ACPI is configurable :-)

--- SNIP 1 ---

<4> tbutils-0200 [03] Tb_validate_table_head: Table signature at e080f390 
[c15ffe24] has invalid characters
<4> tbutils-0202: *** Warning: Invalid table signature ASF! found
<4> tbxface-0095: *** Error: Acpi_load_tables: Error getting required 
tables (DSDT/FADT/FACS):AE_BAD_SIGNATURE
<4> tbxface-0116: *** Error: Acpi_load_tables: Could not load tables: 
AE_BAD_SIGNATURE
<3>ACPI: System description table load failed

--- END SNIP 1 ---

--- SNIP 2 ---

<7>ACPI: have wakeup address 0x40001000
<6>Advanced speculative caching feature not present
<4>On node 0 totalpages: 130880
<4>zone(0): 4096 pages.
<4>zone(1): 126784 pages.
<4>zone(2): 0 pages.
<6>ACPI: RSDP (v000 ACPIAM                     ) @ 0x000f70d0
<6>ACPI: RSDT (v001 INTEL  D845PESV 08194.04144) @ 0x1ff40000
<6>ACPI: FADT (v002 INTEL  D845PESV 08194.04144) @ 0x1ff40200
<6>ACPI: MADT (v001 INTEL  D845PESV 08194.04144) @ 0x1ff40300
<6>ACPI: ASF! (v016 AMIASF I845GASF 00000.00001) @ 0x1ff44390
<5>ACPI: BIOS passes blacklist
<4>Building zonelist for node : 0
<6>ACPI: Subsystem revision 20020829
<6>PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
<6>PCI: Using configuration type 1
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: System [ACPI] (supports S0 S1 S4 S5)
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
<6>ACPI: Power Resource [URP1] (off)
<6>ACPI: Power Resource [FDDP] (off)
<6>ACPI: Power Resource [LPTP] (off)
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 12 14 *15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
<6>PCI: Probing PCI hardware

--- END SNIP 2 ---

