Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266532AbUHSP3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUHSP3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266507AbUHSPWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:22:47 -0400
Received: from baikonur.stro.at ([213.239.196.228]:19076 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266254AbUHSPSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:18:43 -0400
Date: Thu, 19 Aug 2004 17:18:43 +0200
From: maximilian attems <janitor@sternwelten.at>
To: kj <kernel-janitors@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [announce] 2.6.8.1-kjt2
Message-ID: <20040819151843.GB1712@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

quick update to latest patches from kernel janitors,
finalises list_for_each and completes min-max conversions.
newer patches mostly under arch.

if your patches are inside here, please make shure
everything landed, as it will be pushed to akpm.

here the patch (applies to 2.6.8.1):
http://debian.stro.at/kjt/2.6.8-kjt2/2.6.8-kjt2.patch.bz2

splitted out patches:
http://debian.stro.at/kjt/2.6.8-kjt2/split/

diffstat shows 221 files changed. 
a++ maks

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
added since 2.6.8-kjt1


remove-last-suser-call.patch
  From: maximilian attems <janitor@sternwelten.at>
  Subject: [patch-kj] remove-last-suser-call drivers/char/rocket.c

fix-typo-arm-dma.patch
  From: maximilian attems <janitor@sternwelten.at>
  Subject: [patch] fix-typo-arm-dma ./arch/arm26/machine/dma.c

msleep-drivers_net_slip.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: Re: 2.6.8.1-kjt1

msleep-compile-fix.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: 2.6.8.1-kjt1 2 Compile-warning fixes

list-for-each-arch_alpha_kernel_pci.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	arch-alpha-kernel-pci.c

list-for-each-arch_i386_pci_i386.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	arch-i386-pci-i386.c

list-for-each-arch_ia64_pci_pci.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: arch-ia64-pci-pci.c

list-for-each-arch_ia64_sn_io_machvec_pci_bus_cvlink.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	arch-ia64-sn-io-machvec-pci_bus_cvlink.c

list-for-each-arch_ppc64_kernel_pSeries_pci.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	arch-ppc64-kernel-pSeries_pci.c

list-for-each-arch_ppc64_kernel_pci.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	arch-ppc64-kernel-pci.c

list-for-each-arch_ppc64_kernel_pci_dn.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	arch-ppc64-kernel-pci_dn.c

list-for-each-arch_ppc_kernel_pci.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	arch-ppc-kernel-pci.c

list-for-each-arch_sparc64_kernel_pci_common.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	arch-sparc64-kernel-pci_common.c

list-for-each-arch_sparc64_kernel_pci_sabre.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	arch-sparc64-kernel-pci_sabre.c

list-for-each-arch_sparc_kernel_pcic.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	arch-sparc-kernel-pcic.c

list-for-each-drivers_char_drm_radeon_mem.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	drivers-char-drm-radeon_mem.c

list-for-each-drivers_net_ipv6_ip6_fib.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: net-ipv6-ip6_fib.c

list-for-each-drivers_net_tulip_de4x5.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8.1] list_for_each: 	drivers-net-tulip-de4x5.c

min-max-arch_ia64_hp_sim_simserial.patch
  From: Michael Veeck <michael.veeck@gmx.net>
  Subject: [Kernel-janitors] [PATCH] minmax-removal 	arch/ia64/hp/sim/simserial.c

min-max-arch_ia64_kernel_unwind.patch
  From: Michael Veeck <michael.veeck@gmx.net>
  Subject: [Kernel-janitors] [PATCH] minmax-removal arch/ia64/kernel/unwind.c

min-max-arch_ia64_sn_fakeprom_fw-emu.patch
  From: Michael Veeck <michael.veeck@gmx.net>
  Subject: [Kernel-janitors] [PATCH] minmax-removal 	arch/ia64/sn/fakeprom/fw-emu.c

min-max-arch_m68k_kernel_bios32.patch
  From: Michael Veeck <michael.veeck@gmx.net>
  Subject: [Kernel-janitors] [PATCH] minmax-removal arch/m68k/kernel/bios32.c

min-max-arch_mips_au1000_common_usbdev.patch
  From: Michael Veeck <michael.veeck@gmx.net>
  Subject: [Kernel-janitors] [PATCH] minmax-removal 	arch/mips/au1000/common/usbdev.c

min-max-arch_s390_kernel_debug.patch
  From: Michael Veeck <michael.veeck@gmx.net>
  Subject: [Kernel-janitors] [PATCH] minmax-removal arch/s390/kernel/debug.c

min-max-arch_sh_boards_bigsur_io.patch
  From: Michael Veeck <michael.veeck@gmx.net>
  Subject: [Kernel-janitors] [PATCH] minmax-removal arch/sh/boards/bigsur/io.c

min-max-arch_sh_cchips_hd6446x_hd64465_io.patch
  From: Michael Veeck <michael.veeck@gmx.net>
  Subject: [Kernel-janitors] [PATCH] minmax-removal 	arch/sh/cchips/hd6446x/hd64465/io.c

min-max-arch_um_drivers_mconsole_user.patch
  From: Michael Veeck <michael.veeck@gmx.net>
  Subject: [Kernel-janitors] [PATCH] minmax-removal 	arch/um/drivers/mconsole_user.c

msleep-drivers_message_fusion_mptbase.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [PATCH 2.6.8.1] message/mptbase: replace schedule_timeout() with msleep()

msleep-drivers_net_xirc2ps_cs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: Re: [Kernel-janitors] [PATCH] net/xirc2ps_cs: replace schedule_timeout() with msleep()


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
todo:
- split kernel_thread() patches from Walter Harms

