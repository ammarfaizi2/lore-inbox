Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278476AbRJ3W0s>; Tue, 30 Oct 2001 17:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278489AbRJ3W03>; Tue, 30 Oct 2001 17:26:29 -0500
Received: from pm2-modem25.inet-direct.com ([204.71.22.89]:384 "HELO NewStar")
	by vger.kernel.org with SMTP id <S278476AbRJ3W00>;
	Tue, 30 Oct 2001 17:26:26 -0500
Date: Tue, 30 Oct 2001 17:24:01 -0600
From: mhobgood@inet-direct.com
To: linux-kernel@vger.kernel.org
Subject: An oops on boot?
Message-ID: <20011030172401.A139@inet-direct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received the following output when I rebooted my machine.  Since
I've never seen an "oops" during boot where the boot kept going,
thought I would send this in.

Kernel is 2.4.12-ac3 with both of Riks vm patches.

Cordially
Michael Hobgood


Oct 30 15:11:34 NewStar kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct 30 15:11:34 NewStar kernel: Inspecting /System.map
Oct 30 15:11:34 NewStar kernel: Loaded 13152 symbols from /System.map.
Oct 30 15:11:34 NewStar kernel: Symbols match kernel version 2.4.12.
Oct 30 15:11:34 NewStar kernel: Loaded 324 symbols from 18 modules.
Oct 30 15:11:34 NewStar kernel: Linux version 2.4.12-ac3 (root@NewStar) (gcc version 2.95.2.1 19991024 (release)) #1 Thu Oct 18 04:28:16 CDT 2001
Oct 30 15:11:34 NewStar kernel: BIOS-provided physical RAM map:
Oct 30 15:11:34 NewStar kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Oct 30 15:11:34 NewStar kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Oct 30 15:11:34 NewStar kernel:  BIOS-e820: 00000000000f1800 - 0000000000100000 (reserved)
Oct 30 15:11:34 NewStar kernel:  BIOS-e820: 0000000000100000 - 0000000012000000 (usable)
Oct 30 15:11:34 NewStar kernel:  BIOS-e820: 00000000ffff1800 - 0000000100000000 (reserved)
Oct 30 15:11:34 NewStar kernel: On node 0 totalpages: 73728
Oct 30 15:11:34 NewStar kernel: zone(0): 4096 pages.
Oct 30 15:11:34 NewStar kernel: zone(1): 69632 pages.
Oct 30 15:11:34 NewStar kernel: zone(2): 0 pages.
Oct 30 15:11:34 NewStar kernel: Kernel command line: BOOT_IMAGE=2412AC3RIK ro root=341 hdd=ide-scsi
Oct 30 15:11:34 NewStar kernel: ide_setup: hdd=ide-scsi
Oct 30 15:11:34 NewStar kernel: Initializing CPU#0
Oct 30 15:11:34 NewStar kernel: Detected 334.096 MHz processor.
Oct 30 15:11:34 NewStar kernel: Console: colour VGA+ 80x25
Oct 30 15:11:34 NewStar kernel: Calibrating delay loop... 666.82 BogoMIPS
Oct 30 15:11:34 NewStar kernel: Memory: 288072k/294912k available (904k kernel code, 6452k reserved, 206k data, 192k init, 0k highmem)
Oct 30 15:11:34 NewStar kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Oct 30 15:11:34 NewStar kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Oct 30 15:11:34 NewStar kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Oct 30 15:11:34 NewStar kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Oct 30 15:11:34 NewStar kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Oct 30 15:11:34 NewStar kernel: CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
Oct 30 15:11:34 NewStar kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct 30 15:11:34 NewStar kernel: CPU: L2 cache: 512K
Oct 30 15:11:34 NewStar kernel: CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
Oct 30 15:11:34 NewStar kernel: Intel machine check architecture supported.
Oct 30 15:11:34 NewStar kernel: Intel machine check reporting enabled on CPU#0.
Oct 30 15:11:34 NewStar kernel: CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
Oct 30 15:11:34 NewStar kernel: CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
Oct 30 15:11:34 NewStar kernel: CPU: Intel Pentium II (Deschutes) stepping 00
Oct 30 15:11:34 NewStar kernel: Enabling fast FPU save and restore... done.
Oct 30 15:11:34 NewStar kernel: Checking 'hlt' instruction... OK.
Oct 30 15:11:34 NewStar kernel: POSIX conformance testing by UNIFIX
Oct 30 15:11:34 NewStar kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd9c3, last bus=1
Oct 30 15:11:34 NewStar kernel: PCI: Using configuration type 1
Oct 30 15:11:34 NewStar kernel: PCI: Probing PCI hardware
Oct 30 15:11:34 NewStar kernel: Unknown bridge resource 2: assuming transparent
Oct 30 15:11:34 NewStar kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Oct 30 15:11:34 NewStar kernel: Limiting direct PCI/PCI transfers.
Oct 30 15:11:34 NewStar kernel: Linux NET4.0 for Linux 2.4
Oct 30 15:11:34 NewStar kernel: Based upon Swansea University Computer Society NET3.039
Oct 30 15:11:34 NewStar kernel: Starting kswapd v1.8
Oct 30 15:11:34 NewStar kernel: pty: 256 Unix98 ptys configured
Oct 30 15:11:34 NewStar kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Oct 30 15:11:34 NewStar kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Oct 30 15:11:34 NewStar kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Oct 30 15:11:34 NewStar kernel: ttyS02 at 0x03e8 (irq = 4) is a 16550A
Oct 30 15:11:34 NewStar kernel: ttyS03 at 0x02e8 (irq = 3) is a 16550A
Oct 30 15:11:34 NewStar kernel: PCI: Found IRQ 11 for device 00:09.0
Oct 30 15:11:34 NewStar kernel: PCI: Sharing IRQ 11 with 00:07.2
Oct 30 15:11:34 NewStar kernel: ttyS04 at port 0xd400 (irq = 11) is a 16550A
Oct 30 15:11:34 NewStar kernel: block: queued sectors max/low 191010kB/63670kB, 576 slots per queue
Oct 30 15:11:34 NewStar kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Oct 30 15:11:34 NewStar kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct 30 15:11:34 NewStar kernel: PIIX4: IDE controller on PCI bus 00 dev 39
Oct 30 15:11:34 NewStar kernel: PIIX4: chipset revision 1
Oct 30 15:11:34 NewStar kernel: PIIX4: not 100%% native mode: will probe irqs later
Oct 30 15:11:34 NewStar kernel:     ide0: BM-DMA at 0xdc90-0xdc97, BIOS settings: hda:pio, hdb:DMA
Oct 30 15:11:34 NewStar kernel:     ide1: BM-DMA at 0xdc98-0xdc9f, BIOS settings: hdc:pio, hdd:pio
Oct 30 15:11:34 NewStar kernel: hda: QUANTUM Bigfoot TX8.0AT, ATA DISK drive
Oct 30 15:11:34 NewStar kernel: hdb: WDC AC23200L, ATA DISK drive
Oct 30 15:11:34 NewStar kernel: hdc: HITACHI GD-2000, ATAPI CD/DVD-ROM drive
Oct 30 15:11:34 NewStar kernel: hdd: HP CD-Writer+ 7200, ATAPI CD/DVD-ROM drive
Oct 30 15:11:34 NewStar kernel: ide2: ports already in use, skipping probe
Oct 30 15:11:34 NewStar kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 30 15:11:34 NewStar kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct 30 15:11:34 NewStar kernel: hda: 15698592 sectors (8038 MB) w/69KiB Cache, CHS=16612/15/63
Oct 30 15:11:34 NewStar kernel: hdb: 6346368 sectors (3249 MB) w/256KiB Cache, CHS=6296/16/63
Oct 30 15:11:34 NewStar kernel: Partition check:
Oct 30 15:11:34 NewStar kernel:  hda: [PTBL] [1038/240/63] hda1 hda2 hda3 hda4
Oct 30 15:11:34 NewStar kernel:  hdb: [PTBL] [787/128/63] hdb1 hdb2
Oct 30 15:11:34 NewStar kernel: Floppy drive(s): fd0 is 1.44M
Oct 30 15:11:34 NewStar kernel: FDC 0 is a National Semiconductor PC87306
Oct 30 15:11:34 NewStar kernel: PPP generic driver version 2.4.1
Oct 30 15:11:34 NewStar kernel: PPP Deflate Compression module registered
Oct 30 15:11:34 NewStar kernel: PPP BSD Compression module registered
Oct 30 15:11:34 NewStar kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Oct 30 15:11:34 NewStar kernel: agpgart: Maximum main memory to use for agp memory: 233M
Oct 30 15:11:34 NewStar kernel: agpgart: Detected Intel 440LX chipset
Oct 30 15:11:34 NewStar kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Oct 30 15:11:34 NewStar kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Oct 30 15:11:34 NewStar kernel: IP Protocols: ICMP, UDP, TCP
Oct 30 15:11:34 NewStar kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Oct 30 15:11:34 NewStar kernel: TCP: Hash tables configured (established 32768 bind 32768)
Oct 30 15:11:34 NewStar kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Oct 30 15:11:34 NewStar kernel: VFS: Mounted root (ext2 filesystem) readonly.
Oct 30 15:11:34 NewStar kernel: Freeing unused kernel memory: 192k freed
Oct 30 15:11:34 NewStar kernel: Adding Swap: 350776k swap-space (priority -1)
Oct 30 15:11:34 NewStar kernel: es1370: version v0.37 time 04:49:10 Oct 18 2001
Oct 30 15:11:34 NewStar kernel: PCI: Found IRQ 10 for device 00:0c.0
Oct 30 15:11:34 NewStar kernel: es1370: found adapter at io 0xdcc0 irq 10
Oct 30 15:11:34 NewStar kernel: es1370: features: joystick off, line in, mic impedance 0

		This begins the strange stuff:
