Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWCaXNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWCaXNY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWCaXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:13:24 -0500
Received: from smtpout.mac.com ([17.250.248.73]:2009 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750915AbWCaXNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:13:22 -0500
In-Reply-To: <311601c90603311421g7241cb78m300aaaf423fae3ff@mail.gmail.com>
References: <20060328090211.4D6F34C04A@penelope.moffetthome.net> <7647B5D6-5E19-4614-A765-B28F9D7ED992@mac.com> <9BA602B9-F1DB-4374-A35F-F68F8CB50326@mac.com> <311601c90603311421g7241cb78m300aaaf423fae3ff@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <27E00526-ED66-466E-ADB5-5A1DA4F090A9@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
Date: Fri, 31 Mar 2006 18:13:10 -0500
To: "Eric D. Mudama" <edmudama@gmail.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 31, 2006, at 17:21:16, Eric D. Mudama wrote:
> can you please post your dmesg?

Dmesg below.  Thanks for taking a look!

Cheers,
Kyle Moffett

Total memory = 832MB; using 2048kB for hash table (at c0400000)
Linux version 2.6.15-1-powerpc (Debian 2.6.15-3) (horms@verge.net.au)  
(gcc version 4.0.3 20060115 (prerelease) (Debian 4.0.2-7)) #2 Thu Jan  
19 03:51:42 UTC 2006
Found UniNorth memory controller & host bridge, revision: 7
Mapped at 0xfdf00000
Found a Keylargo mac-io controller, rev: 2, mapped at 0xfde80000
Processor NAP mode on idle enabled.
PowerMac motherboard: PowerMac G4 AGP Graphics
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->1
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver 2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=366, gen1=367
nvram: Active bank is: 1
nvram: OF partition at 0x210
nvram: XP partition at 0x1220
nvram: NR partition at 0x1320
On node 0 totalpages: 212992
   DMA zone: 196608 pages, LIFO batch:31
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 0 pages, LIFO batch:0
   HighMem zone: 16384 pages, LIFO batch:3
Built 1 zonelists
Kernel command line: root=/dev/mapper/raid-root ro
PowerMac using OpenPIC irq controller at 0x80040000
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc62e000
OpenPIC timer frequency is 4.166666 MHz
PID hash table entries: 4096 (order: 12, 65536 bytes)
GMT Delta read from XPRAM: 0 minutes, DST: off
time_init: decrementer frequency = 24.907667 MHz
Console: colour dummy device 80x25
serial8250_console_init: nothing to do on PowerMac
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 835136k available (2172k kernel code, 944k data, 172k init,  
65536k highmem)
AGP special page: 0xeffff000
Calibrating delay loop... 794.62 BogoMIPS (lpj=397312)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
device-tree: property "l2-cache" name conflicts with node in /cpus/ 
PowerPC,G4@0
checking if image is initramfs... it is
Freeing initrd memory: 3260k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Enabling device 0001:11:02.0 (0004 -> 0007)
Registering openpic with sysfs...
Thermal assist unit using timers, shrink_timer: 2000 jiffies
audit: initializing netlink socket (disabled)
audit(1141624084.107:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
aty128fb: Invalid ROM signature 1111 should  be 0xaa55
aty128fb: BIOS not located, guessing timings.
aty128fb: Rage128 PF PRO AGP [chip rev 0x1] 16M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 128x48
fb0: ATY Rage128 frame buffer device on Rage128 PF PRO AGP
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
serial8250_init: nothing to do on PowerMac
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Serial port
ttyS1 at MMIO 0x80013000 (irq = 50) is a Z85c30 ESCC - Serial port
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
MacIO PCI driver attached to Keylargo chipset
input: Macintosh mouse button emulation as /class/input/input0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with  
idebus=xx
adb: starting probe task...
adb: finished probe task...
ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2, irq 19
Probing IDE interface ide0...
hda: ST380011A, ATA DISK drive
hda: Enabling Ultra DMA 4
ide0 at 0xf100e000-0xf100e007,0xf100e160 on irq 19
ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 20
Probing IDE interface ide1...
hdc: CD-ROM Drive/F5A, ATAPI CD/DVD-ROM drive
hdc: Disabling (U)DMA for CD-ROM Drive/F5A (blacklisted)
ide1 at 0xf1016000-0xf1016007,0xf1016160 on irq 20
ide2: Found Apple KeyLargo ATA-3 controller, bus ID 1, irq 21
Probing IDE interface ide2...
mice: PS/2 mouse device common for all mice
Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 172k init
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected Apple UniNorth chipset
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
PDC20268: IDE controller at PCI slot 0001:11:02.0
PDC20268: chipset revision 2
PDC20268: ROM enabled at 0x80090000
PDC20268: 100%% native mode on irq 52
     ide3: BM-DMA at 0x1400-0x1407, BIOS settings: hdg:pio, hdh:pio
     ide4: BM-DMA at 0x1408-0x140f, BIOS settings: hdi:pio, hdj:pio
Probing IDE interface ide3...
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver  
(PCI)
hdg: Maxtor 6Y080P0, ATA DISK drive
ide3 at 0x1440-0x1447,0x1432 on irq 52
Probing IDE interface ide4...
hdi: SAMSUNG SP0822N, ATA DISK drive
ide4 at 0x1420-0x1427,0x1412 on irq 52
r8169 Gigabit Ethernet driver 2.2LK loaded
PCI: Enabling device 0001:11:03.0 (0014 -> 0017)
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xf1060000, 00:08:54:d1:af:f9, IRQ 53
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
PCI: Enabling device 0001:11:08.0 (0000 -> 0002)
ohci_hcd 0001:11:08.0: OHCI Host Controller
ohci_hcd 0001:11:08.0: new USB bus registered, assigned bus number 1
ohci_hcd 0001:11:08.0: irq 27, io mem 0x80083000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PHY ID: 406212, addr: 0
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:30:65:96:77:a4
eth0: Found BCM5201 PHY
PCI: Enabling device 0001:11:09.0 (0000 -> 0002)
ohci_hcd 0001:11:09.0: OHCI Host Controller
ohci_hcd 0001:11:09.0: new USB bus registered, assigned bus number 2
ohci_hcd 0001:11:09.0: irq 28, io mem 0x80082000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using ohci_hcd and address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 3 ports detected
usb 2-1.1: new full speed USB device using ohci_hcd and address 3
usbcore: registered new driver hiddev
eth_pub: Link is up at 100 Mbps, full-duplex.
drivers/usb/input/hid-core.c: timeout initializing reports

input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/ 
input1
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB  
Keyboard] on usb-0001:11:09.0-1.1
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/ 
input2
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB  
Keyboard] on usb-0001:11:09.0-1.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver yealink
drivers/usb/input/yealink.c: Yealink phone driver:yld-20050816
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63,  
UDMA(66)
hda: cache flushes supported
hda: [mac] hda1 hda2 hda3 hda4 hda5
hdg: max request size: 128KiB
hdg: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63,  
UDMA(100)
hdg: cache flushes supported
hdg:hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
PDC202XX: Primary channel reset.
ide3: reset: success
[mac] hdg1 hdg2 hdg3 hdg4 hdg5
hdi: max request size: 1024KiB
hdi: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63,  
UDMA(33)
hdi: cache flushes supported
hdi: [mac] hdi1 hdi2 hdi3 hdi4 hdi5
hdc: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
md: raid1 personality registered as nr 3
raid5: measuring checksumming speed
    8regs     :   488.000 MB/sec
    8regs_prefetch:   408.000 MB/sec
    32regs    :   448.000 MB/sec
    32regs_prefetch:   392.000 MB/sec
