Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTLSSZp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 13:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTLSSZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 13:25:45 -0500
Received: from ferengi.skynet.be ([195.238.2.126]:62662 "EHLO
	ferengi.skynet.be") by vger.kernel.org with ESMTP id S262114AbTLSSZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 13:25:30 -0500
Message-ID: <3FE34297.9020007@pimpinc.net>
Date: Fri, 19 Dec 2003 19:25:27 +0100
From: Jean-Philippe Woot de Trixhe <Debian@pimpinc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Federico Freire <fedekapo@speedy.com.ar>,
       linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM
References: <200312191506.31367.fedekapo@speedy.com.ar>
In-Reply-To: <200312191506.31367.fedekapo@speedy.com.ar>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (ferengi.skynet.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Federico Freire wrote:

>This is my first bug reporting so sorry if I give you the wrong information... 
>and sorry for my english.
>
>I have a CREATIVE CD-RW 8432 and I get an error when I try to use it aprox 10 
>minutes after I boot... I can't mount it, or record, etc. When I do dmesg I 
>get this over and over again:
>
>hdc: lost interrupt
>hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>
>I googled but I didn't find anything about this...
>
>This is the output of ver_linux:
>--------------------------------------------
>If some fields are empty or look unusual you may have an old version.
>Compare to the current minimal requirements in Documentation/Changes.
>
>Linux GentooBox 2.6.0-gentoo #4 SMP Fri Dec 19 01:21:16 ART 2003 i686 AMD 
>Athlon(tm) XP 2400+ AuthenticAMD GNU/Linux
>
>Gnu C                  3.2.3
>Gnu make               3.80
>util-linux             2.11z
>mount                  2.11z
>module-init-tools      0.9.12
>e2fsprogs              1.33
>PPP                    2.4.1
>Linux C Library        2.3.2
>Dynamic linker (ldd)   2.3.2
>Procps                 3.1.12
>Net-tools              1.60
>Kbd                    1.06
>Sh-utils               5.0
>Modules Loaded         snd_seq_midi snd_emu10k1_synth snd_emux_synth 
>snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec 
>snd_util_mem snd_hwdep snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device 
>snd_pcm_oss snd_pcm snd_page_alloc snd_timer snd_mixer_oss snd soundcore rtc 
>nls_iso8859_1 ntfs w83781d eeprom i2c_isa i2c_sensor i2c_dev i2c_core 
>quickcam videodev hid ehci_hcd uhci_hcd usbcore nvidia 8139too ide_cd cdrom
>-------------------------------
>
>I've been using kernel-2.6 since test10 and the bug is there since I tried 
>it...
>I've dma enabled but when I disabled it I get the same error..
>
>
>This is my dmesg:
>------------------------------------
>
>Calibrating delay loop... 3858.43 BogoMIPS
>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
>checking if image is initramfs...it isn't (ungzip failed); looks like an 
>initrd
>Freeing initrd memory: 40k freed
>CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
>CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
>CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f
>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
>CPU: L2 Cache: 256K (64 bytes/line)
>CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>POSIX conformance testing by UNIFIX
>CPU0: AMD Athlon(tm) XP 2400+ stepping 01
>per-CPU timeslice cutoff: 731.41 usecs.
>task migration cache decay timeout: 1 msecs.
>enabled ExtINT on CPU#0
>ESR value before enabling vector: 00000080
>ESR value after enabling vector: 00000000
>Total of 1 processors activated (3858.43 BogoMIPS).
>ENABLING IO-APIC IRQs
>init IO_APIC IRQs
> IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not 
>connected.
>..TIMER: vector=0x31 pin1=2 pin2=-1
>number of MP IRQ sources: 15.
>number of IO-APIC #2 registers: 24.
>testing the IO APIC.......................
>IO APIC #2......
>.... register #00: 02000000
>.......    : physical APIC id: 02
>.......    : Delivery Type: 0
>.......    : LTS          : 0
>.... register #01: 00178003
>.......     : max redirection entries: 0017
>.......     : PRQ implemented: 1
>.......     : IO APIC version: 0003
>.... IRQ redirection table:
> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
> 00 000 00  1    0    0   0   0    0    0    00
> 01 001 01  0    0    0   0   0    1    1    39
> 02 001 01  0    0    0   0   0    1    1    31
> 03 001 01  0    0    0   0   0    1    1    41
> 04 001 01  0    0    0   0   0    1    1    49
> 05 001 01  0    0    0   0   0    1    1    51
> 06 001 01  0    0    0   0   0    1    1    59
> 07 001 01  0    0    0   0   0    1    1    61
> 08 001 01  0    0    0   0   0    1    1    69
> 09 001 01  1    1    0   1   0    1    1    71
> 0a 001 01  0    0    0   0   0    1    1    79
> 0b 001 01  0    0    0   0   0    1    1    81
> 0c 001 01  0    0    0   0   0    1    1    89
> 0d 001 01  0    0    0   0   0    1    1    91
> 0e 001 01  0    0    0   0   0    1    1    99
> 0f 001 01  0    0    0   0   0    1    1    A1
> 10 000 00  1    0    0   0   0    0    0    00
> 11 000 00  1    0    0   0   0    0    0    00
> 12 000 00  1    0    0   0   0    0    0    00
> 13 000 00  1    0    0   0   0    0    0    00
> 14 000 00  1    0    0   0   0    0    0    00
> 15 000 00  1    0    0   0   0    0    0    00
> 16 000 00  1    0    0   0   0    0    0    00
> 17 000 00  1    0    0   0   0    0    0    00
>IRQ to pin mappings:
>IRQ0 -> 0:2
>IRQ1 -> 0:1
>IRQ3 -> 0:3
>IRQ4 -> 0:4
>IRQ5 -> 0:5
>IRQ6 -> 0:6
>IRQ7 -> 0:7
>IRQ8 -> 0:8
>IRQ9 -> 0:9
>IRQ10 -> 0:10
>IRQ11 -> 0:11
>IRQ12 -> 0:12
>IRQ13 -> 0:13
>IRQ14 -> 0:14
>IRQ15 -> 0:15
>.................................... done.
>Using local APIC timer interrupts.
>calibrating APIC timer ...
>..... CPU clock speed is 1960.0714 MHz.
>..... host bus clock speed is 340.0993 MHz.
>Starting migration thread for cpu 0
>CPUS done 8
>NET: Registered protocol family 16
>PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
>PCI: Using configuration type 1
>mtrr: v2.0 (20020519)
>ACPI: Subsystem revision 20031002
>IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
>ACPI: Interpreter enabled
>ACPI: Using IOAPIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (00:00)
>PCI: Probing PCI hardware (bus 00)
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: Power Resource [URP1] (off)
>ACPI: Power Resource [URP2] (off)
>ACPI: Power Resource [FDDP] (off)
>ACPI: Power Resource [LPTP] (off)
>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 *12 14 15)
>Linux Plug and Play Support v0.97 (c) Adam Belay
>IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
>00:00:01[A] -> 2-16 -> IRQ 16
>IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
>00:00:01[B] -> 2-17 -> IRQ 17
>IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:1)
>00:00:11[C] -> 2-22 -> IRQ 22
>Pin 2-16 already programmed
>Pin 2-17 already programmed
>IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
>00:00:05[C] -> 2-18 -> IRQ 18
>IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc9 -> IRQ 19 Mode:1 Active:1)
>00:00:05[D] -> 2-19 -> IRQ 19
>Pin 2-17 already programmed
>Pin 2-18 already programmed
>Pin 2-19 already programmed
>Pin 2-16 already programmed
>Pin 2-18 already programmed
>Pin 2-19 already programmed
>Pin 2-16 already programmed
>Pin 2-17 already programmed
>Pin 2-19 already programmed
>Pin 2-16 already programmed
>Pin 2-17 already programmed
>Pin 2-18 already programmed
>Pin 2-17 already programmed
>Pin 2-18 already programmed
>Pin 2-19 already programmed
>Pin 2-16 already programmed
>Pin 2-18 already programmed
>Pin 2-19 already programmed
>Pin 2-16 already programmed
>Pin 2-17 already programmed
>IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
>00:00:10[A] -> 2-21 -> IRQ 21
>Pin 2-21 already programmed
>Pin 2-21 already programmed
>Pin 2-21 already programmed
>IOAPIC[0]: Set PCI routing entry (2-23 -> 0xd9 -> IRQ 23 Mode:1 Active:1)
>00:00:12[A] -> 2-23 -> IRQ 23
>Pin 2-18 already programmed
>ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
>PCI: Using ACPI for IRQ routing
>PCI: if you experience problems, try using option 'pci=noacpi' or even 
>'acpi=off'
>vesafb: framebuffer at 0xd0000000, mapped to 0xd080b000, size 16384k
>vesafb: mode is 1024x768x16, linelength=2048, pages=0
>vesafb: protected mode interface info at c000:0f3e
>vesafb: scrolling: redraw
>vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
>fb0: VESA VGA frame buffer device
>Machine check exception polling timer started.
>devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
>devfs: boot_options: 0x1
>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>udf: registering filesystem
>PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 5
>PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
>ACPI: Power Button (FF) [PWRF]
>ACPI: Sleep Button (CM) [SLPB]
>ACPI: Processor [CPU1] (supports C1, 16 throttling states)
>bootsplash 3.1.3-2003/11/14: looking for picture.... silentjpeg size 21768 
>bytes, found (1024x768, 20089 bytes, v3).
>Console: switching to colour frame buffer device 122x40
>pty: 256 Unix98 ptys configured
>Linux agpgart interface v0.100 (c) Dave Jones
>agpgart: Detected VIA KT266/KY266x/KT333 chipset
>agpgart: Maximum main memory to use for agp memory: 203M
>agpgart: AGP aperture is 128M @ 0xe0000000
>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>Using anticipatory io scheduler
>Floppy drive(s): fd0 is 1.44M
>FDC 0 is a post-1991 82077
>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>loop: loaded (max 8 devices)
>PPP generic driver version 2.4.2
>PPP Deflate Compression module registered
>PPP BSD Compression module registered
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>VP_IDE: IDE controller at PCI slot 0000:00:11.1
>ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
>VP_IDE: chipset revision 6
>VP_IDE: not 100% native mode: will probe irqs later
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
>    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
>    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
>hda: Maxtor 6E040L0, ATA DISK drive
>hdb: SAMSUNG SV2044D, ATA DISK drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>hdc: CREATIVE CD-RW RW8435E, ATAPI CD/DVD-ROM drive
>ide1 at 0x170-0x177,0x376 on irq 15
>hda: max request size: 128KiB
>hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
> /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
>hdb: max request size: 128KiB
>hdb: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=39546/16/63, UDMA(66)
> /dev/ide/host0/bus0/target1/lun0: p1
>Console: switching to colour frame buffer device 122x40
>mice: PS/2 mouse device common for all mice
>serio: i8042 AUX port at 0x60,0x64 irq 12
>input: AT Translated Set 2 keyboard on isa0060/serio0
>serio: i8042 KBD port at 0x60,0x64 irq 1
>NET: Registered protocol family 2
>IP: routing cache hash table of 2048 buckets, 16Kbytes
>TCP: Hash tables configured (established 16384 bind 16384)
>NET: Registered protocol family 1
>NET: Registered protocol family 17
>ACPI: (supports S0 S1 S4 S5)
>RAMDISK: Couldn't find valid RAM disk image starting at 0.
>found reiserfs format "3.6" with standard journal
>Reiserfs journal params: device hda3, size 8192, journal first block 18, max 
>trans len 1024, max batch 900, max commit age 30, max trans age 30
>reiserfs: checking transaction log (hda3) for (hda3)
>Using r5 hash to sort names
>VFS: Mounted root (reiserfs filesystem) readonly.
>Mounted devfs on /dev
>Freeing unused kernel memory: 168k freed
>Adding 248996k swap on /dev/hda2.  Priority:-1 extents:1
>hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, DMA
>Uniform CD-ROM driver Revision: 3.12
>8139too Fast Ethernet driver 0.9.26
>eth0: RealTek RTL8139 at 0xd1a95f00, 00:e0:7d:db:05:59, IRQ 17
>eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
>nvidia: no version magic, tainting kernel.
>nvidia: module license 'NVIDIA' taints kernel.
>0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 
>16 19:03:09 PDT 2003
>drivers/usb/core/usb.c: registered new driver usbfs
>drivers/usb/core/usb.c: registered new driver hub
>drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
>v2.1
>uhci_hcd 0000:00:10.0: UHCI Host Controller
>uhci_hcd 0000:00:10.0: irq 21, io base 0000dc00
>uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
>hub 1-0:1.0: USB hub found
>hub 1-0:1.0: 2 ports detected
>uhci_hcd 0000:00:10.1: UHCI Host Controller
>uhci_hcd 0000:00:10.1: irq 21, io base 0000e000
>uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
>hub 2-0:1.0: USB hub found
>hub 2-0:1.0: 2 ports detected
>uhci_hcd 0000:00:10.2: UHCI Host Controller
>uhci_hcd 0000:00:10.2: irq 21, io base 0000e400
>uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
>hub 3-0:1.0: USB hub found
>hub 3-0:1.0: 2 ports detected
>ehci_hcd 0000:00:10.3: EHCI Host Controller
>ehci_hcd 0000:00:10.3: irq 21, pci mem d1a97e00
>ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
>ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
>hub 4-0:1.0: USB hub found
>hub 4-0:1.0: 6 ports detected
>drivers/usb/core/usb.c: registered new driver hid
>drivers/usb/input/hid-core.c: v2.0:USB HID core driver
>Linux video capture interface: v1.00
>quickcam: no version magic, tainting kernel.
>quickcam [49.207223]: ----------LOADING QUICKCAM MODULE------------
>quickcam [49.207228]: struct quickcam size: 5548
>drivers/usb/core/usb.c: registered new driver quickcam
>i2c /dev entries driver
>registering 0-0290
>NTFS driver 2.1.5 [Flags: R/O MODULE].
>NTFS volume version 3.0.
>hub 1-0:1.0: new USB device on port 1, assigned address 2
>quickcam: QuickCam USB camera found (driver version QuickCam USB $Date: 
>2003/10/30 11:16:49 $)
>Module quickcam cannot be unloaded due to unsafe usage in 
>include/linux/module.h:483
>quickcam: Sensor HDCS-1000/1100 detected
>videodev: "QuickCam USB" has no release callback. Please fix your driver for 
>proper sysfs support, see http://lwn.net/Articles/36850/
>hub 1-0:1.0: new USB device on port 2, assigned address 3
>input: USB HID v1.00 Mouse [HP HP USB WHEEL MOUSE] on usb-0000:00:10.0-2
>Real Time Clock Driver v1.12
>blk: queue cfc5ae00, I/O limit 4095Mb (mask 0xffffffff)
>blk: queue cfc5aa00, I/O limit 4095Mb (mask 0xffffffff)
>eth0: link up, 10Mbps, half-duplex, lpa 0x0000
>bootsplash 3.1.3-2003/11/14: looking for picture.... found (1024x768, 20089 
>bytes, v3).
>bootsplash: status on console 0 changed to on
>bootsplash 3.1.3-2003/11/14: looking for picture.... found (1024x768, 20089 
>bytes, v3).
>bootsplash: status on console 1 changed to on
>bootsplash 3.1.3-2003/11/14: looking for picture.... found (1024x768, 20089 
>bytes, v3).
>bootsplash: status on console 2 changed to on
>bootsplash 3.1.3-2003/11/14: looking for picture.... found (1024x768, 20089 
>bytes, v3).
>bootsplash: status on console 3 changed to on
>bootsplash 3.1.3-2003/11/14: looking for picture.... found (1024x768, 20089 
>bytes, v3).
>bootsplash: status on console 4 changed to on
>bootsplash 3.1.3-2003/11/14: looking for picture.... found (1024x768, 20089 
>bytes, v3).
>bootsplash: status on console 5 changed to on
>Debug: sleeping function called from invalid context at mm/slab.c:1856
>in_atomic():1, irqs_disabled():0
>Call Trace:
> [<c0122a2b>] __might_sleep+0xab/0xd0
> [<c0149340>] kmem_cache_alloc+0x70/0x80
> [<c0159661>] __get_vm_area+0x21/0x150
> [<c01597c3>] get_vm_area+0x33/0x40
> [<c011e6a3>] __ioremap+0xb3/0x100
> [<c0145492>] buffered_rmqueue+0xe2/0x190
> [<c011e719>] ioremap_nocache+0x29/0xb0
> [<d1c9169a>] os_map_kernel_space+0x68/0x6c [nvidia]
> [<c01595db>] map_vm_area+0x6b/0xd0
> [<d1ca3ce7>] __nvsym00568+0x1f/0x2c [nvidia]
> [<d1ca5e06>] __nvsym00775+0x6e/0xe0 [nvidia]
> [<d1ca5e96>] __nvsym00781+0x1e/0x190 [nvidia]
> [<d1ca791c>] rm_init_adapter+0xc/0x10 [nvidia]
> [<d1c8de48>] nv_kern_open+0x122/0x26d [nvidia]
> [<c016943c>] chrdev_open+0x12c/0x2c0
> [<c01cb34e>] devfs_open+0x11e/0x140
> [<c015e7ca>] dentry_open+0x15a/0x240
> [<c015e666>] filp_open+0x66/0x70
> [<c015ebb3>] sys_open+0x53/0x90
> [<c010b69b>] syscall_call+0x7/0xb
>
>Debug: sleeping function called from invalid context at mm/slab.c:1856
>in_atomic():1, irqs_disabled():0
>Call Trace:
> [<c0122a2b>] __might_sleep+0xab/0xd0
> [<c028baef>] generic_unplug_device+0x8f/0xa0
> [<c0149340>] kmem_cache_alloc+0x70/0x80
> [<c0159661>] __get_vm_area+0x21/0x150
> [<c01597c3>] get_vm_area+0x33/0x40
> [<c011e6a3>] __ioremap+0xb3/0x100
> [<c0145492>] buffered_rmqueue+0xe2/0x190
> [<c011e719>] ioremap_nocache+0x29/0xb0
> [<d1c9169a>] os_map_kernel_space+0x68/0x6c [nvidia]
> [<c01595db>] map_vm_area+0x6b/0xd0
> [<d1ca3ce7>] __nvsym00568+0x1f/0x2c [nvidia]
> [<d1ca5e06>] __nvsym00775+0x6e/0xe0 [nvidia]
> [<d1ca5e96>] __nvsym00781+0x1e/0x190 [nvidia]
> [<d1ca791c>] rm_init_adapter+0xc/0x10 [nvidia]
> [<d1c8de48>] nv_kern_open+0x122/0x26d [nvidia]
> [<c016943c>] chrdev_open+0x12c/0x2c0
> [<c01cb34e>] devfs_open+0x11e/0x140
> [<c015e7ca>] dentry_open+0x15a/0x240
> [<c015e666>] filp_open+0x66/0x70
> [<c015ebb3>] sys_open+0x53/0x90
> [<c010b69b>] syscall_call+0x7/0xb
>
>agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
>agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
>agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
>
>hdc: lost interrupt
>hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>hdc: lost interrupt
>hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>hdc: lost interrupt
>hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>hdc: lost interrupt
>hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>hdc: lost interrupt
>hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>hdc: lost interrupt
>
>----------------------
>I hope that help...
>
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Did you try to mount /dev/cdrom or /dev/hdc ? because your CD-R/RW drive 
is set as hdc...

>>> hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, DMA
>

