Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUEFMVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUEFMVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUEFMVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:21:30 -0400
Received: from ns.schottelius.org ([213.146.113.242]:7062 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S262060AbUEFMVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:21:05 -0400
Date: Thu, 6 May 2004 14:21:12 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 usb Input/Output problems
Message-ID: <20040506122112.GE1279@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.3
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

If I read or write much data from usb devices (ide hardisks,
usb sticks, whatever), I get an Input/Output error.

I can verify this on every computer with Linux running
(even 2.4, but I used 2.4 only 2002..).

What is going wrong here and how can I fix it? (attached dmesg)

If you need more information about the issue please tell me!

Nico

ps: please cc me...

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-scsi-usb-error

s0/target0/lun0: p1 p2 p3 p4
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.8
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.13 2004-Mar-09, 1 devices found
Please report your BIOS at http://linux.dell.com/edd/results.html
XFS mounting filesystem hda3
Ending clean XFS mount for filesystem: hda3
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 148k freed
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
XFS mounting filesystem loop0
Ending clean XFS mount for filesystem: loop0
Adding 192772k swap on /dev/discs/disc0/part2.  Priority:-1 extents:1
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xd886ee00, 00:0a:e6:ba:f6:c2, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0356a80(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: no IPv6 routers present
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:0a.0: UHCI Host Controller
uhci_hcd 0000:00:0a.0: irq 11, io base 0000de80
uhci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:0a.1: UHCI Host Controller
uhci_hcd 0000:00:0a.1: irq 5, io base 0000df00
uhci_hcd 0000:00:0a.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using address 2
usb 2-2: new full speed USB device using address 3
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: IBM-DJSA  Model: -210              Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 02
USB Mass Storage device found at 2
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 19640880 512-byte hdwr sectors (10056 MB)
sda: assuming drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0:<6>ehci_hcd 0000:00:0a.2: EHCI Host Controller
ehci_hcd 0000:00:0a.2: irq 9, pci mem d890df00
ehci_hcd 0000:00:0a.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:0a.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Dec-29
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
usb 2-1: USB disconnect, address 2
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sdb : READ CAPACITY failed.
sdb : status=0, message=00, host=7, driver=00 
sdb : sense not available. 
sdb: assuming Write Enabled
sdb: assuming drive cache: write through
sdb : READ CAPACITY failed.
sdb : status=0, message=00, host=7, driver=00 
sdb : sense not available. 
sdb: assuming Write Enabled
sdb: assuming drive cache: write through
sdb : READ CAPACITY failed.
sdb : status=0, message=00, host=7, driver=00 
sdb : sense not available. 
sdb: assuming Write Enabled
sdb: assuming drive cache: write through
 /dev/scsi/host1/bus0/target0/lun0:<3>Buffer I/O error on device sdb, logical block 0
Buffer I/O error on device sdb, logical block 0
 unable to read partition table
 /dev/scsi/host1/bus0/target0/lun0:<3>Buffer I/O error on device sdb, logical block 0
 unable to read partition table
Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 0
USB Mass Storage device found at 3
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
usb 2-2: USB disconnect, address 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
usb 3-3: new high speed USB device using address 2
scsi2 : SCSI emulation for USB Mass Storage devices
  Vendor: IBM-DJSA  Model: -210              Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 19640880 512-byte hdwr sectors (10056 MB)
sda: assuming drive cache: write through
 /dev/scsi/host2/bus0/target0/lun0: p1 p2
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
USB Mass Storage device found at 2
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:14.0: OHCI Host Controller
ohci_hcd 0000:00:14.0: irq 10, pci mem d889e000
ohci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using address 4
scsi3 : SCSI emulation for USB Mass Storage devices
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdb: 125120 512-byte hdwr sectors (64 MB)
sdb: assuming Write Enabled
sdb: assuming drive cache: write through
 /dev/scsi/host3/bus0/target0/lun0: p1
Attached scsi removable disk sdb at scsi3, channel 0, id 0, lun 0
USB Mass Storage device found at 4
usb 4-1: new full speed USB device using address 2
prism2usb_init: prism2_usb.o: 0.2.1-pre20 Loaded
prism2usb_init: dev_info is: prism2_usb
drivers/usb/core/usb.c: registered new driver prism2_usb
ident: nic h/w: id=0x8026 1.0.0
ident: pri f/w: id=0x15 1.1.3
ident: sta f/w: id=0x1f 1.5.6
MFI:SUP:role=0x00:id=0x01:var=0x01:b/t=1/1
CFI:SUP:role=0x00:id=0x02:var=0x02:b/t=1/1
PRI:SUP:role=0x00:id=0x03:var=0x01:b/t=1/4
STA:SUP:role=0x00:id=0x04:var=0x01:b/t=1/10
PRI-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-MFI:ACT:role=0x01:id=0x01:var=0x01:b/t=1/1
Prism2 card SN: \x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00
linkstatus=CONNECTED
usb 2-2: USB disconnect, address 4
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
XFS mounting filesystem sda2
Ending clean XFS mount for filesystem: sda2
spurious 8259A interrupt: IRQ7.
NET: Registered protocol family 15
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251712
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251720
XFS: device sda2- XFS write error in file system meta-data block 0x4c0 in sda2
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251728
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251736
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251744
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251752
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251728
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251736
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251712
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251720
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251744
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251752
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251776
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251784
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251792
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251800
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251776
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251784
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251680
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6250600
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251792
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251800
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251824
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251832
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251840
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251848
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251824
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251832
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251840
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 6251848
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945440
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945445
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945453
I/O error in filesystem ("sda2") meta-data dev sda2 block 0x662820       ("xlog_iodone") error 5 buf count 10752
xfs_force_shutdown(sda2,0x2) called from line 966 of file fs/xfs/xfs_log.c.  Return address = 0xc01eeae9
Filesystem "sda2": Log I/O Error Detected.  Shutting down filesystem: sda2
Please umount the filesystem, and rectify the problem(s)
xfs_force_shutdown(sda2,0x2) called from line 726 of file fs/xfs/xfs_log.c.  Return address = 0xc01eeae9
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945461
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945469
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945477
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945485
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945493
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945501
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945509
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12945517
I/O error in filesystem ("sda2") meta-data dev sda2 block 0x662835       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda2,0x2) called from line 966 of file fs/xfs/xfs_log.c.  Return address = 0xc01eeae9
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965749
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965757
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965765
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965773
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965781
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965789
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965797
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965805
I/O error in filesystem ("sda2") meta-data dev sda2 block 0x667775       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda2,0x2) called from line 966 of file fs/xfs/xfs_log.c.  Return address = 0xc01eeae9
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965813
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965821
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965829
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965837
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965845
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965853
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965861
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965869
I/O error in filesystem ("sda2") meta-data dev sda2 block 0x6677b5       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda2,0x2) called from line 966 of file fs/xfs/xfs_log.c.  Return address = 0xc01eeae9
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965877
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965885
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965893
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965901
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965909
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 12965917
I/O error in filesystem ("sda2") meta-data dev sda2 block 0x6677f5       ("xlog_iodone") error 5 buf count 22016
xfs_force_shutdown(sda2,0x2) called from line 966 of file fs/xfs/xfs_log.c.  Return address = 0xc01eeae9
usb 3-3: USB disconnect, address 2
xfs_force_shutdown(sda2,0x1) called from line 353 of file fs/xfs/xfs_rw.c.  Return address = 0xc01eeae9
usb 3-3: new high speed USB device using address 3
scsi4 : SCSI emulation for USB Mass Storage devices
  Vendor: IBM-DJSA  Model: -210              Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdb: 19640880 512-byte hdwr sectors (10056 MB)
sdb: assuming drive cache: write through
 /dev/scsi/host4/bus0/target0/lun0: p1 p2
Attached scsi disk sdb at scsi4, channel 0, id 0, lun 0
USB Mass Storage device found at 3

--VbJkn9YxBvnuCH5J--