Oct 30 15:11:34 NewStar kernel: hdc: ATAPI 20X DVD-ROM drive, 512kB Cache
Oct 30 15:11:34 NewStar kernel: Uniform CD-ROM driver Revision: 3.12
Oct 30 15:11:34 NewStar kernel: hdc: ide_cdrom_setup failed to register device with the cdrom driver.
Oct 30 15:11:34 NewStar kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000028
Oct 30 15:11:34 NewStar kernel:  printing eip:
Oct 30 15:11:34 NewStar kernel: c0198fa3
Oct 30 15:11:34 NewStar kernel: *pde = 00000000
Oct 30 15:11:34 NewStar kernel: Oops: 0000
Oct 30 15:11:34 NewStar kernel: CPU:    0
Oct 30 15:11:34 NewStar kernel: EIP:    0010:[ide_open+39/140]    Not tainted
Oct 30 15:11:34 NewStar kernel: EFLAGS: 00010212
Oct 30 15:11:34 NewStar kernel: eax: 00000000   ebx: 00001600   ecx: d2850000   edx: d1bd6000
Oct 30 15:11:34 NewStar kernel: esi: 000003f0   edi: c0278790   ebp: 00000040   esp: d1bd7ee0
Oct 30 15:11:34 NewStar kernel: ds: 0018   es: 0018   ss: 0018
Oct 30 15:11:34 NewStar kernel: Process modprobe (pid: 26, stackpage=d1bd7000)
Oct 30 15:11:34 NewStar kernel: Stack: c0278790 00000000 c0278750 00000002 c027886c 16008400 00000000 c019902b 
Oct 30 15:11:34 NewStar kernel:        00001600 d1f58400 00000000 d1f58540 00000002 c019b2a5 d28578b5 d285a4c0 
Oct 30 15:11:34 NewStar kernel:        d2854000 00000001 00000001 00006640 c0112abd d1bd6000 0805349b 00006640 
Oct 30 15:11:34 NewStar kernel: Call Trace: [ide_release+35/60] [ide_media_verbose+41/80] [hid:__insmod_hid_O/lib/modules/2.4.12-ac3/kernel/drivers/usb/hi+-350027/96] [hid:__insmod_hid_O/lib/modules/2.4.12-ac3/kernel/drivers/usb/hi+-338752/96] [sys_init_module+1317/1528] 
Oct 30 15:11:34 NewStar kernel:    [hid:__insmod_hid_O/lib/modules/2.4.12-ac3/kernel/drivers/usb/hi+-364448/96] [system_call+51/56] 
Oct 30 15:11:34 NewStar kernel: 
Oct 30 15:11:34 NewStar kernel: Code: 83 78 28 00 74 09 57 8b 40 28 ff d0 83 c4 04 80 a7 ae 00 00 
Oct 30 15:11:34 NewStar kernel:  <6>SCSI subsystem driver Revision: 1.00
Oct 30 15:11:34 NewStar kernel: ide-scsi: hdc: Failed to register the driver with ide.c
Oct 30 15:11:34 NewStar kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Oct 30 15:11:34 NewStar kernel:   Vendor: HP        Model: CD-Writer+ 7200   Rev: 3.01
Oct 30 15:11:34 NewStar kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct 30 15:11:34 NewStar kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Oct 30 15:11:34 NewStar kernel: sr0: scsi3-mmc drive: 2x/6x writer cd/rw xa/form2 cdda tray
		This ends the strange stuff:
