Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312493AbSCUUwN>; Thu, 21 Mar 2002 15:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312492AbSCUUwC>; Thu, 21 Mar 2002 15:52:02 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:51925 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312491AbSCUUvs>; Thu, 21 Mar 2002 15:51:48 -0500
Date: Thu, 21 Mar 2002 21:51:30 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-kernel@vger.kernel.org
Subject: IBM PCI Hotplug driver doesn't compile in 2.4.19-pre4
Message-ID: <Pine.NEB.4.44.0203212148280.2125-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Building a kernel with the IBM PCI Hotplug driver statically included
fails at the final linking stage with a:

<--  snip  -->

...
drivers/hotplug/vmlinux-obj.o: In function `ibmphp_configure_card':
drivers/hotplug/vmlinux-obj.o(.text+0x13734): undefined reference to `ibmphp_pci_root_ops'
drivers/hotplug/vmlinux-obj.o(.text+0x137a8): undefined reference to `ibmphp_pci_root_ops'
drivers/hotplug/vmlinux-obj.o(.text+0x137c5): undefined reference to `ibmphp_pci_root_ops'
drivers/hotplug/vmlinux-obj.o(.text+0x139bf): undefined reference to `ibmphp_pci_root_ops'
drivers/hotplug/vmlinux-obj.o(.text+0x13beb): undefined reference to `ibmphp_pci_root_ops'
drivers/hotplug/vmlinux-obj.o(.text+0x14018): more undefined references to `ibmphp_pci_root_ops' follow
...

<--  snip  -->

cu
Adrian


