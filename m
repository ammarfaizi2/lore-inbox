Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbULJEID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbULJEID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbULJEH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:07:56 -0500
Received: from ms-smtp-01-qfe0.socal.rr.com ([66.75.162.133]:29069 "EHLO
	ms-smtp-01-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S261692AbULJEGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:06:50 -0500
Message-ID: <41B920D5.2060106@clones.net>
Date: Thu, 09 Dec 2004 20:06:45 -0800
From: Glendon Gross <gross@clones.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rahul Karnik <deathdruid@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Burning CD's and 2.6.9
References: <5b64f7f04120908343c407f99@mail.gmail.com>	 <Pine.NEB.4.44.0412090839210.29667-100000@bsd.clones.net> <5b64f7f04120909005059fbb2@mail.gmail.com>
In-Reply-To: <5b64f7f04120909005059fbb2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using Slackware 10, with a custom kernel I recently built.
The boot messages mention udev:  Here is my dmesg output.  I have 
verbose SCSI debugging enabled....
I don't know how to read all the output, but it is nice to have it.  :)


Linux version 2.6.9clonix (root@optiplex) (gcc version 3.3.4) #5 SMP Thu 
Dec 9 03:43:00 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
192MB LOWMEM available.
On node 0 totalpages: 49152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45056 pages, LIFO batch:11
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI: Unable to locate RSDP
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux-2.6.9 ro root=301
No local APIC present or hardware disabled
Initializing CPU#0
CPU 0 irqstacks, hard=c061a000 soft=c0612000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 231.826 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 188484k/196608k available (3516k kernel code, 7696k reserved, 
1399k data, 252k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 454.65 BogoMIPS (lpj=227328)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0080f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0080f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0080f9f7 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium II (Klamath) stepping 04
per-CPU timeslice cutoff: 1465.54 usecs.
task migration cache decay timeout: 2 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfcc1e, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
i8k: unsupported model: OptiPlex GXa 233Mbr EM+
i8k: vendor=Dell Computer Corporation, model=OptiPlex GXa 233Mbr EM+, 
version=A06
i8k: unable to get SMM Dell signature
i8k: unable to get SMM BIOS version
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
pnp: the driver 'system' has been registered
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1102611249.802:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
vesafb: probe of vesafb0 failed with error -6
isapnp: Scanning for PnP cards...
isapnp: Card 'CS4236B'
isapnp: 1 Plug & Play card detected total
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440LX Chipset.
agpgart: Maximum main memory to use for agp memory: 150M
agpgart: AGP aperture is 64M @ 0xf0000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
pnp: the driver 'serial' has been registered
pnp: the driver 'parport_pc' has been registered
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 91366U4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: DVD-RW IDE1008, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
pnp: the driver 'ide' has been registered
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 26588016 sectors (13613 MB) w/2048KiB Cache, CHS=26377/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
PCI: Found IRQ 10 for device 0000:02:09.0
ahc_pci:2:9:0: hardware scb 64 bytes; kernel scb 52 bytes; ahc_dma 8 bytes
ahc_pci:2:9:0: Host Adapter Bios disabled.  Using default SCSI device 
parameters
scsi0: Waking DV thread
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7850 SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

Launching DV Thread
scsi0: Beginning Domain Validation
scsi0:A:0:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:0:0: Sending INQ
(scsi0:A:0:0): Saw Selection Timeout for SCB 0x3
scsi0:0:0: Command completed, status= 0x80000
scsi0:A:0:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:0:0: Failed DV inquiry, skipping
scsi0:A:1:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:1:0: Sending INQ
(scsi0:A:1:0): Saw Selection Timeout for SCB 0x2
scsi0:0:1: Command completed, status= 0x80000
scsi0:A:1:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:1:0: Failed DV inquiry, skipping
scsi0:A:2:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:2:0: Sending INQ
(scsi0:A:2:0): Saw Selection Timeout for SCB 0x3
scsi0:0:2: Command completed, status= 0x80000
scsi0:A:2:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:2:0: Failed DV inquiry, skipping
scsi0:A:3:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:3:0: Sending INQ
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 1, status= 0x0, 
cmd->result= 0x10000
scsi0:2606: Going from state 1 to state 2
scsi0:A:3:0: Sending INQ
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 2, status= 0x0, 
cmd->result= 0x10000
scsi0:2606: Going from state 2 to state 3
scsi0:A:3:0: Sending INQ
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 3, status= 0x0, 
cmd->result= 0x10000
scsi0:2653: Going from state 3 to state 4
scsi0:A:3:0: Sending TUR
(scsi0:A:3:0): SCB 3: requests Check Status
(scsi0:A:3:0): Sending Sense
Copied 32 bytes of sense data:
0x70 0x0 0x6 0x0 0x0 0x0 0x0 0x18 0x0 0x0 0x0 0x0 0x29 0x0 0x0 0x0
0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
scsi0:0:3: Command completed, status= 0x80a0002
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 4, status= 
0x10905, cmd->result= 0x80a0002
scsi0:2799: Going from state 4 to state 4
scsi0:A:3:0: Sending TUR
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 4, status= 0x0, 
cmd->result= 0x10000
scsi0:2790: Going from state 4 to state 0
scsi0:A:4:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:4:0: Sending INQ
(scsi0:A:4:0): Saw Selection Timeout for SCB 0x3
scsi0:0:4: Command completed, status= 0x80000
scsi0:A:4:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:4:0: Failed DV inquiry, skipping
scsi0:A:5:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:5:0: Sending INQ
(scsi0:A:5:0): Saw Selection Timeout for SCB 0x2
scsi0:0:5: Command completed, status= 0x80000
scsi0:A:5:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:5:0: Failed DV inquiry, skipping
scsi0:A:6:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:6:0: Sending INQ
(scsi0:A:6:0): Saw Selection Timeout for SCB 0x3
scsi0:0:6: Command completed, status= 0x80000
scsi0:A:6:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:6:0: Failed DV inquiry, skipping
(scsi0:A:0:0): Saw Selection Timeout for SCB 0x2
(scsi0:A:1:0): Saw Selection Timeout for SCB 0x3
(scsi0:A:2:0): Saw Selection Timeout for SCB 0x2
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0xc0
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0x1
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0x3
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0x1
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0x19
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0xf
scsi0:A:3:0: INITIATOR_MSG_OUT PHASEMIS in Message-in phase
scsi0:A:3:0: INITIATOR_MSG_IN byte 0x1
scsi0:A:3:0: INITIATOR_MSG_IN byte 0x3
scsi0:A:3:0: INITIATOR_MSG_IN byte 0x1
scsi0:A:3:0: INITIATOR_MSG_IN byte 0x19
scsi0:A:3:0: INITIATOR_MSG_IN byte 0xf
(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
scsi0:A:3:0: INITIATOR_MSG_IN PHASEMIS in Command phase
  Vendor: IBM       Model: DDRS-34560        Rev: S97B
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:3:0: Tagged Queuing enabled.  Depth 32
(scsi0:A:4:0): Saw Selection Timeout for SCB 0x3
(scsi0:A:5:0): Saw Selection Timeout for SCB 0x2
(scsi0:A:6:0): Saw Selection Timeout for SCB 0x3
SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
(scsi0:A:3:0): Handled Residual of 6 bytes
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 0
ieee1394: raw1394: /dev/raw1394 device initialized
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:11.0
uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:07.2: irq 11, io base 0000cce0
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: detected 2 ports
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82371AB/EB/MB PIIX4 USB
usb usb1: Manufacturer: Linux 2.6.9clonix uhci_hcd
usb usb1: SerialNumber: 0000:00:07.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
usbcore: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
usbcore: registered new driver midi
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 
07:17:53 2004 UTC).
pnp: the driver 'sscape' has been registered
usbcore: registered new driver snd-usb-audio
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 10922)
ip_conntrack version 2.1 (1536 buckets, 12288 max) - 308 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: journal-1153: found in header: first_unflushed_offset 
4969, last_flushed_trans_id 72030
ReiserFS: hda1: journal-1006: found valid transaction start offset 4969, 
len 11 id 72031
ReiserFS: hda1: journal-1206: Starting replay from offset 
309370789303145, trans_id 1
ReiserFS: hda1: journal-1037: journal_read_transaction, offset 4969, len 
11 mount_id 29
ReiserFS: hda1: journal-1095: setting journal start to offset 4982
ReiserFS: hda1: journal-1037: journal_read_transaction, offset 4982, len 
33 mount_id 29
ReiserFS: hda1: journal-1095: setting journal start to offset 5017
ReiserFS: hda1: journal-1037: journal_read_transaction, offset 5017, len 
4 mount_id 29
ReiserFS: hda1: journal-1095: setting journal start to offset 5023
ReiserFS: hda1: journal-1037: journal_read_transaction, offset 5023, len 
13 mount_id 29
ReiserFS: hda1: journal-1095: setting journal start to offset 5038
ReiserFS: hda1: journal-1037: journal_read_transaction, offset 5038, len 
1 mount_id 29
ReiserFS: hda1: journal-1095: setting journal start to offset 5041
ReiserFS: hda1: journal-1037: journal_read_transaction, offset 5041, len 
-1 mount_id -1
ReiserFS: hda1: journal-1146: journal_read_trans skipping because -1 is 
!= newest_mount_id 29
ReiserFS: hda1: journal-1299: Setting newest_mount_id to 30
ReiserFS: hda1: replayed 5 transactions in 0 seconds
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 252k freed
uhci_hcd 0000:00:07.2: suspend_hc
Adding 441776k swap on /dev/hda2.  Priority:-1 extents:1
Linux Kernel Card Services
  options:  [pci] [cardbus]
Intel ISA PCIC probe: not found.
Device 'i823650' does not have a release() function, it is broken and 
must be fixed.
Badness in device_release at drivers/base/core.c:85
 [<c01054fe>] dump_stack+0x1e/0x30
 [<c0253615>] kobject_cleanup+0x95/0xa0
 [<c0253a17>] kref_put+0x37/0xa0
 [<c0253651>] kobject_put+0x21/0x30
 [<cc952486>] init_i82365+0x1e6/0x1fc [i82365]
 [<c0135aca>] sys_init_module+0x1da/0x2b0
 [<c010461f>] syscall_call+0x7/0xb
Databook TCIC-2 PCMCIA probe: not found.
PCI: Found IRQ 11 for device 0000:00:11.0
PCI: Sharing IRQ 11 with 0000:00:07.2
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:11.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xcc80. Vers LK1.1.19
 ***INVALID CHECKSUM 003e*** eth0: Dropping NETIF_F_SG since no checksum 
feature.
nfs warning: mount version older than kernel
process `named' is using obsolete setsockopt SO_BSDCOMPAT





Rahul Karnik wrote:

>>Currently when I boot 2.6.9, no device called "hdc" shows up under /dev.
>>Since there is no MAKEDEV script, I'm stumped. Under 2.6.9,
>>I can use /dev/scd0.  This despite the fact that the drive is detected
>>as hdc in dmesg output.
>>    
>>
>
>Are you using devfs, static /dev or udev? What distribution?
>
>
>  
>

