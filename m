Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbUKTNg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUKTNg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 08:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbUKTNg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 08:36:28 -0500
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:45696
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262910AbUKTNgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 08:36:25 -0500
Subject: Kernel 2.6.10-rc2 and pci routing
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 20 Nov 2004 14:34:03 +0100
Message-Id: <1100957643.8329.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to everybody,

	I would like to know if this is of some importance or not. I notedt
this meesage in the dmesg today when I tried the linux-2.6.10-rc2
kernel. 

I use a Sony Vaio PCG-GRT816S on wich I added another 512MB of ram
and a wireles Dell TrueMobile 1300 minipci card.

ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Embedded Controller [EC0] (gpe 21)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:03: ioport range 0x8000-0x808f could not be reserved
pnp: 00:03: ioport range 0x8090-0x80ff has been reserved
pnp: 00:03: ioport range 0x8100-0x811f has been reserved
pnp: 00:03: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:03: ioport range 0xfe00-0xfe00 has been reserved
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1100959181.081:0): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1


Can somebody explain me what this pci routing thing is ?


Many thanks and please e-mail me as I'm not subscribed to the list.

If you need additional informations please contact me by e-mail.

Rgds
-- 
Sasa Ostrouska <sasa.ostrouska@volja.net>

