Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262177AbSITKmW>; Fri, 20 Sep 2002 06:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262205AbSITKmT>; Fri, 20 Sep 2002 06:42:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25300 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262177AbSITKmL>; Fri, 20 Sep 2002 06:42:11 -0400
Date: Fri, 20 Sep 2002 12:47:12 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre7-ac3
In-Reply-To: <200209191728.g8JHSBg22827@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0209201245130.2586-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:

The following errors during "depmod -a" occur with a completely modular
IDE:

<--  snip  -->

depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre7-ac3/kernel/drivers/ide/ide-disk.o
depmod:         proc_ide_read_geometry_Rsmp_50fed6f7
depmod:         ide_remove_proc_entries_Rsmp_27d82c2d
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre7-ac3/kernel/drivers/ide/ide-floppy.o
depmod:         proc_ide_read_geometry_Rsmp_50fed6f7
depmod:         ide_remove_proc_entries_Rsmp_27d82c2d
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre7-ac3/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod:         create_proc_ide_interfaces_Rsmp_ab2c600e
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre7-ac3/kernel/drivers/ide/ide-tape.o
depmod:         ide_remove_proc_entries_Rsmp_27d82c2d
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre7-ac3/kernel/drivers/ide/ide.o
depmod:         ide_release_dma
depmod:         proc_ide_create_Rsmp_a8e0f104
depmod:         destroy_proc_ide_drives_Rsmp_766b30ab
depmod:         ide_add_proc_entries_Rsmp_22d51f1e
depmod:         cmd640_vlb
depmod:         ide_probe_for_cmd640x
depmod:         ide_scan_pcibus
depmod:         ide_remove_proc_entries_Rsmp_27d82c2d
depmod:         create_proc_ide_interfaces_Rsmp_ab2c600e
depmod:         proc_ide_read_capacity_Rsmp_46b2a30d
depmod:         proc_ide_destroy_Rsmp_35e1351c
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre7-ac3/kernel/drivers/ide/pci/nvidia.o
depmod:         ide_setup_pci_device_Rsmp_2a4698a2
depmod:         ide_pci_register_host_proc_Rsmp_38468cb8
depmod:         ide_pci_register_driver_Rsmp_fdf6fe0f
depmod:         ide_setup_dma_Rsmp_aa72056d
depmod:         ide_pci_unregister_driver_Rsmp_4abd4203
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre7-ac3/kernel/drivers/ide/pci/pdc202xx_new.o
depmod:         ide_setup_pci_device_Rsmp_2a4698a2
depmod:         ide_pci_register_host_proc_Rsmp_38468cb8
depmod:         __ide_dma_lostirq_Rsmp_71e2a27d
depmod:         ide_setup_pci_devices_Rsmp_3d91f319
depmod:         __ide_dma_timeout_Rsmp_7af82283
depmod:         ide_pci_register_driver_Rsmp_fdf6fe0f
depmod:         ide_setup_dma_Rsmp_aa72056d
depmod:         ide_pci_unregister_driver_Rsmp_4abd4203
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre7-ac3/kernel/drivers/ide/pci/pdc202xx_old.o
depmod:         ide_setup_pci_device_Rsmp_2a4698a2
depmod:         ide_pci_register_host_proc_Rsmp_38468cb8
depmod:         __ide_dma_lostirq_Rsmp_71e2a27d
depmod:         __ide_dma_timeout_Rsmp_7af82283
depmod:         ide_pci_register_driver_Rsmp_fdf6fe0f
depmod:         __ide_dma_begin_Rsmp_5f2c0738
depmod:         __ide_dma_end_Rsmp_30e059ac
depmod:         ide_setup_dma_Rsmp_aa72056d
depmod:         ide_pci_unregister_driver_Rsmp_4abd4203
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre7-ac3/kernel/drivers/ide/pci/siimage.o
depmod:         ide_setup_pci_device_Rsmp_2a4698a2
depmod:         ide_pci_register_host_proc_Rsmp_38468cb8
depmod:         __ide_dma_verbose_Rsmp_4a833268
depmod:         ide_pci_register_driver_Rsmp_fdf6fe0f
depmod:         __ide_dma_count_Rsmp_741a0d95
depmod:         ide_setup_dma_Rsmp_aa72056d
depmod:         ide_pci_unregister_driver_Rsmp_4abd4203

<--  snip  -->


cu
Adrian

