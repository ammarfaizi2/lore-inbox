Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWFPLZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWFPLZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWFPLZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:25:20 -0400
Received: from math.ut.ee ([193.40.36.2]:49310 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751319AbWFPLZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:25:20 -0400
Date: Fri, 16 Jun 2006 14:25:17 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Lots of new section mismatches
Message-ID: <Pine.SOC.4.61.0606161340070.16561@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got these warning after doing cg-update on current git tree (only 8 new 
changes form last rime). Got these warnings, make clean && make and the 
warnings are gone - why?

WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0xebd) and 'acpi_safe_halt'
WARNING: drivers/atm/he.o - Section mismatch: reference to .init.text: from .text after 'he_init_one' (at offset 0x225e)
WARNING: drivers/atm/iphase.o - Section mismatch: reference to .init.text: from .text between 'ia_init_one' (at offset 0x1903) and 'ia_int'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x160) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x18c) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x1b8) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x1e4) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x210) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x23c) and '__param_str_force'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x130) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x148) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x160) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x178) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x190) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x1a8) and '__param_str_ircc_dma'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.data: from .text between 'atyfb_pci_probe' (at offset 0x2baa) and 'aty_enable_irq'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.text:aty_init_cursor from .text between 'atyfb_pci_probe' (at offset 0x2c48) and 'aty_enable_irq'
WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab after '__ksymtab_mac_find_mode' (at offset 0x18)
WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to .init.text:jffs2_zlib_init from .text between 'jffs2_compressors_init' (at offset 0x1f) and 'jffs2_free_comprbuf'


-- 
Meelis Roos (mroos@linux.ee)
