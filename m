Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbTJTXv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbTJTXv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:51:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:4578 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262973AbTJTXvu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:51:50 -0400
From: Richard Hartmann <richih@smhsoftware.de>
To: linux-kernel@vger.kernel.org
Subject: ide pci bug in 2.6-test5 to test8?
Date: Tue, 21 Oct 2003 01:51:42 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310210151.47652.richih@smhsoftware.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi everyone,

since 2.6-test5 i have had the problem that lots of unknown symbols generate 
warnings without end. I am in no way sure if this is a bug or if i am just 
too dumb, but neither i nor google, nor groups.google, #kernelnewbies on oftc 
can find the reason for this behaviour.

As i am not subscribed to the mailing list, i would ask you to cc any help, 
hints, rants or the patch ;) to richih@smhsoftware.de :)

The warnings i get are:

  INSTALL lib/zlib_inflate/zlib_inflate.ko
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test8; fi
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/via82cxxx.ko needs 
unknown symbol ide_setup_pci_device
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/via82cxxx.ko needs 
unknown symbol ide_pci_register_host_proc
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/via82cxxx.ko needs 
unknown symbol ide_pci_unregister_driver
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/via82cxxx.ko needs 
unknown symbol ide_pci_register_driver
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/rz1000.ko needs 
unknown symbol ide_setup_pci_device
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/rz1000.ko needs 
unknown symbol ide_pci_unregister_driver
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/rz1000.ko needs 
unknown symbol ide_pci_register_driver
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/opti621.ko needs 
unknown symbol ide_setup_pci_device
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/opti621.ko needs 
unknown symbol ide_pci_unregister_driver
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/opti621.ko needs 
unknown symbol ide_pci_register_driver
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-probe.ko needs 
unknown symbol create_proc_ide_interfaces
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-probe.ko needs 
unknown symbol ide_cfg_sem
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-probe.ko needs 
unknown symbol idedefault_driver
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-probe.ko needs 
unknown symbol do_ide_request
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-probe.ko needs 
unknown symbol ide_add_generic_settings
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-probe.ko needs 
unknown symbol blk_queue_activity_fn
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol ide_scan_pcibus
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol ide_release_dma
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol create_proc_ide_interfaces
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol ide_add_proc_entries
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol proc_ide_read_capacity
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol destroy_proc_ide_drives
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol idedefault_driver
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol proc_ide_destroy
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol pnpide_init
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol ide_remove_proc_entries
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko needs unknown 
symbol proc_ide_create
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-floppy.ko needs 
unknown symbol proc_ide_read_geometry
WARNING: /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-disk.ko needs unknown 
symbol proc_ide_read_geometry
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/scsi/ide-scsi.ko 
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/via82cxxx.ko 
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/pci/opti621.ko 
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-taskfile.ko 
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-probe.ko 
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/ide.ko ignored, 
due to loop
WARNING: Loop detected: /lib/modules/2.6.0-test8/kernel/drivers/ide/
ide-iops.ko needs ide.ko which needs ide-iops.ko again!
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-iops.ko 
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-io.ko ignored, 
due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-floppy.ko 
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-disk.ko 
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-default.ko 
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/ide/ide-cd.ko ignored, 
due to loop
WARNING: Module /lib/modules/2.6.0-test8/kernel/drivers/usb/storage/
usb-storage.ko ignored, due to loop

- ----

cat .config | grep -i ide | grep -i pci
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_PCI_WIP is not set
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iEYEARECAAYFAj+UdRMACgkQ8YgX5STRbE2zugCcCbF9VgtYjYGgS2sYYZE5jEqZ
K6wAn0BjNLQTYpSka7sAZtLL4RhYGKxG
=L3q9
-----END PGP SIGNATURE-----