Oct 30 15:11:34 NewStar kernel: parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
Oct 30 15:11:34 NewStar kernel: parport0: cpp_mux: aa55f00f52ad51(8f)
Oct 30 15:11:34 NewStar kernel: parport0: cpp_daisy: aa5500ff(88)
Oct 30 15:11:34 NewStar kernel: parport0: assign_addrs: aa5500ff(88)
Oct 30 15:11:34 NewStar kernel: parport0: cpp_mux: aa55f00f52ad51(8f)
Oct 30 15:11:34 NewStar kernel: parport0: cpp_daisy: aa5500ff(88)
Oct 30 15:11:34 NewStar kernel: parport0: assign_addrs: aa5500ff(88)
Oct 30 15:11:34 NewStar kernel: parport1: PC-style at 0x378 [PCSPP,TRISTATE]
Oct 30 15:11:34 NewStar kernel: parport1: cpp_daisy: aa5500ff(38)
Oct 30 15:11:34 NewStar kernel: parport1: assign_addrs: aa5500ff(38)
Oct 30 15:11:34 NewStar kernel: parport1: cpp_daisy: aa5500ff(38)
Oct 30 15:11:34 NewStar kernel: parport1: assign_addrs: aa5500ff(38)
Oct 30 15:11:34 NewStar kernel: parport2: PC-style at 0x278 [PCSPP,TRISTATE]
Oct 30 15:11:34 NewStar kernel: parport2: cpp_mux: aa55f00f52ad51(8f)
Oct 30 15:11:34 NewStar kernel: parport2: cpp_daisy: aa5500ff(88)
Oct 30 15:11:34 NewStar kernel: parport2: assign_addrs: aa5500ff(88)
Oct 30 15:11:34 NewStar kernel: parport2: cpp_mux: aa55f00f52ad51(8f)
Oct 30 15:11:34 NewStar kernel: parport2: cpp_daisy: aa5500ff(88)
Oct 30 15:11:34 NewStar kernel: parport2: assign_addrs: aa5500ff(88)
Oct 30 15:11:34 NewStar kernel: lp0: using parport0 (polling).
Oct 30 15:11:34 NewStar kernel: lp1: using parport1 (polling).
Oct 30 15:11:34 NewStar kernel: lp2: using parport2 (polling).
Oct 30 15:11:34 NewStar kernel: ppdev: user-space parallel port driver
Oct 30 15:11:34 NewStar kernel: loop: loaded (max 8 devices)
Oct 30 15:11:34 NewStar kernel: mice: PS/2 mouse device common for all mice
Oct 30 15:11:34 NewStar kernel: usb.c: registered new driver hub
Oct 30 15:11:34 NewStar kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
Oct 30 15:11:34 NewStar kernel: PCI: Found IRQ 11 for device 00:07.2
Oct 30 15:11:34 NewStar kernel: PCI: Sharing IRQ 11 with 00:09.0
Oct 30 15:11:34 NewStar kernel: uhci.c: USB UHCI at I/O 0xdca0, IRQ 11
Oct 30 15:11:34 NewStar kernel: usb.c: new USB bus registered, assigned bus number 1
Oct 30 15:11:34 NewStar kernel: hub.c: USB hub found
Oct 30 15:11:34 NewStar kernel: hub.c: 2 ports detected
Oct 30 15:11:34 NewStar kernel: usb.c: registered new driver hid
Oct 30 15:11:34 NewStar kernel: hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
Oct 30 15:11:34 NewStar kernel: hid-core.c: USB HID support drivers
Oct 30 15:11:34 NewStar kernel: hub.c: USB new device connect on bus1/2, assigned device number 2
Oct 30 15:11:34 NewStar kernel: input0: USB HID v1.00 Mouse [0603:6871] on usb1:2.0
