Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289307AbSBJGYX>; Sun, 10 Feb 2002 01:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289313AbSBJGYN>; Sun, 10 Feb 2002 01:24:13 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:23816 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289307AbSBJGYF>; Sun, 10 Feb 2002 01:24:05 -0500
Subject: 2.5.4-pre5 -- More drivers needing pci_alloc_consistent work?
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 09 Feb 2002 22:21:14 -0800
Message-Id: <1013322074.28886.13.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/char/agp/agp.o: In function `amd_create_gatt_table':
drivers/char/agp/agp.o(.text+0x2057): undefined reference to
`virt_to_bus_not_defined_use_pci_map'
drivers/char/agp/agp.o(.text+0x2090): undefined reference to
`virt_to_bus_not_defined_use_pci_map'
drivers/net/appletalk/appletalk.o: In function `ipddp_xmit':
drivers/net/appletalk/appletalk.o(.text+0x47): undefined reference to
`atalk_find_dev_addr'
drivers/net/appletalk/appletalk.o(.text+0x110): undefined reference to
`aarp_send_ddp'
drivers/net/appletalk/appletalk.o: In function `ipddp_create':
drivers/net/appletalk/appletalk.o(.text+0x177): undefined reference to
`atrtr_get_dev'
drivers/video/video.o: In function `vesafb_init':
drivers/video/video.o(.text.init+0x14fe): undefined reference to
`bus_to_virt_not_defined_use_pci_map'


