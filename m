Return-Path: <linux-kernel-owner+w=401wt.eu-S1750968AbXACRT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbXACRT5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbXACRT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:19:57 -0500
Received: from weequay.is.scarlet.be ([193.74.71.24]:50871 "EHLO
	weequay.is.scarlet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXACRT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:19:56 -0500
Message-ID: <459BE5AC.70703@scarlet.be>
Date: Wed, 03 Jan 2007 17:19:40 +0000
From: Joel Soete <soete.joel@scarlet.be>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Alan Cox <alan@redhat.com>, Ioan Ionita <opslynx@gmail.com>,
       Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: 2.6.19-rc5 libata PATA ATAPI CDROM SiS 5513 NOT WORKING
References: <df47b87a0611161522o3ad007f5i8804c876c50e591c@mail.gmail.com> <20061116235048.3cd91beb@localhost.localdomain> <df47b87a0611161730p70e1dd41iad7d27a0bf9283ff@mail.gmail.com> <df47b87a0611161734h818fc4dneaad5eeaa7e3c392@mail.gmail.com> <20061117100559.GA10275@devserv.devel.redhat.com> <459286C2.7080705@scarlet.be> <45943C15.4010506@scarlet.be> <459B31AE.709@gmail.com>
In-Reply-To: <459B31AE.709@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030800050400030507040505"
X-DCC-scarlet.be-Metrics: weequay 2020; Body=7 Fuz1=7 Fuz2=7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030800050400030507040505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Tejun,

Tejun Heo wrote:
> Joel Soete wrote:
>> Hello Alan, Jeff,
>>
>> Reading a paper on this new libata, I just want to try but failled yet
>> for what said this thread "ATAPI CDROM" ;_(.
>>
>> I first test the latest stable 2.6.19.1 without luck, so I also want to
>> try latest 2.6.20-rc2 unfortunately without more success.
> 
> I'm attaching two patches.  One against 2.6.19 the other against
> 2.6.20-rc3.  Both have about the same effect.  Please apply and report
> what happens and full dmesg.
> 
> Thanks and happy new year.
> 
Happy new year too ;-)

Because of lack of time I only test your patch against 2.6.20-rc3.

Unfortunately it doesn't help yet, sorry (i would very like to be of more help).

I here attache the full dmesg of my i386 boxe.

Thanks again,
	Joel



--------------030800050400030507040505
Content-Type: text/plain;
 name="DmesgPata2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DmesgPata2.txt"

 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000000fef0000 end: 000000000fff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000fff0000 size: 0000000000003000 end: 000000000fff3000 type: 4
copy_e820_map() start: 000000000fff3000 size: 000000000000d000 end: 0000000010000000 type: 3
copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
Entering add_active_range(0, 0, 65520) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->    65520
early_node_map[1] active PFN ranges
    0:        0 ->    65520
On node 0 totalpages: 65520
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 479 pages used for memmap
  Normal zone: 60945 pages, LIFO batch:15
DMI 2.3 present.
Allocating PCI resources starting at 20000000 (gap: 10000000:efff0000)
Detected 551.291 MHz processor.
Built 1 zonelists.  Total pages: 65009
Kernel command line: -s libata.atapi_enabled=1 root=/dev/md2 profile=2
kernel profiling enabled (shift: 2)
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 252896k/262080k available (2590k kernel code, 8720k reserved, 826k data, 276k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffbc000 - 0xfffff000   ( 268 kB)
    vmalloc : 0xd0800000 - 0xfffba000   ( 759 MB)
    lowmem  : 0xc0000000 - 0xcfff0000   ( 255 MB)
      .init : 0xc045a000 - 0xc049f000   ( 276 kB)
      .data : 0xc038781d - 0xc0456250   ( 826 kB)
      .text : 0xc0100000 - 0xc038781d   (2590 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1103.39 BogoMIPS (lpj=2206781)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel Pentium III (Katmai) stepping 03
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb240, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 4000-403f claimed by PIIX4 ACPI
PCI quirk: region 5000-500f claimed by PIIX4 SMB
Boot video device is 0000:01:00.0
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: e4000000-e7ffffff
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
Machine check exception polling timer started.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Installing v9fs 9P2000 file system support
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
PCI: setting IRQ 9 as level-triggered
PCI: Found IRQ 9 for device 0000:00:0b.0
hp100: Busmaster mode enabled.
hp100: at 0xe000, IRQ 9, PCI bus, 32k SRAM (rx/tx 75%).
hp100: Adapter is attached to 10Mb/s network (10baseT).
PCI: setting IRQ 10 as level-triggered
PCI: Found IRQ 10 for device 0000:00:0c.0
PCI: Sharing IRQ 10 with 0000:00:07.2
hp100: Busmaster mode enabled.
hp100: at 0xe400, IRQ 10, PCI bus, 32k SRAM (rx/tx 75%).
hp100: Warning! Link down.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
PCI: setting IRQ 11 as level-triggered
PCI: Found IRQ 11 for device 0000:00:09.0
sym0: <875> rev 0x14 at pci 0000:00:09.0 irq 11
sym0: Symbios NVRAM, ID 7, Fast-20, HVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.3
scsi 0:0:6:0: Direct-Access     SEAGATE  ST336605LSUN36G  0238 PQ: 0 ANSI: 3
 target0:0:6: tagged command queuing enabled, command queue depth 16.
 target0:0:6: Beginning Domain Validation
 target0:0:6: asynchronous
 target0:0:6: wide asynchronous
 target0:0:6: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
PCI: setting IRQ 5 as level-triggered
PCI: Found IRQ 5 for device 0000:00:09.1
PCI: Sharing IRQ 5 with 0000:00:0a.0
sym1: <875> rev 0x14 at pci 0000:00:09.1 irq 5
sym1: Symbios NVRAM, ID 7, Fast-20, HVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.3
PCI: Found IRQ 5 for device 0000:00:0a.0
PCI: Sharing IRQ 5 with 0000:00:09.1
sym2: <875> rev 0x26 at pci 0000:00:0a.0 irq 5
sym2: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym2: open drain IRQ line driver, using on-chip SRAM
sym2: using LOAD/STORE-based firmware.
sym2: SCSI BUS has been reset.
scsi2 : sym-2.2.3
 target2:0:0: Multiple LUNs disabled in NVRAM
scsi 2:0:0:0: Direct-Access     QUANTUM  ATLAS_V_18_WLS   0230 PQ: 0 ANSI: 3
 target2:0:0: tagged command queuing enabled, command queue depth 16.
 target2:0:0: Beginning Domain Validation
 target2:0:0: asynchronous
 target2:0:0: wide asynchronous
 target2:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
 target2:0:0: Domain Validation skipping write tests
 target2:0:0: Ending Domain Validation
 target2:0:1: Multiple LUNs disabled in NVRAM
 target2:0:2: Multiple LUNs disabled in NVRAM
 target2:0:3: Multiple LUNs disabled in NVRAM
 target2:0:4: Multiple LUNs disabled in NVRAM
 target2:0:5: Multiple LUNs disabled in NVRAM
 target2:0:6: Multiple LUNs disabled in NVRAM
 target2:0:8: Multiple LUNs disabled in NVRAM
 target2:0:9: Multiple LUNs disabled in NVRAM
 target2:0:10: Multiple LUNs disabled in NVRAM
 target2:0:11: Multiple LUNs disabled in NVRAM
 target2:0:12: Multiple LUNs disabled in NVRAM
 target2:0:13: Multiple LUNs disabled in NVRAM
 target2:0:14: Multiple LUNs disabled in NVRAM
 target2:0:15: Multiple LUNs disabled in NVRAM
st: Version 20061107, fixed bufsize 32768, s/g segs 256
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
sda: Write Protect is off
sda: Mode Sense: d3 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
sda: Write Protect is off
sda: Mode Sense: d3 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:6:0: Attached scsi disk sda
SCSI device sdb: 35861388 512-byte hdwr sectors (18361 MB)
sdb: Write Protect is off
sdb: Mode Sense: e3 00 10 08
SCSI device sdb: write cache: enabled, read cache: enabled, supports DPO and FUA
SCSI device sdb: 35861388 512-byte hdwr sectors (18361 MB)
sdb: Write Protect is off
sdb: Mode Sense: e3 00 10 08
SCSI device sdb: write cache: enabled, read cache: enabled, supports DPO and FUA
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 >
sd 2:0:0:0: Attached scsi disk sdb
sd 0:0:6:0: Attached scsi generic sg0 type 0
sd 2:0:0:0: Attached scsi generic sg1 type 0
ata_piix 0000:00:07.1: version 2.00ac7
ata1: PATA max UDMA/33:PIO4 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/33:PIO4 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi3 : ata_piix
ata1.00: ATA-4, max UDMA/66:PIO4, 29336832 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATAPI, max MWDMA1:PIO3
ata1.00: configured for UDMA/33:PIO0
ata1.01: qc timeout (cmd 0xa1)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.01: revalidation failed (errno=-5)
ata1.01: limiting speed to PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.01: qc timeout (cmd 0xa1)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.01: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.01: qc timeout (cmd 0xa1)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.01: revalidation failed (errno=-5)
ata1.01: disabled
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/25:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.00: configured for UDMA/25:PIO0
scsi4 : ata_piix
scsi 3:0:0:0: Direct-Access     ATA      QUANTUM FIREBALL A03. PQ: 0 ANSI: 5
SCSI device sdc: 29336832 512-byte hdwr sectors (15020 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdc: 29336832 512-byte hdwr sectors (15020 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1 sdc2 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 sdc12 sdc13 sdc14 sdc15 >
sd 3:0:0:0: Attached scsi disk sdc
sd 3:0:0:0: Attached scsi generic sg2 type 0
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v3.0
PCI: Found IRQ 10 for device 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:0c.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 10, io base 0x0000d000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
/usr/src/linux-2.6.20-rc3/drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbhid
/usr/src/linux-2.6.20-rc3/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
md: raid1 personality registered for level 1
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
EISA: Probing bus 0 at eisa.0
oprofile: using timer interrupt.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
NET: Registered protocol family 17
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse as /class/input/input1
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sda8 ...
md:  adding sda8 ...
md: sda7 has different UUID to sda8
md: sda6 has different UUID to sda8
md: sda5 has different UUID to sda8
md: sda3 has different UUID to sda8
md: sda2 has different UUID to sda8
md: sda1 has different UUID to sda8
md: created md6
md: bind<sda8>
md: running: <sda8>
raid1: raid set md6 active with 1 out of 2 mirrors
md: considering sda7 ...
md:  adding sda7 ...
md: sda6 has different UUID to sda7
md: sda5 has different UUID to sda7
md: sda3 has different UUID to sda7
md: sda2 has different UUID to sda7
md: sda1 has different UUID to sda7
md: created md5
md: bind<sda7>
md: running: <sda7>
raid1: raid set md5 active with 1 out of 2 mirrors
md: considering sda6 ...
md:  adding sda6 ...
md: sda5 has different UUID to sda6
md: sda3 has different UUID to sda6
md: sda2 has different UUID to sda6
md: sda1 has different UUID to sda6
md: created md4
md: bind<sda6>
md: running: <sda6>
raid1: raid set md4 active with 1 out of 2 mirrors
md: considering sda5 ...
md:  adding sda5 ...
md: sda3 has different UUID to sda5
md: sda2 has different UUID to sda5
md: sda1 has different UUID to sda5
md: created md3
md: bind<sda5>
md: running: <sda5>
raid1: raid set md3 active with 1 out of 2 mirrors
md: considering sda3 ...
md:  adding sda3 ...
md: sda2 has different UUID to sda3
md: sda1 has different UUID to sda3
md: created md2
md: bind<sda3>
md: running: <sda3>
raid1: raid set md2 active with 1 out of 2 mirrors
md: considering sda2 ...
md:  adding sda2 ...
md: sda1 has different UUID to sda2
md: created md1
md: bind<sda2>
md: running: <sda2>
raid1: raid set md1 active with 1 out of 2 mirrors
md: considering sda1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: running: <sda1>
raid1: raid set md0 active with 1 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 276k freed
Adding 255928k swap on /dev/md1.  Priority:-1 extents:1 across:255928k
EXT3 FS on md2, internal journal

--------------030800050400030507040505--
