Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUCGWYh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 17:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbUCGWYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 17:24:36 -0500
Received: from host179-214.pool80181.interbusiness.it ([80.181.214.179]:1920
	"EHLO numb.darktech.org") by vger.kernel.org with ESMTP
	id S261815AbUCGWYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 17:24:30 -0500
Date: Sun, 7 Mar 2004 23:26:36 +0100 (CET)
From: Carlo Orecchia <carlo@numb.darktech.org>
To: "David B. Stevens" <dsteven3@maine.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL 2.6.3 and MAXTOR 160 GB
In-Reply-To: <404B5612.80506@maine.rr.com>
Message-ID: <Pine.LNX.4.44.0403072320180.2714-100000@numb.darktech.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sorry my stupid mistake .. this is the correct message from boot:
Thanks for any reply!!

ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:04.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:04.0 - using IRQ 
255
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: no response (status = 0xa1), resetting drive
hdc: no response (status = 0xa1)
hdd: no response (status = 0xa1), resetting drive
hdd: no response (status = 0xa1)
hdc: no response (status = 0xa1), resetting drive
hdc: no response (status = 0xa1)
hdd: no response (status = 0xa1), resetting drive
hdd: no response (status = 0xa1)
hda: max request size: 128KiB
hda: cannot use LBA48 - full capacity 320173056 sectors (163928 MB)
hda: 268435456 sectors (137438 MB) w/7936KiB Cache, CHS=16709/255/63, 
UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
ide-floppy driver 0.99.newide
Console: switching to colour frame buffer device 100x37
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05 
15:41:49 2004 UTC).
ALSA device list:
  #0: C-Media PCI CMI8738-MC6 (model 55) at 0xb000, irq 9
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (6143 buckets, 49144 max) - 300 bytes per 
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 272k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: irq 9, pci mem f1864000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ohci_hcd 0000:00:06.0: OHCI Host Controller
ohci_hcd 0000:00:06.0: irq 9, pci mem f1866000
ohci_hcd 0000:00:06.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
drivers/usb/core/usb.c: registered new driver usbmouse


Here is the .config of kernel (ATA section)

# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
# CONFIG_BLK_DEV_CS5520 is not set
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_SC1200=y
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