raid5: using function: 8regs (488.000 MB/sec)
md: raid5 personality registered as nr 4
md: md0 stopped.
md: bind<hda3>
md: bind<hdi3>
md: bind<hdg3>
raid1: raid set md0 active with 3 out of 3 mirrors
md: md1 stopped.
md: bind<hda4>
md: bind<hdi4>
md: bind<hdg4>
raid5: device hdg4 operational as raid disk 0
raid5: device hdi4 operational as raid disk 2
raid5: device hda4 operational as raid disk 1
raid5: allocated 3168kB for md1
raid5: raid level 5 set md1 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
--- rd:3 wd:3 fd:0
disk 0, o:1, dev:hdg4
disk 1, o:1, dev:hda4
disk 2, o:1, dev:hdi4
md: md2 stopped.
md: bind<hda5>
md: bind<hdi5>
md: bind<hdg5>
raid5: device hdg5 operational as raid disk 0
raid5: device hdi5 operational as raid disk 2
raid5: device hda5 operational as raid disk 1
raid5: allocated 3168kB for md2
raid5: raid level 5 set md2 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
--- rd:3 wd:3 fd:0
disk 0, o:1, dev:hdg5
disk 1, o:1, dev:hda5
disk 2, o:1, dev:hdi5
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
PDC202XX: Primary channel reset.
ide3: reset: success
Adding 1048440k swap on /dev/md1.  Priority:-1 extents:1 across:1048440k
EXT3-fs warning: maximal mount count reached, running e2fsck is  
recommended
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
input: PowerMac Beep as /class/input/input3
NET: Registered protocol family 15
eth_pub: Link is up at 100 Mbps, full-duplex.
eth_pub: Pause is disabled
r8169: eth_lan: link up
ip_tables: (C) 2000-2002 Netfilter core team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (6656 buckets, 53248 max) - 232 bytes per  
conntrack
ClusterIP Version 0.8 loaded successfully
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http:// 
snowman.net/projects/ipt_recent/
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery  
directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
Initializing IPsec netlink socket
eth_pub: no IPv6 routers present
eth_lan: no IPv6 routers present
eth_pub: Link is up at 100 Mbps, full-duplex.
eth_pub: Pause is disabled
tun_624: Disabled Privacy Extensions
GRE over IPv4 tunneling driver
hdi: dma_timer_expiry: dma status == 0x21
hdi: DMA timeout error
hdi: dma timeout error: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdi: DMA disabled
PDC202XX: Secondary channel reset.
ide4: reset: success
[... ad nauseum ...]


