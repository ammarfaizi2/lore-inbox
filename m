Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030622AbVKXIVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030622AbVKXIVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 03:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030624AbVKXIVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 03:21:11 -0500
Received: from agmk.net ([217.73.31.34]:5646 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S1030622AbVKXIVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 03:21:10 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.14.2/sparc64] build report / undefined symbols.
Date: Thu, 24 Nov 2005 09:20:58 +0100
User-Agent: KMail/1.8.3
References: <20051123223443.GZ3963@stusta.de>
In-Reply-To: <20051123223443.GZ3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511240920.59182.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed several broken modules on sparc64 modular build:

"bus_to_virt_not_defined_use_pci_map" [drivers/atm/zatm.ko] undefined!
"virt_to_bus_not_defined_use_pci_map" [drivers/atm/zatm.ko] undefined!
"bus_to_virt_not_defined_use_pci_map" [drivers/atm/horizon.ko] undefined!
"virt_to_bus_not_defined_use_pci_map" [drivers/atm/firestream.ko] undefined!
"bus_to_virt_not_defined_use_pci_map" [drivers/atm/firestream.ko] undefined!
"virt_to_bus_not_defined_use_pci_map" [drivers/atm/ambassador.ko] undefined!
"bus_to_virt_not_defined_use_pci_map" [drivers/atm/ambassador.ko] undefined!
"bus_to_virt_not_defined_use_pci_map" [drivers/media/video/zr36067.ko]undefined!
"virt_to_bus_not_defined_use_pci_map" [drivers/media/video/zr36067.ko]undefined!
"virt_to_bus_not_defined_use_pci_map" [drivers/media/video/stradis.ko]undefined!
"bus_to_virt_not_defined_use_pci_map" [drivers/scsi/tmscsim.ko] undefined!

"isa_memset_io" [drivers/net/hp100.ko] undefined!
"isa_memcpy_toio" [drivers/net/hp100.ko] undefined!
"isa_readl" [drivers/net/hp100.ko] undefined!
"isa_memcpy_fromio" [drivers/net/hp100.ko] undefined!

"sbus_build_irq" [drivers/serial/sunzilog.ko] undefined!
"build_irq" [drivers/serial/sunzilog.ko] undefined!
"apply_central_ranges" [drivers/serial/sunzilog.ko] undefined!
"apply_fhc_ranges" [drivers/serial/sunzilog.ko] undefined!
"prom_halt" [drivers/serial/sunzilog.ko] undefined!
"prom_printf" [drivers/serial/sunzilog.ko] undefined!
"central_bus" [drivers/serial/sunzilog.ko] undefined!

BR,

-- 
to_be || !to_be == 1, to_be | ~to_be == -1
