Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271658AbRICKFV>; Mon, 3 Sep 2001 06:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271660AbRICKFJ>; Mon, 3 Sep 2001 06:05:09 -0400
Received: from mx5.port.ru ([194.67.57.15]:35333 "EHLO smtp5.port.ru")
	by vger.kernel.org with ESMTP id <S271658AbRICKE5>;
	Mon, 3 Sep 2001 06:04:57 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109031427.f83ERjM00379@vegae.deep.net>
Subject: first fruits forever
To: linux-kernel@vger.kernel.org
Date: Mon, 3 Sep 2001 14:27:44 +0000 (UTC)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       There is a second bit...

the left part of kernel was ok in the terms of compileability, but
failed on liking stage...

arch/i386/kernel/kernel.o: In function `enable_irq':
arch/i386/kernel/kernel.o(.text+0x3c90): undefined reference to `irq_vector'
arch/i386/kernel/kernel.o: In function `init_VISWS_APIC_irqs':
arch/i386/kernel/kernel.o(.text+0xd26a): undefined reference to `setup_x86_irq'
arch/i386/kernel/kernel.o: In function `setup_arch':
arch/i386/kernel/kernel.o(.text.init+0x1253): undefined reference to `get_smp_config'
arch/i386/kernel/kernel.o: In function `pcibios_fixup_irqs':
arch/i386/kernel/kernel.o(.text.init+0x3857): undefined reference to `visws_get_PCI_irq_vector'
arch/i386/kernel/kernel.o: In function `find_smp_config':
arch/i386/kernel/kernel.o(.text.init+0x515d): undefined reference to `find_intel_smp'
drivers/pci/driver.o: In function `pci_fixup_device':
drivers/pci/driver.o(.text+0x1e0b): undefined reference to `pcibios_fixups'
drivers/pci/driver.o: In function `pci_scan_bridge':
drivers/pci/driver.o(.text.init+0x32d): undefined reference to `pcibios_assign_all_busses'
make: *** [vmlinux] Error 1


cheers,
 Sam
