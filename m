Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbWF2VKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWF2VKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWF2VKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:10:36 -0400
Received: from khc.piap.pl ([195.187.100.11]:7354 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932648AbWF2VKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:10:35 -0400
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD AM2 Sempron vs. Athlon - Confused
References: <44A40E50.5040901@perkel.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 29 Jun 2006 23:10:32 +0200
In-Reply-To: <44A40E50.5040901@perkel.com> (Marc Perkel's message of "Thu, 29 Jun 2006 10:30:56 -0700")
Message-ID: <m3y7vf7jnb.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel <marc@perkel.com> writes:

> And - can Linux kernels run on these new processors and motherboards
> or is this just too new to mess with?

I have an MSI K9N Ultra 2F mobo here and it does work fine - not
counting some kernel warnings such as:

ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
Error attaching device data
Error attaching device data
ACPI: PCI Root Bridge [PCI0] (0000:00)

PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[0378:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[0375:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
PCI: Setting latency timer of device 0000:00:0f.0 to 64
pcie_portdrv_probe->Dev[0377:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
(apparently about PCI bridges).


Main differences betweem AM2 vs. S939 are that you have to use DDR2 RAM,
and AM2s are usually less power hungry (thus cooler).
-- 
Krzysztof Halasa
