Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVCCCen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVCCCen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVCCCb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:31:26 -0500
Received: from falcon.csc.calpoly.edu ([129.65.242.5]:25073 "EHLO
	falcon.csc.calpoly.edu") by vger.kernel.org with ESMTP
	id S261418AbVCCC1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:27:22 -0500
Date: Wed, 2 Mar 2005 18:27:19 -0800 (PST)
From: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Bug report -- keyboard not working Linux 2.6.11 on Inspiron 1150
In-Reply-To: <200503022107.48403.dtor_core@ameritech.net>
Message-ID: <Pine.GSO.4.44.0503021818580.12224-100000@hornet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Relevent messages (erring on the heavy side)

ACPI: RSDP (v000 DELL                                  ) @ 0x000fdf00
ACPI: RSDT (v001 DELL    CPi R   0x27d4061d ASL  0x00000061) @ 0x1fef0000
ACPI: FADT (v001 DELL    CPi R   0x27d4061d ASL  0x00000061) @ 0x1fef0400
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
...
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
...
i8k: unable to get SMM Dell signature
i8k: unable to get SMM BIOS version
...
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
...
apm: BIOS not found.
NTFS driver 2.1.22 [Flags: R/W].
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (56 C)
...
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
...
i8042: ACPI detection disabled
i8042.c: Warning: Keylock active.
...
i8042: ACPI detection disabled
i8042.c: Warning: Keylock active.
...
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 7 (level, low) -> IRQ 7




