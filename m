Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVHMAiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVHMAiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 20:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVHMAiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 20:38:54 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:47593 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751312AbVHMAix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 20:38:53 -0400
Message-ID: <13260733.1123893531669.JavaMail.ngmail@webmail-01.arcor-online.net>
Date: Sat, 13 Aug 2005 02:38:51 +0200 (CEST)
From: thomas.mey3r@arcor.de
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6: kernel option acpi=off
In-Reply-To: <14604408.1123706059756.JavaMail.ngmail@webmail-08.arcor-online.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <14604408.1123706059756.JavaMail.ngmail@webmail-08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 84.58.96.243
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Some strange behaviour in kernel log time. see:

Aug 12 07:51:28 [kernel] [17179569.184000] Linux version 2.6.13-rc6 (root@hotzenplotz) (gcc version 3.3.5 (Gentoo Linux 3.3.5-r1, ssp-3.3.2-3, pie-8.7.7.1)) #13 Thu Aug 11 19:45:12 CEST 2005
Aug 12 07:51:28 [kernel] [17179569.184000] BIOS-provided physical RAM map:
Aug 12 07:51:28 [kernel] [17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Aug 12 07:51:28 [kernel] [17179569.184000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Aug 12 07:51:28 [kernel] [17179569.184000]  BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
Aug 12 07:51:28 [kernel] [17179569.184000]  BIOS-e820: 0000000000100000 - 000000002bef0000 (usable)
Aug 12 07:51:28 [kernel] [17179569.184000]  BIOS-e820: 000000002bef0000 - 000000002befb000 (ACPI data)
Aug 12 07:51:28 [kernel] [17179569.184000]  BIOS-e820: 000000002befb000 - 000000002bf00000 (ACPI NVS)
Aug 12 07:51:28 [kernel] [17179569.184000]  BIOS-e820: 000000002bf00000 - 0000000030000000 (reserved)
Aug 12 07:51:28 [kernel] [17179569.184000]  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
Aug 12 07:51:28 [kernel] [17179569.184000] 702MB LOWMEM available.
Aug 12 07:51:28 [kernel] [17179569.184000] DMI 2.3 present.
Aug 12 07:51:28 [kernel] [17179569.184000] Allocating PCI resources starting at 30000000 (gap: 30000000:cffe0000)
Aug 12 07:51:28 [kernel] [17179569.184000] Built 1 zonelists
Aug 12 07:51:28 [kernel] [17179569.184000] Kernel command line: root=/dev/hda2 resume=/dev/hda4 netconsole=@192.168.0.10/eth0,@192.168.0.1/00:48:54:63:d7:7f kgdboe=@192.168.0.10/eth0,@192.168.0.1/00:48:54:63:d7:7f log_buf_len=4M kstack=300 acpi=off
Aug 12 07:51:28 [kernel] [17179569.184000] netconsole: local port 6665
Aug 12 07:51:28 [kernel] [17179569.184000] netconsole: local IP 192.168.0.10
Aug 12 07:51:28 [kernel] [17179569.184000] netconsole: interface eth0
Aug 12 07:51:28 [kernel] [17179569.184000] netconsole: remote port 6666
Aug 12 07:51:28 [kernel] [17179569.184000] netconsole: remote IP 192.168.0.1
Aug 12 07:51:28 [kernel] [17179569.184000] netconsole: remote ethernet address 00:48:54:63:d7:7f
Aug 12 07:51:28 [kernel] [17179569.184000] log_buf_len: 4194304
Aug 12 07:51:28 [kernel] [17179569.184000] Local APIC disabled by BIOS -- you can enable it with "lapic"
Aug 12 07:51:28 [kernel] [17179569.184000] Initializing CPU#0
Aug 12 07:51:28 [kernel] [17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
Aug 12 07:51:28 [kernel] [    0.000000] Detected 796.251 MHz processor.
Aug 12 07:51:28 [kernel] [   31.364059] Using tsc for high-res timesource
Aug 12 07:51:28 [kernel] [   31.365312] Console: colour VGA+ 80x25
Aug 12 07:51:28 [kernel] [   31.367438] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 12 07:51:28 [kernel] [   31.368836] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 12 07:51:28 [kernel] [   31.405405] Memory: 704288k/719808k available (3106k kernel code, 15024k reserved, 853k data, 212k init, 0k highmem)
Aug 12 07:51:28 [kernel] [   31.405457] Checking if this processor honours the WP bit even in supervisor mode... Ok.
Aug 12 07:51:28 [kernel] [   31.485360] Calibrating delay using timer specific routine.. 1595.39 BogoMIPS (lpj=3190788)
Aug 12 07:51:28 [kernel] [   31.485467] Mount-cache hash table entries: 512
Aug 12 07:51:28 [kernel] [   31.485730] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 12 07:51:28 [kernel] [   31.485763] CPU: L2 Cache: 512K (64 bytes/line)
Aug 12 07:51:28 [kernel] [   31.485801] Intel machine check architecture supported.
Aug 12 07:51:28 [kernel] [   31.485829] Intel machine check reporting enabled on CPU#0.
Aug 12 07:51:28 [kernel] [   31.485871] mtrr: v2.0 (20020519)
Aug 12 07:51:28 [kernel] [   31.485897] CPU: AMD Mobile AMD Athlon(tm) XP 2400+ stepping 00
Aug 12 07:51:28 [kernel] [   31.485936] Enabling fast FPU save and restore... done.
Aug 12 07:51:28 [kernel] [   31.485965] Enabling unmasked SIMD FPU exception support... done.
Aug 12 07:51:28 [kernel] [   31.485998] Checking 'hlt' instruction... OK.
Aug 12 07:51:28 [kernel] [   31.502355] NET: Registered protocol family 16
Aug 12 07:51:28 [kernel] [   31.502569] PCI: PCI BIOS revision 2.10 entry at 0xfd65c, last bus=1
Aug 12 07:51:28 [kernel] [   31.502608] PCI: Using configuration type 1
Aug 12 07:51:28 [kernel] [   31.503346] ACPI: Subsystem revision 20050408
Aug 12 07:51:28 [kernel] [   31.503373] ACPI: Interpreter disabled.
Aug 12 07:51:28 [kernel] [   31.503403] Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 12 07:51:28 [rc-scripts] ACPI support has not been compiled into the kernel
Aug 12 07:51:28 [kernel] [   31.503466] PnPBIOS: Scanning system for PnP BIOS support...
Aug 12 07:51:28 [kernel] [   31.503503] PnPBIOS: Found PnP BIOS installation structure at 0xc00f68d0
Aug 12 07:51:28 [kernel] [   31.503535] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb5cd, dseg 0x400
Aug 12 07:51:28 [kernel] [   31.508826] PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
Aug 12 07:51:28 [kernel] [   31.509125] SCSI subsystem initialized
Aug 12 07:51:28 [kernel] [   31.509235] usbcore: registered new driver usbfs
Aug 12 07:51:28 [kernel] [   31.509313] usbcore: registered new driver hub
Aug 12 07:51:28 [kernel] [   31.509465] PCI: Probing PCI hardware
Aug 12 07:51:28 [kernel] [   31.509494] PCI: Probing PCI hardware (bus 00)
Aug 12 07:51:28 [kernel] [   31.511469] PCI: Using IRQ router VIA [1106/3177] at 0000:00:11.0
Aug 12 07:51:28 [kernel] [   31.511515] PCI: IRQ 0 for device 0000:00:07.0 doesn't match PIRQ mask - try pci=usepirqmask
Aug 12 07:51:28 [kernel] [   31.511563] PCI: Found IRQ 5 for device 0000:00:07.0
Aug 12 07:51:28 [kernel] [   31.511594] PCI: Sharing IRQ 5 with 0000:00:08.0
Aug 12 07:51:28 [kernel] [   31.511622] PCI: Sharing IRQ 5 with 0000:00:10.1
Aug 12 07:51:28 [kernel] [   31.511670] PCI: IRQ 0 for device 0000:00:11.1 doesn't match PIRQ mask - try pci=usepirqmask
Aug 12 07:51:28 [kernel] [   31.511715] PCI: Found IRQ 4 for device 0000:00:11.1
Aug 12 07:51:28 [kernel] [   31.511748] PCI: Sharing IRQ 4 with 0000:00:10.0
Aug 12 07:51:28 [kernel] [   31.511785] PCI: Sharing IRQ 4 with 0000:00:12.0
Aug 12 07:51:28 [kernel] [   31.514665] PCI: Failed to allocate mem resource #6:10000@f4000000 for 0000:01:00.0
Aug 12 07:51:28 [kernel] [   31.514709] PCI: Bridge: 0000:00:01.0
Aug 12 07:51:28 [kernel] [   31.514733]   IO window: disabled.
Aug 12 07:51:28 [kernel] [   31.514760]   MEM window: d1000000-d1ffffff
Aug 12 07:51:28 [kernel] [   31.514787]   PREFETCH window: f0000000-f3ffffff
Aug 12 07:51:28 [kernel] [   31.514816] PCI: Bus 2, cardbus bridge: 0000:00:07.0
Aug 12 07:51:28 [kernel] [   31.514843]   IO window: 00004000-00004fff
Aug 12 07:51:28 [kernel] [   31.514870]   IO window: 00005000-00005fff
Aug 12 07:51:28 [kernel] [   31.514897]   PREFETCH window: 30000000-31ffffff
Aug 12 07:51:28 [kernel] [   31.514925]   MEM window: 32000000-33ffffff
Aug 12 07:51:28 [kernel] [   31.514992] PCI: Found IRQ 5 for device 0000:00:07.0
Aug 12 07:51:28 [kernel] [   31.515024] PCI: Sharing IRQ 5 with 0000:00:08.0
Aug 12 07:51:28 [kernel] [   31.515052] PCI: Sharing IRQ 5 with 0000:00:10.1
Aug 12 07:51:28 [kernel] [   31.515203] pnp: 00:09: ioport range 0xfe00-0xfe01 has been reserved
Aug 12 07:51:28 [kernel] [   31.515243] pnp: 00:0c: ioport range 0x4d0-0x4d1 has been reserved
Aug 12 07:51:28 [kernel] [   31.515274] pnp: 00:0c: ioport range 0x4000-0x407f has been reserved
Aug 12 07:51:28 [kernel] [   31.515304] pnp: 00:0c: ioport range 0x8100-0x810f has been reserved
Aug 12 07:51:28 [kernel] [   31.515793] Machine check exception polling timer started.
Aug 12 07:51:28 [kernel] [   31.517772] VFS: Disk quotas dquot_6.5.1
Aug 12 07:51:28 [kernel] [   31.517846] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Aug 12 07:51:28 [kernel] [   31.518006] Initializing Cryptographic API
Aug 12 07:51:28 [kernel] [   31.518279] isapnp: Scanning for PnP cards...
Aug 12 07:51:28 [kernel] [   31.872973] isapnp: No Plug & Play device found
Aug 12 07:51:28 [kernel] [   31.875954] lp: driver loaded but no devices found
Aug 12 07:51:28 [kernel] [   31.876071] Real Time Clock Driver v1.12
Aug 12 07:51:28 [kernel] [   31.876145] Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Aug 12 07:51:28 [kernel] [   31.876194] Linux agpgart interface v0.101 (c) Dave Jones
Aug 12 07:51:28 [kernel] [   31.876276] agpgart: Detected VIA KM400/KM400A chipset
Aug 12 07:51:28 [kernel] [   31.898823] agpgart: AGP aperture is 256M @ 0xe0000000
Aug 12 07:51:28 [kernel] [   31.899108] PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
Aug 12 07:51:28 [kernel] [   31.904309] serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 12 07:51:28 [kernel] [   31.904667] serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 12 07:51:28 [kernel] [   31.905091] parport: PnPBIOS parport detected.
Aug 12 07:51:28 [kernel] [   31.905161] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
Aug 12 07:51:28 [kernel] [   32.001366] lp0: using parport0 (interrupt-driven).
Aug 12 07:51:28 [kernel] [   32.001396] lp0: console ready
Aug 12 07:51:28 [kernel] [   32.001547] io scheduler noop registered
Aug 12 07:51:28 [kernel] [   32.001598] io scheduler anticipatory registered
Aug 12 07:51:28 [kernel] [   32.001631] io scheduler deadline registered
Aug 12 07:51:28 [kernel] [   32.001674] io scheduler cfq registered
Aug 12 07:51:28 [kernel] [   32.001902] RAMDISK driver initialized: 4 RAM disks of 4096K size 1024 blocksize
Aug 12 07:51:28 [kernel] [   32.002048] NET3 PLIP version 2.4-parport gniibe@mri.co.jp
Aug 12 07:51:28 [kernel] [   32.002079] plip0: Parallel port at 0x378, using IRQ 7.
Aug 12 07:51:28 [kernel] [   32.002158] via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
Aug 12 07:51:28 [kernel] [   32.002303] PCI: Sharing IRQ 4 with 0000:00:11.1
Aug 12 07:51:28 [kernel] [   32.006391] eth0: VIA Rhine II at 0x11800, 00:c0:9f:2b:79:76, IRQ 4.
Aug 12 07:51:28 [kernel] [   32.007160] eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
Aug 12 07:51:28 [kernel] [   32.007296] netconsole: device eth0 not up yet, forcing it
Aug 12 07:51:28 [kernel] [   32.007955] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 12 07:51:28 [kernel] [   32.008008] netconsole: carrier detect appears untrustworthy, waiting 4 seconds
Aug 12 07:51:28 [kernel] [   36.013929] netconsole: network logging started
Aug 12 07:51:28 [kernel] [   36.013972] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 12 07:51:28 [kernel] [   36.014031] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 12 07:51:28 [kernel] [   36.014167] VP_IDE: IDE controller at PCI slot 0000:00:11.1
Aug 12 07:51:28 [kernel] [   36.014232] PCI: Found IRQ 4 for device 0000:00:11.1
Aug 12 07:51:28 [kernel] [   36.014269] PCI: Sharing IRQ 4 with 0000:00:10.0
Aug 12 07:51:28 [kernel] [   36.014335] PCI: Sharing IRQ 4 with 0000:00:12.0
Aug 12 07:51:28 [kernel] [   36.014367] PCI: Via IRQ fixup for 0000:00:11.1, from 0 to 4
Aug 12 07:51:28 [kernel] [   36.014445] VP_IDE: chipset revision 6
Aug 12 07:51:28 [kernel] [   36.014473] VP_IDE: not 100% native mode: will probe irqs later
Aug 12 07:51:28 [kernel] [   36.014540] VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Aug 12 07:51:28 [kernel] [   36.014598]     ide0: BM-DMA at 0x1c60-0x1c67, BIOS settings: hda:DMA, hdb:pio
Aug 12 07:51:28 [kernel] [   36.014707]     ide1: BM-DMA at 0x1c68-0x1c6f, BIOS settings: hdc:DMA, hdd:pio
Aug 12 07:51:28 [kernel] [   36.428653] hda: IC25N030ATMR04-0, ATA DISK drive
Aug 12 07:51:28 [kernel] [   37.100847] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 12 07:51:28 [kernel] [   37.964400] hdc: Slimtype COMBO LSC-24082K, ATAPI CD/DVD-ROM drive
Aug 12 07:51:28 [kernel] [   38.636391] ide1 at 0x170-0x177,0x376 on irq 15
Aug 12 07:51:28 [kernel] [   38.636732] hda: max request size: 1024KiB
Aug 12 07:51:28 [kernel] [   38.658311] hda: 58605120 sectors (30005 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
Aug 12 07:51:28 [kernel] [   38.658667] hda: cache flushes supported
Aug 12 07:51:28 [kernel] [   38.658795]  hda: hda1 hda2 hda4
Aug 12 07:51:28 [kernel] [   38.677705] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Aug 12 07:51:28 [kernel] [   38.677842] Uniform CD-ROM driver Revision: 3.20
Aug 12 07:51:28 [kernel] [   39.151414] ieee1394: raw1394: /dev/raw1394 device initialized
Aug 12 07:51:28 [kernel] [   39.151527] usbmon: debugs is not available
Aug 12 07:51:28 [kernel] [   39.151675] mice: PS/2 mouse device common for all mice
Aug 12 07:51:28 [kernel] [   39.152294] Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
Aug 12 07:51:28 [kernel] [   39.152731] ALSA device list:
Aug 12 07:51:28 [kernel] [   39.152760]   No soundcards found.
Aug 12 07:51:28 [kernel] [   39.152829] NET: Registered protocol family 2
Aug 12 07:51:28 [kernel] [   39.189209] input: AT Translated Set 2 keyboard on isa0060/serio0
Aug 12 07:51:28 [kernel] [   39.193034] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Aug 12 07:51:28 [kernel] [   39.193568] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
Aug 12 07:51:28 [kernel] [   39.196849] TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
Aug 12 07:51:28 [kernel] [   39.203046] TCP: Hash tables configured (established 131072 bind 65536)
Aug 12 07:51:28 [kernel] [   39.203093] TCP reno registered
Aug 12 07:51:28 [kernel] [   39.203513] ip_conntrack version 2.1 (5623 buckets, 44984 max) - 212 bytes per conntrack
Aug 12 07:51:28 [kernel] [   39.296155] ip_tables: (C) 2000-2002 Netfilter core team
Aug 12 07:51:28 [kernel] [   39.464051] ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Aug 12 07:51:28 [kernel] [   39.464145] arp_tables: (C) 2002 David S. Miller
Aug 12 07:51:28 [kernel] [   39.500072] TCP bic registered
Aug 12 07:51:28 [kernel] [   39.500121] NET: Registered protocol family 1
Aug 12 07:51:28 [kernel] [   39.500157] NET: Registered protocol family 17
Aug 12 07:51:28 [kernel] [   39.500201] powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
Aug 12 07:51:28 [kernel] [   39.520338] Detected 796.213 MHz processor.
Aug 12 07:51:28 [kernel] [   39.524299] powernow: SGTC: 13333
Aug 12 07:51:28 [kernel] [   39.524327] powernow: Minimum speed 1260 MHz. Maximum speed 1791 MHz.
Aug 12 07:51:28 [kernel] [   17.549514] Using IPI Shortcut mode
Aug 12 07:51:28 [kernel] [   17.576285] swsusp: Suspend partition has wrong signature?
Aug 12 07:51:28 [kernel] [   17.651422] EXT3-fs: INFO: recovery required on readonly filesystem.
Aug 12 07:51:28 [kernel] [   17.651452] EXT3-fs: write access will be enabled during recovery.
Aug 12 07:51:28 [kernel] [   17.861196] Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006
Aug 12 07:51:28 [kernel] [   19.622374] EXT3-fs: hda2: orphan cleanup on readonly fs
Aug 12 07:51:28 [kernel] [   19.622541] EXT3-fs: hda2: 3 orphan inodes deleted
Aug 12 07:51:28 [kernel] [   19.622567] EXT3-fs: recovery complete.
Aug 12 07:51:28 [kernel] [   19.656318] EXT3-fs: mounted filesystem with ordered data mode.
Aug 12 07:51:28 [kernel] [   19.656398] VFS: Mounted root (ext3 filesystem) readonly.
Aug 12 07:51:28 [kernel] [   19.656878] Freeing unused kernel memory: 212k freed
Aug 12 07:51:28 [kernel] [   27.309106] Adding 265064k swap on /dev/hda4.  Priority:-1 extents:1
Aug 12 07:51:28 [kernel] [   27.450162] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
Aug 12 07:51:28 [kernel] [   27.450414] EXT3 FS on hda2, internal journal
Aug 12 07:51:28 [kernel] [   34.300129] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Aug 12 07:51:28 [kernel] [   38.456236] NTFS driver 2.1.23 [Flags: R/W MODULE].
Aug 12 07:51:28 [kernel] [   38.522203] NTFS volume version 3.1.
Aug 12 07:51:28 [kernel] [   41.812882] ts: Compaq touchscreen protocol output
Aug 12 07:51:28 [kernel] [   42.207864] PCI: Found IRQ 5 for device 0000:00:07.0
Aug 12 07:51:28 [kernel] [   42.207878] PCI: Sharing IRQ 5 with 0000:00:08.0
Aug 12 07:51:28 [kernel] [   42.207883] PCI: Sharing IRQ 5 with 0000:00:10.1
Aug 12 07:51:28 [kernel] [   42.207911] Yenta: CardBus bridge found at 0000:00:07.0 [1025:0033]
Aug 12 07:51:28 [kernel] [   42.207931] Yenta: Enabling burst memory read transactions
Aug 12 07:51:28 [kernel] [   42.207936] Yenta: Using CSCINT to route CSC interrupts to PCI
Aug 12 07:51:28 [kernel] [   42.207938] Yenta: Routing CardBus interrupts to PCI
Aug 12 07:51:28 [kernel] [   42.207944] Yenta TI: socket 0000:00:07.0, mfunc 0x01201212, devctl 0x64
Aug 12 07:51:28 [kernel] [   42.437065] Yenta: ISA IRQ mask 0x0408, PCI irq 5
Aug 12 07:51:28 [kernel] [   42.437072] Socket status: 30000006
Aug 12 07:51:28 [kernel] [   42.560695] ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
Aug 12 07:51:28 [kernel] [   42.560731] PCI: Found IRQ 5 for device 0000:00:08.0
Aug 12 07:51:28 [kernel] [   42.560740] PCI: Sharing IRQ 5 with 0000:00:07.0
Aug 12 07:51:28 [kernel] [   42.560746] PCI: Sharing IRQ 5 with 0000:00:10.1
Aug 12 07:51:28 [kernel] [   42.613999] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): 
