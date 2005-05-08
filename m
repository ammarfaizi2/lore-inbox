Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVEHJ3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVEHJ3y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 05:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVEHJ3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 05:29:54 -0400
Received: from mta-ps-be-08.sunrise.ch ([194.158.229.43]:48636 "EHLO
	mail-ps.sunrise.ch") by vger.kernel.org with ESMTP id S262827AbVEHJ3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 05:29:34 -0400
Date: Sun, 8 May 2005 11:29:32 +0200
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <Gregoire.Favre@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc[34] aic7xxx problems
Message-ID: <20050508092932.GA9133@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I don't know if 2.6.12-rc3 will boot completely if I let him enough
time, but 2.6.12-rc4 does, with plenty of errors.
For my usb scsi devices I have to probe for all luns, maybe it's
related ?

I attach what I have from dmesg, please CC to me if other infos are
needed :-)
-- 
	Grégoire Favre
___________________________________________________________________
http://magma.epfl.ch/Gregoire.Favre mailto:Gregoire.Favre@gmail.com

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

i1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue a TARGET RESET message
CDB: 0x12 0x0 0x0 0x0 0x60 0x0
scsi1:0:1:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 1 lun 0
 target1:0:1: Domain Validation detected failure, dropping back
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x12 0x0 0x0 0x0 0x60 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue a TARGET RESET message
CDB: 0x12 0x0 0x0 0x0 0x60 0x0
scsi1:0:1:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 1 lun 0
 target1:0:1: Domain Validation detected failure, dropping back
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x12 0x0 0x0 0x0 0x60 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue a TARGET RESET message
CDB: 0x12 0x0 0x0 0x0 0x60 0x0
scsi1:0:1:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 1 lun 0
 target1:0:1: Domain Validation detected failure, dropping back
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x12 0x0 0x0 0x0 0x60 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue a TARGET RESET message
CDB: 0x12 0x0 0x0 0x0 0x60 0x0
scsi1:0:1:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 1 lun 0
 target1:0:1: Domain Validation Failure, dropping back to Asynchronous
 target1:0:1: Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:2: Beginning Domain Validation
 target1:0:2: Domain Validation skipping write tests
(scsi1:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
 target1:0:2: Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:3: Beginning Domain Validation
 target1:0:3: Domain Validation skipping write tests
(scsi1:A:3): 10.000MB/s transfers (10.000MHz, offset 8)
 target1:0:3: Ending Domain Validation
libata version 1.10 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 4
ata1: SATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD000 irq 20
ata2: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xD008 irq 20
ata1: no device found (phy stat 00000000)
scsi2 : sata_via
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:407f
ata2: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi3 : sata_via
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 15, lun 0
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2
Attached scsi disk sdc at scsi3, channel 0, id 0, lun 0
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue a TARGET RESET message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:1:0: Command found on device queue
aic7xxx_abort returns 0x2002
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 1 lun 0
scsi1 (1:0): rejecting I/O to offline device
sr0: scsi3-mmc drive: 0x/0x caddy
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 1, lun 0
sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 2, lun 0
sr2: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr2 at scsi1, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 15, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 1, lun 0,  type 5
Attached scsi generic sg3 at scsi1, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg4 at scsi1, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg5 at scsi3, channel 0, id 0, lun 0,  type 0
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 21, io mem 0xcfffe900
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000bc00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.5 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
logips2pp: Detected unknown logitech mouse model 99
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
ALSA device list:
  #0: VIA 8237 with ALC655 at 0xb800, irq 22
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Testing NMI watchdog ... <3>ehci_hcd 0000:00:10.4: port 8 reset error -110
hub 1-0:1.0: hub_port_status failed (err = -32)
usb 1-8: new high speed USB device using ehci_hcd and address 2
hub 1-8:1.0: USB hub found
hub 1-8:1.0: 2 ports detected
usb 1-8.1: new high speed USB device using ehci_hcd and address 3
hub 1-8.1:1.0: USB hub found
hub 1-8.1:1.0: 4 ports detected
usb 1-8.2: new high speed USB device using ehci_hcd and address 4
OK.
ACPI wakeup devices: 
PCI0 UAR1 USB1 USB2 USB3 USB4 EHCI USBD  AC9  MC9 ILAN SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
hub 1-8.1:1.0: hub_port_status failed (err = -71)
hub 1-8.1:1.0: hub_port_status failed (err = -71)
hub 1-8.1:1.0: hub_port_status failed (err = -71)
hub 1-8.1:1.0: hub_port_status failed (err = -71)
usb 1-8: USB disconnect, address 2
usb 1-8.1: USB disconnect, address 3
usb 1-8.2: USB disconnect, address 4
ReiserFS: sdc2: found reiserfs format "3.6" with standard journal
usb 1-8: new high speed USB device using ehci_hcd and address 5
hub 1-8:1.0: USB hub found
hub 1-8:1.0: 2 ports detected
usb 1-8.1: new high speed USB device using ehci_hcd and address 6
hub 1-8.1:1.0: USB hub found
hub 1-8.1:1.0: 4 ports detected
usb 1-8.2: new high speed USB device using ehci_hcd and address 7
scsi5 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 7
usb-storage: waiting for device to settle before scanning
  Vendor: SMSC      Model: 223 U HS-CF       Rev: 3.60
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdd at scsi5, channel 0, id 0, lun 0
Attached scsi generic sg6 at scsi5, channel 0, id 0, lun 0,  type 0
  Vendor: SMSC      Model: 223 U HS-MS       Rev: 3.60
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sde at scsi5, channel 0, id 0, lun 1
Attached scsi generic sg7 at scsi5, channel 0, id 0, lun 1,  type 0
  Vendor: SMSC      Model: 223 U HS-SM       Rev: 3.60
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdf at scsi5, channel 0, id 0, lun 2
Attached scsi generic sg8 at scsi5, channel 0, id 0, lun 2,  type 0
  Vendor: SMSC      Model: 223 U HS-SD/MMC   Rev: 3.60
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdg at scsi5, channel 0, id 0, lun 3
Attached scsi generic sg9 at scsi5, channel 0, id 0, lun 3,  type 0
usb-storage: device scan complete
ReiserFS: sdc2: using ordered data mode
ReiserFS: sdc2: journal params: device sdc2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdc2: checking transaction log (sdc2)
ReiserFS: sdc2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 160k freed
Adding 506036k swap on /dev/hda2.  Priority:2 extents:1
Adding 530136k swap on /dev/sda2.  Priority:2 extents:1
Adding 530104k swap on /dev/sdb1.  Priority:1 extents:1
Adding 1004020k swap on /dev/sdc1.  Priority:3 extents:1
Linux agpgart interface v0.101 (c) Dave Jones
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7174  Tue Mar 22 06:45:40 PST 2005
XFS mounting filesystem sdb2
Ending clean XFS mount for filesystem: sdb2
XFS mounting filesystem hda4
Ending clean XFS mount for filesystem: hda4
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names


--5vNYLRcllDrimb99--
