Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVGQCWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVGQCWX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 22:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVGQCWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 22:22:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64006 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261677AbVGQCWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 22:22:22 -0400
Date: Sun, 17 Jul 2005 04:22:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       mj@ucw.cz
Subject: [2.6 patch] remove CONFIG_PCI_NAMES
Message-ID: <20050717022220.GC3613@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes CONFIG_PCI_NAMES.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Due to it's size, the patch is available at
  http://www.fs.tum.de/~bunk/kernel/patch-remove-CONFIG_PCI_NAMES

 Documentation/feature-removal-schedule.txt |    9 
 MAINTAINERS                                |    7 
 arch/alpha/kernel/sys_marvel.c             |    5 
 arch/ppc64/kernel/eeh.c                    |   31 
 arch/ppc64/kernel/iSeries_VpdInfo.c        |    5 
 arch/ppc64/kernel/pci.c                    |    1 
 drivers/char/drm/drmP.h                    |    4 
 drivers/infiniband/hw/mthca/mthca_main.c   |    8 
 drivers/infiniband/hw/mthca/mthca_reset.c  |    8 
 drivers/net/irda/vlsi_ir.h                 |    6 
 drivers/pci/Kconfig                        |   17 
 drivers/pci/Makefile                       |   18 
 drivers/pci/gen-devlist.c                  |  132 
 drivers/pci/names.c                        |  137 
 drivers/pci/pci.ids                        |10180 ---------------------
 drivers/pci/probe.c                        |    2 
 drivers/pci/proc.c                         |   12 
 drivers/usb/core/hcd-pci.c                 |    4 
 drivers/video/nvidia/nvidia.c              |    4 
 drivers/video/riva/fbdev.c                 |    4 
 include/linux/pci.h                        |   14 
 21 files changed, 32 insertions(+), 10576 deletions(-)


