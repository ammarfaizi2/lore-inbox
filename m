Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271152AbTHLVQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271195AbTHLVQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:16:11 -0400
Received: from dhcp-83-003.via-eth.ch ([192.33.108.3]:41049 "EHLO sornico")
	by vger.kernel.org with ESMTP id S271152AbTHLVO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:14:57 -0400
Message-ID: <3F3958CB.2050606@VandenBerghe.org>
Date: Tue, 12 Aug 2003 23:14:51 +0200
From: Chris Vanden Berghe <Chris@VandenBerghe.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: nl-be, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: kernel/workqueue.c:77]
Content-Type: multipart/mixed;
 boundary="------------060803010108090907000605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060803010108090907000605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I (frequently) encounter the following bug. The error occurs after 
inserting of my
pcmcia wireless card. A partial log-file is attached.

Version of kernel is 2.6.0-test3, compiled with GCC 3.3.1.

Mail me if you need more info or if you can point me to the correct
place to report this.

Kind regards,
Chris.

--------------060803010108090907000605
Content-Type: text/plain;
 name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages"

Aug 11 10:14:47 sornico syslogd 1.4.1#11: restart.
Aug 11 10:15:09 sornico kernel: airo:  Probing for PCI adapters
Aug 11 10:15:09 sornico kernel: airo:  Finished probing for PCI adapters
Aug 11 10:15:10 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 10:15:10 sornico kernel: eth0: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
Aug 11 10:15:24 sornico kernel: Setting key 0
Aug 11 09:19:00 sornico kernel: cs: cb_alloc(bus 2): vendor 0x115d, device 0x0003
Aug 11 09:19:00 sornico kernel: PCI: Enabling device 02:00.0 (0000 -> 0003)
Aug 11 09:19:00 sornico kernel: xircom_tulip_cb.c derived from tulip.c:v0.91 4/14/99 becker@scyld.com
Aug 11 09:19:00 sornico kernel:  unofficial 2.4.x kernel port, version 0.91+LK1.1, October 11, 2001
Aug 11 09:19:00 sornico kernel: eth0: Xircom Cardbus Adapter rev 3 at 0x4000, 00:10:A4:76:BC:85, IRQ 11.
Aug 11 09:19:00 sornico kernel: eth0:  MII transceiver #0 config 3100 status 7809 advertising 01e1.
Aug 11 09:19:35 sornico kernel: spurious 8259A interrupt: IRQ7.
Aug 11 09:30:57 sornico -- MARK --
Aug 11 09:47:57 sornico kernel: xircom_tulip_cb: outl_CSR6 too many attempts,csr5=0x60218140
Aug 11 09:47:57 sornico last message repeated 2 times
Aug 11 09:49:10 sornico last message repeated 7 times
Aug 11 10:10:57 sornico -- MARK --
Aug 11 10:13:17 sornico kernel: xircom_tulip_cb: outl_CSR6 too many attempts,csr5=0x60218140
Aug 11 10:30:57 sornico -- MARK --
Aug 11 10:50:57 sornico -- MARK --
Aug 11 11:04:04 sornico kernel: xircom_tulip_cb: outl_CSR6 too many attempts,csr5=0x60218140
Aug 11 11:04:08 sornico kernel: xircom_tulip_cb: outl_CSR6 too many attempts,csr5=0x60218140
Aug 11 11:05:23 sornico kernel: xircom_tulip_cb: outl_CSR6 too many attempts,csr5=0x60218140
Aug 11 11:06:30 sornico last message repeated 4 times
Aug 11 11:30:57 sornico -- MARK --
Aug 11 11:50:57 sornico -- MARK --
Aug 11 12:10:57 sornico -- MARK --
Aug 11 12:30:57 sornico -- MARK --
Aug 11 12:50:57 sornico -- MARK --
Aug 11 13:10:57 sornico -- MARK --
Aug 11 13:30:57 sornico -- MARK --
Aug 11 13:50:57 sornico -- MARK --
Aug 11 14:10:57 sornico -- MARK --
Aug 11 14:30:57 sornico -- MARK --
Aug 11 14:50:58 sornico -- MARK --
Aug 11 15:10:58 sornico -- MARK --
Aug 11 15:30:58 sornico -- MARK --
Aug 11 15:50:58 sornico -- MARK --
Aug 11 16:10:58 sornico -- MARK --
Aug 11 16:30:58 sornico -- MARK --
Aug 11 16:50:58 sornico -- MARK --
Aug 11 17:10:58 sornico -- MARK --
Aug 11 17:30:58 sornico -- MARK --
Aug 11 17:50:58 sornico -- MARK --
Aug 11 18:10:13 sornico kernel: xircom_tulip_cb: outl_CSR6 too many attempts,csr5=0x60218140
Aug 11 18:12:57 sornico kernel: xircom_remove_one(eth0)
Aug 11 18:12:57 sornico kernel: cs: cb_free(bus 2)
Aug 11 19:16:44 sornico kernel: airo:  Probing for PCI adapters
Aug 11 19:16:44 sornico kernel: airo:  Finished probing for PCI adapters
Aug 11 19:16:45 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 19:16:45 sornico kernel: eth0: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
Aug 11 19:16:49 sornico kernel: Setting key 0
Aug 11 19:34:33 sornico -- MARK --
Aug 11 19:49:23 sornico kernel: airo:  Probing for PCI adapters
Aug 11 19:49:23 sornico kernel: airo:  Finished probing for PCI adapters
Aug 11 19:49:24 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 19:49:24 sornico kernel: eth0: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
Aug 11 19:50:31 sornico kernel: device eth0 entered promiscuous mode
Aug 11 19:50:53 sornico kernel: device eth0 left promiscuous mode
Aug 11 19:52:15 sornico kernel: device eth0 entered promiscuous mode
Aug 11 19:55:20 sornico kernel: device eth0 left promiscuous mode
Aug 11 19:56:44 sornico kernel: Setting key 0
Aug 11 19:59:27 sornico kernel: device eth0 entered promiscuous mode
Aug 11 20:03:47 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 20:05:59 sornico kernel: airo:  Probing for PCI adapters
Aug 11 20:05:59 sornico kernel: airo:  Finished probing for PCI adapters
Aug 11 20:05:59 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 20:05:59 sornico kernel: eth0: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
Aug 11 20:06:29 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 20:06:29 sornico kernel: device eth0 entered promiscuous mode
Aug 11 20:07:01 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 20:07:02 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 20:11:28 sornico kernel: device wifi0 entered promiscuous mode
Aug 11 20:14:26 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 20:14:26 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 20:17:49 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 20:17:56 sornico last message repeated 3 times
Aug 11 20:18:21 sornico kernel: airo:  Probing for PCI adapters
Aug 11 20:18:21 sornico kernel: airo:  Finished probing for PCI adapters
Aug 11 20:18:22 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 20:18:22 sornico kernel: eth0: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
Aug 11 20:18:24 sornico kernel: Setting key 0
Aug 11 20:26:27 sornico kernel: mtrr: no MTRR for f0000000,800000 found
Aug 11 20:26:29 sornico kernel: mtrr: MTRR 2 not used
Aug 11 20:26:29 sornico kernel: mtrr: reg 2 not used
Aug 11 20:26:34 sornico shutdown[18280]: shutting down for system reboot
Aug 11 20:26:45 sornico gpm: *** info [gpn.c(176)]: 
Aug 11 20:26:45 sornico gpm: Killed gpm(468).
Aug 11 20:26:48 sornico kernel: unloading Kernel Card Services
Aug 11 20:26:52 sornico kernel: usb.c: USB disconnect on device 00:07.2-0 address 1
Aug 11 20:26:52 sornico kernel: usb.c: USB bus 1 deregistered
Aug 11 20:26:53 sornico kernel: usb.c: deregistering driver usbkbd
Aug 11 20:26:53 sornico kernel: usb.c: deregistering driver usbdevfs
Aug 11 20:26:53 sornico kernel: usb.c: deregistering driver hub
Aug 11 20:26:53 sornico kernel: Kernel logging (proc) stopped.
Aug 11 20:26:53 sornico kernel: Kernel log daemon terminating.
Aug 11 20:26:53 sornico exiting on signal 15
Aug 11 20:27:42 sornico syslogd 1.4.1#11: restart.
Aug 11 20:27:42 sornico kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
Aug 11 20:27:42 sornico kernel: Inspecting /boot/System.map-2.6.0-test3
Aug 11 20:27:43 sornico kernel: Loaded 26010 symbols from /boot/System.map-2.6.0-test3.
Aug 11 20:27:43 sornico kernel: Symbols match kernel version 2.6.0.
Aug 11 20:27:43 sornico kernel: No module symbols loaded - kernel modules not enabled. 
Aug 11 20:27:43 sornico kernel: Linux version 2.6.0-test3 (root@sornico) (gcc version 3.3.1 (Debian)) #1 Mon Aug 11 16:48:18 CEST 2003
Aug 11 20:27:43 sornico kernel: Video mode to be used for restore is f00
Aug 11 20:27:43 sornico kernel: BIOS-provided physical RAM map:
Aug 11 20:27:43 sornico kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Aug 11 20:27:43 sornico kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Aug 11 20:27:43 sornico kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Aug 11 20:27:43 sornico kernel:  BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
Aug 11 20:27:43 sornico kernel:  BIOS-e820: 0000000017ff0000 - 0000000017ffec00 (ACPI data)
Aug 11 20:27:43 sornico kernel:  BIOS-e820: 0000000017ffec00 - 0000000018000000 (ACPI NVS)
Aug 11 20:27:43 sornico kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Aug 11 20:27:43 sornico kernel: 383MB LOWMEM available.
Aug 11 20:27:43 sornico kernel: On node 0 totalpages: 98288
Aug 11 20:27:43 sornico kernel:   DMA zone: 4096 pages, LIFO batch:1
Aug 11 20:27:43 sornico kernel:   Normal zone: 94192 pages, LIFO batch:16
Aug 11 20:27:43 sornico kernel:   HighMem zone: 0 pages, LIFO batch:1
Aug 11 20:27:43 sornico kernel: IBM machine detected. Enabling interrupts during APM calls.
Aug 11 20:27:43 sornico kernel: IBM machine detected. Disabling SMBus accesses.
Aug 11 20:27:43 sornico kernel: ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7160
Aug 11 20:27:43 sornico kernel: ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x17ff4d6f
Aug 11 20:27:43 sornico kernel: ACPI: FADT (v001 IBM    TP-T21   01540.00000) @ 0x17ffeb65
Aug 11 20:27:43 sornico kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x17ffebd9
Aug 11 20:27:43 sornico kernel: ACPI: DSDT (v001 IBM    TP-T21   01540.00000) @ 0x00000000
Aug 11 20:27:43 sornico kernel: ACPI: BIOS passes blacklist
Aug 11 20:27:43 sornico kernel: Building zonelist for node : 0
Aug 11 20:27:43 sornico kernel: Kernel command line: BOOT_IMAGE=Linux-2.6.0-3 ro root=302
Aug 11 20:27:43 sornico kernel: Initializing CPU#0
Aug 11 20:27:43 sornico kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Aug 11 20:27:43 sornico kernel: Detected 222.778 MHz processor.
Aug 11 20:27:43 sornico kernel: Console: colour VGA+ 80x25
Aug 11 20:27:43 sornico kernel: Calibrating delay loop... 786.43 BogoMIPS
Aug 11 20:27:43 sornico kernel: Memory: 385724k/393152k available (1736k kernel code, 6672k reserved, 667k data, 140k init, 0k highmem)
Aug 11 20:27:43 sornico kernel: Security Scaffold v1.0.0 initialized
Aug 11 20:27:43 sornico kernel: SELinux:  Initializing.
Aug 11 20:27:43 sornico kernel: SELinux:  Starting in permissive mode
Aug 11 20:27:43 sornico kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 11 20:27:43 sornico kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Aug 11 20:27:43 sornico kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 11 20:27:43 sornico kernel: -> /dev
Aug 11 20:27:43 sornico kernel: -> /dev/console
Aug 11 20:27:43 sornico kernel: -> /root
Aug 11 20:27:43 sornico kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 11 20:27:43 sornico kernel: CPU: L2 cache: 256K
Aug 11 20:27:43 sornico kernel: Intel machine check architecture supported.
Aug 11 20:27:43 sornico kernel: Intel machine check reporting enabled on CPU#0.
Aug 11 20:27:43 sornico kernel: CPU: Intel Pentium III (Coppermine) stepping 0a
Aug 11 20:27:43 sornico kernel: Enabling fast FPU save and restore... done.
Aug 11 20:27:43 sornico kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 11 20:27:43 sornico kernel: Checking 'hlt' instruction... OK.
Aug 11 20:27:43 sornico kernel: POSIX conformance testing by UNIFIX
Aug 11 20:27:43 sornico kernel: Initializing RT netlink socket
Aug 11 20:27:43 sornico kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=7
Aug 11 20:27:43 sornico kernel: PCI: Using configuration type 1
Aug 11 20:27:43 sornico kernel: mtrr: v2.0 (20020519)
Aug 11 20:27:43 sornico kernel: BIO: pool of 256 setup, 15Kb (60 bytes/bio)
Aug 11 20:27:43 sornico kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Aug 11 20:27:43 sornico kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Aug 11 20:27:43 sornico kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Aug 11 20:27:43 sornico kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Aug 11 20:27:43 sornico kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Aug 11 20:27:43 sornico kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Aug 11 20:27:43 sornico kernel: ACPI: Subsystem revision 20030714
Aug 11 20:27:43 sornico kernel: Loosing too many ticks!
Aug 11 20:27:43 sornico kernel: TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Aug 11 20:27:43 sornico kernel: Falling back to a sane timesource.
Aug 11 20:27:43 sornico kernel: ACPI: Interpreter enabled
Aug 11 20:27:43 sornico kernel: ACPI: Using PIC for interrupt routing
Aug 11 20:27:43 sornico kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
Aug 11 20:27:43 sornico kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
Aug 11 20:27:43 sornico kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
Aug 11 20:27:43 sornico kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
Aug 11 20:27:43 sornico kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 11 20:27:43 sornico kernel: PCI: Probing PCI hardware (bus 00)
Aug 11 20:27:43 sornico kernel: ACPI: Power Resource [PSER] (off)
Aug 11 20:27:43 sornico kernel: ACPI: Power Resource [PSIO] (on)
Aug 11 20:27:43 sornico kernel: ACPI: Embedded Controller [EC] (gpe 9)
Aug 11 20:27:43 sornico kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 11 20:27:43 sornico kernel: PnPBIOS: Scanning system for PnP BIOS support...
Aug 11 20:27:43 sornico kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f7210
Aug 11 20:27:43 sornico kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb1ef, dseg 0x400
Aug 11 20:27:43 sornico kernel: PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
Aug 11 20:27:43 sornico kernel: PCI: Using ACPI for IRQ routing
Aug 11 20:27:43 sornico kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Aug 11 20:27:43 sornico kernel: pty: 256 Unix98 ptys configured
Aug 11 20:27:43 sornico kernel: SBF: ACPI BOOT descriptor is wrong length (39)
Aug 11 20:27:43 sornico kernel: SBF: Simple Boot Flag extension found and enabled.
Aug 11 20:27:43 sornico kernel: SBF: Setting boot flags 0x1
Aug 11 20:27:43 sornico kernel: VFS: Disk quotas dquot_6.5.1
Aug 11 20:27:43 sornico kernel: Journalled Block Device driver loaded
Aug 11 20:27:43 sornico kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
Aug 11 20:27:43 sornico kernel: devfs: boot_options: 0x0
Aug 11 20:27:43 sornico kernel: Initializing Cryptographic API
Aug 11 20:27:43 sornico kernel: Limiting direct PCI/PCI transfers.
Aug 11 20:27:43 sornico kernel: isapnp: Scanning for PnP cards...
Aug 11 20:27:43 sornico kernel: isapnp: No Plug & Play device found
Aug 11 20:27:43 sornico kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
Aug 11 20:27:43 sornico kernel: pnp: Device 00:0e activated.
Aug 11 20:27:43 sornico kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 11 20:27:43 sornico kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Aug 11 20:27:43 sornico kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 11 20:27:43 sornico kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 11 20:27:43 sornico kernel: PIIX4: IDE controller at PCI slot 0000:00:07.1
Aug 11 20:27:43 sornico kernel: PIIX4: chipset revision 1
Aug 11 20:27:43 sornico kernel: PIIX4: not 100%% native mode: will probe irqs later
Aug 11 20:27:43 sornico kernel:     ide0: BM-DMA at 0x1c10-0x1c17, BIOS settings: hda:DMA, hdb:pio
Aug 11 20:27:43 sornico kernel:     ide1: BM-DMA at 0x1c18-0x1c1f, BIOS settings: hdc:DMA, hdd:pio
Aug 11 20:27:43 sornico kernel: hda: IBM-DJSA-220, ATA DISK drive
Aug 11 20:27:43 sornico kernel: Using anticipatory scheduling elevator
Aug 11 20:27:43 sornico kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 11 20:27:43 sornico kernel: hdc: HITACHI DVD-ROM GD-S200, ATAPI CD/DVD-ROM drive
Aug 11 20:27:43 sornico kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 11 20:27:43 sornico kernel: hda: max request size: 128KiB
Aug 11 20:27:43 sornico kernel: hda: 39070080 sectors (20003 MB) w/1874KiB Cache, CHS=41344/15/63, UDMA(33)
Aug 11 20:27:43 sornico kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Aug 11 20:27:43 sornico kernel: mice: PS/2 mouse device common for all mice
Aug 11 20:27:43 sornico kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 11 20:27:43 sornico kernel: input: AT Set 2 keyboard on isa0060/serio0
Aug 11 20:27:43 sornico kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 11 20:27:43 sornico kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 11 20:27:43 sornico kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Aug 11 20:27:43 sornico kernel: TCP: Hash tables configured (established 32768 bind 65536)
Aug 11 20:27:43 sornico kernel: Linux IP multicast router 0.06 plus PIM-SM
Aug 11 20:27:43 sornico kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 20:27:43 sornico kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 20:27:43 sornico kernel: VFS: Mounted root (ext3 filesystem) readonly.
Aug 11 20:27:43 sornico kernel: Freeing unused kernel memory: 140k freed
Aug 11 20:27:43 sornico kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Aug 11 20:27:43 sornico kernel: Adding 514072k swap on /dev/hda3.  Priority:-1 extents:1
Aug 11 20:27:43 sornico kernel: EXT3 FS on hda2, internal journal
Aug 11 20:27:43 sornico kernel: Real Time Clock Driver v1.11
Aug 11 20:27:43 sornico kernel: drivers/usb/core/usb.c: registered new driver usbfs
Aug 11 20:27:43 sornico kernel: drivers/usb/core/usb.c: registered new driver hub
Aug 11 20:27:43 sornico kernel: drivers/usb/core/usb.c: registered new driver usbkbd
Aug 11 20:27:43 sornico kernel: drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
Aug 11 20:27:43 sornico kernel: parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
Aug 11 20:27:43 sornico kernel: lp0: using parport0 (polling).
Aug 11 20:27:43 sornico kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Aug 11 20:27:43 sornico kernel: uhci-hcd 0000:00:07.2: UHCI Host Controller
Aug 11 20:27:43 sornico kernel: uhci-hcd 0000:00:07.2: irq 11, io base 00001c20
Aug 11 20:27:43 sornico kernel: uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
Aug 11 20:27:43 sornico kernel: hub 1-0:0: USB hub found
Aug 11 20:27:43 sornico kernel: hub 1-0:0: 2 ports detected
Aug 11 20:27:43 sornico kernel: blk: queue d7cf5000, I/O limit 4095Mb (mask 0xffffffff)
Aug 11 20:27:44 sornico usb.agent[184]: missing kernel or user mode driver usbcore 
Aug 11 20:27:44 sornico kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Aug 11 20:27:44 sornico kernel: apm: overridden by ACPI.
Aug 11 20:27:47 sornico /usr/sbin/gpm[410]: *** info [startup.c(150)]: 
Aug 11 20:27:47 sornico /usr/sbin/gpm[410]: Started gpm successfully. Entered daemon mode.
Aug 11 20:27:48 sornico irattach: executing: '/sbin/modprobe irda0'
Aug 11 20:27:48 sornico irattach: + FATAL: Module irda0 not found.
Aug 11 20:27:48 sornico irattach: Trying to load module irda0 exited with status 1
Aug 11 20:27:48 sornico irattach: executing: 'echo sornico > /proc/sys/net/irda/devname'
Aug 11 20:27:48 sornico irattach: Setting devname to sornico exited with status 1
Aug 11 20:27:48 sornico irattach: executing: 'echo 1 > /proc/sys/net/irda/discovery'
Aug 11 20:27:48 sornico irattach: Setting discovery to 1 exited with status 1
Aug 11 20:27:48 sornico irattach: Starting device irda0
Aug 11 20:27:48 sornico irattach: ioctl(SIOCGIFFLAGS): No such device
Aug 11 20:27:48 sornico irattach: Stopping device irda0
Aug 11 20:27:48 sornico irattach: ioctl(SIOCGIFFLAGS): No such device
Aug 11 20:27:48 sornico irattach: exiting ... 
Aug 11 20:27:48 sornico kernel: Linux Kernel Card Services 3.1.22
Aug 11 20:27:48 sornico kernel:   options:  [pci] [cardbus] [pm]
Aug 11 20:27:48 sornico kernel: Intel PCIC probe: <6>pnp: Device 00:17 activated.
Aug 11 20:27:48 sornico kernel: 
Aug 11 20:27:48 sornico kernel:   Intel i82365sl DF ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
Aug 11 20:27:48 sornico kernel:     host opts [0]: none
Aug 11 20:27:48 sornico kernel:     host opts [1]: none
Aug 11 20:27:48 sornico kernel:     ISA irqs (scanned) = 3,4,5,7,10<6>    PCI card interrupts, polling interval = 1000 ms
Aug 11 20:27:49 sornico kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 11 20:27:49 sornico kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 11 20:27:49 sornico kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3e7 0x3f8-0x3ff 0x4d0-0x4d7
Aug 11 20:27:49 sornico kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 11 20:27:50 sornico kernel: IPv6 v0.8 for NET4.0
Aug 11 20:27:50 sornico kernel: Disabled Privacy Extensions on device c032c7a0(lo)
Aug 11 20:27:50 sornico kernel: IPv6 over IPv4 tunneling driver
Aug 11 20:27:51 sornico xfs: ignoring font path element /usr/lib/X11/fonts/CID/ (unreadable) 
Aug 11 20:27:51 sornico xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable) 
Aug 11 20:28:00 sornico kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Aug 11 20:28:00 sornico kernel: apm: overridden by ACPI.
Aug 11 20:28:17 sornico kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Aug 11 20:28:17 sornico kernel: apm: overridden by ACPI.
Aug 11 20:28:43 sornico kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Aug 11 20:28:43 sornico kernel: apm: overridden by ACPI.
Aug 11 20:28:50 sornico gpm: *** info [gpn.c(176)]: 
Aug 11 20:28:50 sornico gpm: Killed gpm(410).
Aug 11 20:28:53 sornico kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Aug 11 20:28:53 sornico kernel: apm: overridden by ACPI.
Aug 11 20:30:28 sornico gpm[903]: *** info [startup.c(150)]: 
Aug 11 20:30:28 sornico gpm[903]: Started gpm successfully. Entered daemon mode.
Aug 11 20:30:28 sornico gpm[903]: *** info [mice.c(1888)]: 
Aug 11 20:30:28 sornico gpm[903]: imps2: Auto-detected intellimouse PS/2
Aug 11 20:31:02 sornico gpm[915]: *** info [startup.c(150)]: 
Aug 11 20:31:02 sornico gpm[915]: Started gpm successfully. Entered daemon mode.
Aug 11 20:31:18 sornico kernel: cs: memory probe 0x0d0000-0x0dffff: clean.
Aug 11 20:31:18 sornico kernel: airo:  Probing for PCI adapters
Aug 11 20:31:18 sornico kernel: airo:  Finished probing for PCI adapters
Aug 11 20:31:19 sornico kernel: airo: MAC enabled eth0 0:40:96:40:f2:34
Aug 11 20:31:19 sornico kernel: eth0: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
Aug 11 20:31:19 sornico kernel: Call Trace:
Aug 11 20:31:19 sornico kernel:  [schedule+951/960] schedule+0x3b7/0x3c0
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6646892/8027045] issuecommand+0x5c/0x90 [airo]
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6648362/8027045] PC4500_accessrid+0x4a/0x90 [airo]
Aug 11 20:31:19 sornico kernel:  [error_code+45/56] error_code+0x2d/0x38
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6648529/8027045] PC4500_readrid+0x61/0x130 [airo]
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6637169/8027045] readStatsRid+0x31/0x50 [airo]
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6638887/8027045] airo_read_stats+0x67/0x150 [airo]
Aug 11 20:31:19 sornico kernel:  [find_get_page+44/96] find_get_page+0x2c/0x60
Aug 11 20:31:19 sornico kernel:  [filemap_nopage+654/800] filemap_nopage+0x28e/0x320
Aug 11 20:31:19 sornico kernel:  [avc_has_perm+118/140] avc_has_perm+0x76/0x8c
Aug 11 20:31:19 sornico kernel:  [buffered_rmqueue+209/368] buffered_rmqueue+0xd1/0x170
Aug 11 20:31:19 sornico kernel:  [vsnprintf+582/1136] vsnprintf+0x246/0x470
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6639142/8027045] airo_get_stats+0x16/0x20 [airo]
Aug 11 20:31:19 sornico kernel:  [dev_seq_printf_stats+235/256] dev_seq_printf_stats+0xeb/0x100
Aug 11 20:31:19 sornico kernel:  [dev_seq_show+40/144] dev_seq_show+0x28/0x90
Aug 11 20:31:19 sornico kernel:  [seq_read+477/784] seq_read+0x1dd/0x310
Aug 11 20:31:19 sornico kernel:  [vfs_read+236/336] vfs_read+0xec/0x150
Aug 11 20:31:19 sornico kernel:  [sys_read+66/112] sys_read+0x42/0x70
Aug 11 20:31:19 sornico kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 11 20:31:19 sornico kernel: 
Aug 11 20:31:19 sornico kernel: Call Trace:
Aug 11 20:31:19 sornico kernel:  [schedule+951/960] schedule+0x3b7/0x3c0
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6646892/8027045] issuecommand+0x5c/0x90 [airo]
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6648362/8027045] PC4500_accessrid+0x4a/0x90 [airo]
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6648529/8027045] PC4500_readrid+0x61/0x130 [airo]
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6637169/8027045] readStatsRid+0x31/0x50 [airo]
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6638887/8027045] airo_read_stats+0x67/0x150 [airo]
Aug 11 20:31:19 sornico kernel:  [vsnprintf+582/1136] vsnprintf+0x246/0x470
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6639142/8027045] airo_get_stats+0x16/0x20 [airo]
Aug 11 20:31:19 sornico kernel:  [dev_seq_printf_stats+235/256] dev_seq_printf_stats+0xeb/0x100
Aug 11 20:31:19 sornico kernel:  [dev_seq_show+40/144] dev_seq_show+0x28/0x90
Aug 11 20:31:19 sornico kernel:  [seq_read+477/784] seq_read+0x1dd/0x310
Aug 11 20:31:19 sornico kernel:  [vfs_read+236/336] vfs_read+0xec/0x150
Aug 11 20:31:19 sornico kernel:  [sys_read+66/112] sys_read+0x42/0x70
Aug 11 20:31:19 sornico kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 11 20:31:19 sornico kernel: 
Aug 11 20:31:19 sornico kernel: ------------[ cut here ]------------
Aug 11 20:31:19 sornico kernel: kernel BUG at kernel/workqueue.c:77!
Aug 11 20:31:19 sornico kernel: invalid operand: 0000 [#1]
Aug 11 20:31:19 sornico kernel: CPU:    0
Aug 11 20:31:19 sornico kernel: EIP:    0060:[queue_work+140/160]    Not tainted
Aug 11 20:31:19 sornico kernel: EFLAGS: 00010217
Aug 11 20:31:19 sornico kernel: EIP is at queue_work+0x8c/0xa0
Aug 11 20:31:19 sornico kernel: eax: 00000000   ebx: 00000000   ecx: d054c394   edx: d054c390
Aug 11 20:31:19 sornico kernel: esi: d054c390   edi: d3a38000   ebp: d7fdf8a0   esp: d3a39ce8
Aug 11 20:31:19 sornico kernel: ds: 007b   es: 007b   ss: 0068
Aug 11 20:31:19 sornico kernel: Process dhclient (pid: 941, threadinfo=d3a38000 task=d3aaf840)
Aug 11 20:31:19 sornico kernel: Stack: d054c37c d88d7cb0 d054c000 d054c220 d88d7df2 d7206140 d7229da4 c01a055a 
Aug 11 20:31:19 sornico kernel:        d1b0c9a0 c019ebc0 d77a73c4 d1b0c9a0 00000007 00000001 d7206158 d7206140 
Aug 11 20:31:19 sornico kernel:        d1b0c9a0 00000000 d77a73c4 c019f5a2 d1b0c9a0 d7206140 00000002 d77a73c4 
Aug 11 20:31:19 sornico kernel: Call Trace:
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6638784/8027045] airo_read_stats+0x0/0x150 [airo]
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6639106/8027045] airo_read_stats+0x142/0x150 [airo]
Aug 11 20:31:19 sornico kernel:  [__journal_file_buffer+410/656] __journal_file_buffer+0x19a/0x290
Aug 11 20:31:19 sornico kernel:  [do_get_write_access+704/1504] do_get_write_access+0x2c0/0x5e0
Aug 11 20:31:19 sornico kernel:  [journal_dirty_metadata+338/544] journal_dirty_metadata+0x152/0x220
Aug 11 20:31:19 sornico kernel:  [journal_stop+417/640] journal_stop+0x1a1/0x280
Aug 11 20:31:19 sornico kernel:  [ext3_mark_iloc_dirty+40/64] ext3_mark_iloc_dirty+0x28/0x40
Aug 11 20:31:19 sornico kernel:  [avc_has_perm+118/140] avc_has_perm+0x76/0x8c
Aug 11 20:31:19 sornico kernel:  [buffered_rmqueue+209/368] buffered_rmqueue+0xd1/0x170
Aug 11 20:31:19 sornico kernel:  [vsnprintf+582/1136] vsnprintf+0x246/0x470
Aug 11 20:31:19 sornico kernel:  [__crc_posix_acl_equiv_mode+6639142/8027045] airo_get_stats+0x16/0x20 [airo]
Aug 11 20:31:19 sornico kernel:  [dev_seq_printf_stats+235/256] dev_seq_printf_stats+0xeb/0x100
Aug 11 20:31:19 sornico kernel:  [dev_seq_show+40/144] dev_seq_show+0x28/0x90
Aug 11 20:31:19 sornico kernel:  [seq_read+477/784] seq_read+0x1dd/0x310
Aug 11 20:31:19 sornico kernel:  [vfs_read+236/336] vfs_read+0xec/0x150
Aug 11 20:31:19 sornico kernel:  [sys_read+66/112] sys_read+0x42/0x70
Aug 11 20:31:19 sornico kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 11 20:31:19 sornico kernel: 
Aug 11 20:31:19 sornico kernel: Code: 0f 0b 4d 00 70 16 2c c0 eb 90 8d 76 00 8d bc 27 00 00 00 00 
Aug 11 20:31:19 sornico kernel:  <6>note: dhclient[941] exited with preempt_count 2


--------------060803010108090907000605--

