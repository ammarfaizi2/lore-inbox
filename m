Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbTBPJFx>; Sun, 16 Feb 2003 04:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbTBPJFx>; Sun, 16 Feb 2003 04:05:53 -0500
Received: from [66.62.77.7] ([66.62.77.7]:4827 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id <S265998AbTBPJFv>;
	Sun, 16 Feb 2003 04:05:51 -0500
Subject: 2.5.61+ (BK current) compile failures
From: Dax Kelson <dax@gurulabs.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Feb 2003 02:15:52 -0700
Message-Id: <1045386953.1700.43.camel@mentor>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This list isn't as big as it used to be, Alan recent round of SCSI fixes
shortened this list quite a bit. 

However, trying to compile the following code, modular, still fails. 

drivers/char/riscom8.c 
drivers/char/isicom.c 
drivers/char/esp.c 
drivers/char/specialix.c 
drivers/media/video/zr36120.c 
drivers/media/video/zr36067.c 
drivers/net/fc/iph5526.c 
drivers/net/wan/sdlamain.c 
drivers/net/rcpci45.c 
drivers/net/defxx.c 
drivers/scsi/inia100.c 
drivers/scsi/cpqfcTSinit.c 
drivers/scsi/ini9100u.c 
drivers/scsi/pci2000.c 
drivers/scsi/pci2220i.c 
drivers/scsi/psi240i.c 
drivers/scsi/dpt_i2o.c 
drivers/scsi/aha152x.c 
drivers/scsi/eata_dma.c 
drivers/scsi/tmscsim.c 
drivers/scsi/AM53C974.c
drivers/scsi/gdth.c
drivers/scsi/pcmcia/aha152x_stub.c
drivers/scsi/pcmcia/nsp_cs.c

Other errors:

*** Warning: Can't handle class_mask in drivers/serial/8250_pci:0001
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:0002
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:0004
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:0008
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:FFFF00
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:FFFF00
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:FFFF00
*** Warning: Can't handle class_mask in drivers/net/acenic:FFFF00
*** Warning: Can't handle class_mask in drivers/net/acenic:FFFF00
*** Warning: Can't handle class_mask in drivers/net/acenic:FFFF00
*** Warning: Can't handle class_mask in drivers/net/acenic:FFFF00
*** Warning: Can't handle class_mask in drivers/net/acenic:FFFF00
*** Warning: Can't handle class_mask in drivers/net/acenic:FFFF00
*** Warning: Can't handle class_mask in drivers/net/acenic:FFFF00
*** Warning: Can't handle class_mask in drivers/net/acenic:FFFF00
*** Warning: Can't handle class_mask in
drivers/scsi/aic7xxx/aic79xx:FFFF00
*** Warning: Can't handle class_mask in
drivers/scsi/aic7xxx/aic7xxx:FFFF00
*** Warning: Can't handle class_mask in
drivers/scsi/aic7xxx/aic7xxx:FFFF00
*** Warning: Can't handle class_mask in drivers/net/epic100:FFFF00
*** Warning: Can't handle class_mask in sound/oss/maestro3:FFFF00
*** Warning: Can't handle class_mask in sound/oss/maestro3:FFFF00
*** Warning: Can't handle class_mask in sound/oss/maestro3:FFFF00
*** Warning: Can't handle class_mask in drivers/ieee1394/ohci1394:FFFFFF
*** Warning: Can't handle class_mask in sound/pci/snd-es1968:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-es1968:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-es1968:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-fm801:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-maestro3:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-maestro3:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-maestro3:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-maestro3:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-maestro3:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-maestro3:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-maestro3:FFFF00
*** Warning: Can't handle class_mask in sound/pci/snd-maestro3:FFFF00
*** Warning: "page_states__per_cpu" [fs/xfs/xfs.ko] has no CRC!
*** Warning: "platform_bus_type" [drivers/pcmcia/tcic.ko] undefined!
*** Warning: "schedule_task" [drivers/char/stallion.ko] undefined!
*** Warning: "__udivdi3" [drivers/net/sk98lin/sk98lin.ko] undefined!
*** Warning: "net_statistics" [net/sctp/sctp.ko] has no CRC!
*** Warning: "ip_statistics" [net/sctp/sctp.ko] has no CRC!
*** Warning: "icmp_statistics" [net/sctp/sctp.ko] has no CRC!
*** Warning: "pcibios_find_device" [drivers/char/rocket.ko] undefined!
*** Warning: "page_states__per_cpu" [fs/reiserfs/reiserfs.ko] has no
CRC!
*** Warning: "page_states__per_cpu" [fs/nfs/nfs.ko] has no CRC!
*** Warning: "schedule_task" [drivers/char/istallion.ko] undefined!
*** Warning: "devfs_remove" [drivers/char/ip2main.ko] undefined!
*** Warning: "set_fs_pwd" [fs/intermezzo/intermezzo.ko] undefined!
*** Warning: "set_fs_root" [fs/intermezzo/intermezzo.ko] undefined!
*** Warning: "platform_bus_type" [drivers/pcmcia/i82365.ko] undefined!
*** Warning: "in_interrupt" [drivers/scsi/g_NCR5380.ko] undefined!
*** Warning: "in_interrupt" [drivers/scsi/g_NCR5380_mmio.ko] undefined!
*** Warning: "sti" [drivers/char/generic_serial.ko] undefined!
*** Warning: "save_flags" [drivers/char/generic_serial.ko] undefined!
*** Warning: "restore_flags" [drivers/char/generic_serial.ko] undefined!
*** Warning: "cli" [drivers/char/generic_serial.ko] undefined!
*** Warning: "fdomain_setup" [drivers/scsi/pcmcia/fdomain_cs.ko]
undefined!
*** Warning: "fdomain_16x0_reset" [drivers/scsi/pcmcia/fdomain_cs.ko]
undefined!
*** Warning: "fdomain_driver_template"
[drivers/scsi/pcmcia/fdomain_cs.ko] undefined!
*** Warning: "restore_flags" [drivers/char/epca.ko] undefined!
*** Warning: "cli" [drivers/char/epca.ko] undefined!
*** Warning: "save_flags" [drivers/char/epca.ko] undefined!
*** Warning: "reg_IRQL" [drivers/scsi/eata_pio.ko] undefined!
*** Warning: "reg_IRQ" [drivers/scsi/eata_pio.ko] undefined!
*** Warning: "add_to_page_cache" [fs/cifs/cifs.ko] undefined!
*** Warning: "__pagevec_lru_add" [fs/cifs/cifs.ko] undefined!
*** Warning: "awc_work" [drivers/net/aironet4500_core.ko] undefined!


