Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVEQREU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVEQREU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVEQRDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:03:20 -0400
Received: from alog0330.analogic.com ([208.224.222.106]:62180 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261827AbVEQRAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:00:33 -0400
Date: Tue, 17 May 2005 13:00:08 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
cc: linux-scsi@vger.kernel.org
Subject: Linux 2.6.11.9 aic7xxx SCSI errors
Message-ID: <Pine.LNX.4.61.0505171256460.5400@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's my boot-up messages starting with when the SCSI system
was first initialized.  Something strange is happening that
didn't happen with other versions.....

RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 21
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec 2940 Ultra SCSI adapter>
         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
   Vendor: SEAGATE   Model: ST32171W          Rev: 0484
   Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
SCSI device sda: 4194057 512-byte hdwr sectors (2147 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 4194057 512-byte hdwr sectors (2147 MB)
SCSI device sda: drive cache: write back
  /dev/scsi/host0/bus0/target0/lun0: p1 p2 < p5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
   Vendor: SEAGATE   Model: ST318233LWV       Rev: 0002
   Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 4
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write back
  /dev/scsi/host0/bus0/target1/lun0: p1 p2
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
(scsi0:A:2): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
   Vendor: SEAGATE   Model: ST39102LW         Rev: 0005
   Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:2:0: Tagged Queuing enabled.  Depth 4
SCSI device sdc: 17783240 512-byte hdwr sectors (9105 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 17783240 512-byte hdwr sectors (9105 MB)
SCSI device sdc: drive cache: write back
  /dev/scsi/host0/bus0/target2/lun0: p1 p2 p3
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
   Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0b
   Type:   CD-ROM                             ANSI SCSI revision: 02
libata version 1.10 loaded.
ata_piix version 1.03
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 18
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 18
ata1: SATA port has no device.
scsi1 : ata_piix
ata2: SATA port has no device.
scsi2 : ata_piix
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
Freeing unused kernel memory: 244k freed
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03a0460(lo)
IPv6 over IPv4 tunneling driver
Real Time Clock Driver v1.12
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xfebffc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0xcc00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0xd000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0xd400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0xd800
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
EXT3 FS on hda1, internal journal
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x28 0x0 0x0 0x20 0x1c 0xc3 0x0 0x0 0x2 0x0
scsi0: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State while idle, at SEQADDR 0x7
Card was paused
ACCUM = 0xe0, SINDEX = 0x64, DINDEX = 0x65, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x1] 
SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x0] SEQCTL[0x10] 
SEQ_FLAGS[0xc0] SSTAT0[0x5] SSTAT1[0xa] SSTAT2[0x0] 
SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4] SXFRCTL0[0x80] 
DFCNTRL[0x0] DFSTATUS[0x2d] 
STACK: 0x0 0x150 0x191 0x3
SCB count = 8
Kernel NEXTQSCB = 0
Card NEXTQSCB = 0
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 0:3 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 3 2 4 5 6 7 8 9 10 11 12 13 14 15 
Sequencer SCB Info:
   0 SCB_CONTROL[0x6c] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x3]
   1 SCB_CONTROL[0xe8] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0xff]
   2 SCB_CONTROL[0xe8] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0xff]
   3 SCB_CONTROL[0xe8] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0xff]
   4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
   5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
   6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
   7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
   8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
   9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Pending list:
   3 SCB_CONTROL[0x68] SCB_SCSIID[0x7] SCB_LUN[0x0] 
Kernel Free SCB list: 7 1 2 6 5 4 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:4:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
(scsi0:A:0:0): Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:0:0): Abort Tag Message Sent
(scsi0:A:0:0): SCB 3 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
cdrom: open failed.
Adding 907664k swap on /dev/sdb2.  Priority:-1 extents:1
Adding 136544k swap on /dev/sdc2.  Priority:-2 extents:1
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x28 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x8 0x0
scsi0: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State while idle, at SEQADDR 0x7
Card was paused
ACCUM = 0x16, SINDEX = 0x64, DINDEX = 0x65, ARG_2 = 0x1
HCNT = 0x0 SCBPTR = 0x1
SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x1] 
SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x0] SEQCTL[0x10] 
SEQ_FLAGS[0xc0] SSTAT0[0x5] SSTAT1[0xa] SSTAT2[0x0] 
SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4] SXFRCTL0[0x80] 
DFCNTRL[0x0] DFSTATUS[0x2d] 
STACK: 0xcb 0x150 0x191 0x3
SCB count = 8
Kernel NEXTQSCB = 0
Card NEXTQSCB = 0
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 1:7 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 3 2 4 5 6 7 8 9 10 11 12 13 14 15 
Sequencer SCB Info:
   0 SCB_CONTROL[0xe8] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
   1 SCB_CONTROL[0x6c] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x7]
   2 SCB_CONTROL[0xe8] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0xff]
   3 SCB_CONTROL[0xe8] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0xff]
   4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
   5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
   6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
   7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
   8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
   9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Pending list:
   7 SCB_CONTROL[0x68] SCB_SCSIID[0x7] SCB_LUN[0x0] 
Kernel Free SCB list: 3 1 2 6 5 4 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:4:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
(scsi0:A:0:0): Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:0:0): Abort Tag Message Sent
(scsi0:A:0:0): SCB 7 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: No new microcode data for CPU0
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
pnp: Device 00:08 disabled.
sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg3 at scsi0, channel 0, id 4, lun 0,  type 5

[End of SCSI entries]

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
