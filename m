Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317789AbSGKIHm>; Thu, 11 Jul 2002 04:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317790AbSGKIHl>; Thu, 11 Jul 2002 04:07:41 -0400
Received: from web20402.mail.yahoo.com ([66.163.169.90]:1353 "HELO
	web20414.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317789AbSGKIHi>; Thu, 11 Jul 2002 04:07:38 -0400
Message-ID: <20020711081024.58052.qmail@web20414.mail.yahoo.com>
Date: Thu, 11 Jul 2002 10:10:24 +0200 (CEST)
From: =?iso-8859-1?q?Henning=20Petersen?= <castrolmanden2@yahoo.com>
Subject: Fwd: unhandled interrupt: 0xff63fc7f crash with emu10k1/soundblaster live value card
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
==

As I am uncertain that this mail address for Alan Cox is real or not,
I'll send this message to 

linux-kernel@vger.kernel.org

- as well. I hope that this gets through to the right person anyway.

 Regards, Henning Petersen


 --- Henning Petersen <castrolmanden2@yahoo.com> skrev: > Dato: Mon, 8
Jul 2002 23:03:04 +0200 (CEST)
> Fra: Henning Petersen <castrolmanden2@yahoo.com>
> Emne: unhandled interrupt: 0xff63fc7f crash with emu10k1/soundblaster
> live value card
> Til: emu10k1-devel@opensource.creative.com
> 
> Hi developers
> =============
> 
> I have a weird crash happening when using sound and X at the same
> time.
> 
> 1.) I boot up my debian 2.4.18 kernel (see dmesg output)
> 2.) kdm starts up X
> 3.) I run : depmod -a, modprobe emu10k1 as root
> 4.) When I have used the sound card with for example xine or
> realplayer, I can't shift to one of the virtual consoles
> (ctrl-alt-f1)
> without getting a crash, reporting this: warning, unhandled interrupt
> 0xff63fc7f
> 
> I can't shutdown the machine either; it's like it hanging in a loop
> reporting these 'unhandled interrupts' or so...
> 
> As long as I don't try to close/reboot the machine, or go into a
> non-X
> state, it works.
> 
> Now, I can disable the display manager and use 'startx' to come into
> X.
> This works, but if I run 'depmod -a; modprobe emu10k1' first, X
> reports
> 
> 
> '(WW) VGA: No matching Device section for instance (BusID PCI:0:12:0)
> found
> (WW) VGA: No matching Device section for instance (BusID PCI:1:0:0)
> found'
> 
> In fact my soundblaster live value card did this before with an
> AMD-K6-3D 400MHz processor as well; it seems that the soundcard wants
> some resource that is necessary to run the X-server??
> 
> I hope you can use this; keep up your good work!
> 
>  Regards, Henning Petersen
> 
> 
> ---------------------------
> STUFF HERE
> ---------------------------
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> This is a pre-release version of XFree86, and is not supported in any
> way.  Bugs may be reported to XFree86@XFree86.Org and patches
> submitted
> to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
> please check the latest version in the XFree86 CVS repository
> (http://www.XFree86.Org/cvs)
> 
> XFree86 Version 4.1.0.1 / X Window System
> (protocol Version 11, revision 0, vendor release 6510)
> Release Date: 21 December 2001
>         If the server is older than 6-12 months, or if your card is
>         newer than the above date, look for a newer version before
>         reporting problems.  (See http://www.XFree86.Org/FAQ)
> Build Operating System: Linux 2.4.13 i686 [ELF] 
> Module Loader present
> (==) Log file: "/var/log/XFree86.0.log", Time: Mon Jul  8 20:47:01
> 2002
> (==) Using config file: "/root/XF86Config"
> Markers: (--) probed, (**) from config file, (==) default setting,
>          (++) from command line, (!!) notice, (II) informational,
>          (WW) warning, (EE) error, (NI) not implemented, (??)
> unknown.
> (==) ServerLayout "Simple Layout"
> (**) |-->Screen "Screen 1" (0)
> (**) |   |-->Monitor "My Monitor"
> (**) |   |-->Device "2 the Max MAXColor S3 Trio64V+"
> (**) |-->Input Device "Mouse1"
> (**) |-->Input Device "Keyboard1"
> (**) XKB: rules: "xfree86"
> (**) XKB: model: "pc105"
> (**) XKB: layout: "dk"
> (**) FontPath set to
> "/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75
>
dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts
>
/Type1/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
> (**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
> (==) ModulePath set to "/usr/X11R6/lib/modules"
> (--) using VT number 7
> 
> (II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
> (II) Module bitmap: vendor="The XFree86 Project"
>         compiled for 4.1.0.1, module version = 1.0.0
> (II) Loading /usr/X11R6/lib/modules/libpcidata.a
> (II) Module pcidata: vendor="The XFree86 Project"
>         compiled for 4.1.0.1, module version = 0.1.0
> (II) Loading /usr/X11R6/lib/modules/libscanpci.a
> (II) Module scanpci: vendor="The XFree86 Project"
>         compiled for 4.1.0.1, module version = 0.1.0
> (II) Unloading /usr/X11R6/lib/modules/libscanpci.a
> (!!) More than one primary device found
> (--) PCI: (0:11:0) BrookTree unknown chipset (0x036e) rev 17, Mem @
> 0xef001000/1
> 2
> (--) PCI: (0:12:0) Creative Labs unknown chipset (0x0002) rev 8, I/O
> @
> 0xd400/5
> (--) PCI: (1:0:0) NVidia GeForce3 (rev 1) rev 163, Mem @
> 0xec000000/24,
> 0xe40000
> 00/26, 0xe8000000/19
> (II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
> (II) Module dbe: vendor="The XFree86 Project"
>         compiled for 4.1.0.1, module version = 1.0.0
> (II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
> (II) Module extmod: vendor="The XFree86 Project"
>         compiled for 4.1.0.1, module version = 1.0.0
> (II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
> (II) Module type1: vendor="The XFree86 Project"
>         compiled for 4.1.0.1, module version = 1.0.0
> (II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
> (II) Module freetype: vendor="The XFree86 Project"
>         compiled for 4.1.0.1, module version = 1.1.9
> (II) Loading /usr/X11R6/lib/modules/drivers/vga_drv.o
> (II) Module vga: vendor="The XFree86 Project"
>         compiled for 4.1.0.1, module version = 4.0.0
> (II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
> (II) Module mouse: vendor="The XFree86 Project"
>         compiled for 4.1.0.1, module version = 1.0.0
> (II) VGA: Generic VGA driver (version 4.0) for chipsets: generic
> (WW) VGA: No matching Device section for instance (BusID PCI:0:12:0)
> found
> (WW) VGA: No matching Device section for instance (BusID PCI:1:0:0)
> found
> (EE) No devices detected.
> 
> Fatal server error:
> no screens found
> 
> When reporting a problem related to a server crash, please send
> the full server output, not just the last messages.
> This can be found in the log file "/var/log/XFree86.0.log".
> Please report problems to submit@bugs.debian.org.
> 
> XIO:  fatal IO error 104 (Connection reset by peer) on X server
> ":0.0"
>       after 0 requests (0 known processed) with 0 events remaining.
> 
> 
> 
> 
> 
> 
> Linux version 2.4.18 (root@Tyr2) (gcc version 2.95.4 (Debian
> prerelease)) #1 SMP Sun Jun 16 00:15:13 CEST 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
>  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
>  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> On node 0 totalpages: 131056
> zone(0): 4096 pages.
> zone(1): 126960 pages.
> zone(2): 0 pages.
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
> Kernel command line: BOOT_IMAGE=hpkerne2 ro root=305 hdc=ide-scsi
> ide_setup: hdc=ide-scsi
> Initializing CPU#0
> Detected 1544.691 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 3080.19 BogoMIPS
> Memory: 512536k/524224k available (1806k kernel code, 11300k
> reserved,
> 545k data, 252k init, 0k highmem)
> Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
> CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
> CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
> CPU0: AMD Athlon(tm) XP 1800+ stepping 02
> per-CPU timeslice cutoff: 731.51 usecs.
> SMP motherboard not detected.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1544.6652 MHz.
> ..... host bus clock speed is 268.6374 MHz.
> cpu: 0, clocks: 2686374, slice: 1343187
> CPU0<T0:2686368,T1:1343168,D:13,S:1343187,C:2686374>
> Waiting on wait_init_idle (map = 0x0)
> All processors have done init_idle
> PCI: PCI BIOS revision 2.10 entry at 0xfb260, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Unknown bridge resource 0: assuming transparent
> PCI: Using IRQ router default [1106/3099] at 00:00.0
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> Journalled Block Device driver loaded
> NTFS driver v1.1.22 [Flags: R/O]
> udf: registering filesystem
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> Real Time Clock Driver v1.10e
> block: 128 slots per queue, batch=32
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 89
> PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try
> using pci=biosirq.
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: Unknown VIA SouthBridge, contact Vojtech Pavlik
> <vojtech@suse.cz>
> hda: WDC WD400BB-32CFC0, ATA DISK drive
> hdc: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
> hdd: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide0: probed IRQ 14 failed, using default.
> ide1 at 0x170-0x177,0x376 on irq 15
> ide1: probed IRQ 15 failed, using default.
> hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
> hdd: ATAPI 40X DVD-ROM drive, 256kB Cache
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >
> Loading I2O Core - (c) Copyright 1999 Red Hat Software
> Linux I2O PCI support (c) 1999 Red Hat Software.
> i2o: Checking for PCI I2O controllers...
> I2O configuration manager v 0.04.
>   (C) Copyright 1999 Red Hat Software
> I2O Block Storage OSM v0.9
>    (c) Copyright 1999-2001 Red Hat Software.
> i2o_block: Checking for Boot device...
> i2o_block: Checking for I2O Block devices...
> I2O LAN OSM (C) 1999 University of Helsinki.
> 8139too Fast Ethernet driver 0.9.24
> eth0: RealTek RTL8139 Fast Ethernet at 0xe080d000, 00:50:fc:4b:fd:26,
> IRQ 11
> eth0:  Identified 8139 chip type 'RTL-8139C'
> Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: Detected Via Apollo Pro KT266 chipset
> agpgart: AGP aperture is 64M @ 0xe0000000
> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.05
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> uhci.c: USB Universal Host Controller Interface driver v1.1
> uhci.c: USB UHCI at I/O 0xe000, IRQ 5
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> uhci.c: USB UHCI at I/O 0xe400, IRQ 5
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> i2o_scsi.c: Version 0.0.1
>   chain_pool: 0 bytes @ dfee7e80
>   (512 byte buffers X 4 can_queue X 0 i2o controllers)
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> IPv4 over IPv4 tunneling driver
> GRE over IPv4 tunneling driver
> ip_conntrack (4095 buckets, 32760 max)
> ip_tables: (C) 2000-2002 Netfilter core team
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 252k freed
> Adding Swap: 497972k swap-space (priority -1)
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
> nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2802  Tue Mar  5
> 06:26:45 PST 2002
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,7), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> eth0: Setting half-duplex based on auto-negotiated partner ability
> 0000.
> spurious 8259A interrupt: IRQ7.
> NVRM: AGPGART: VIA Apollo KT133 chipset
> NVRM: AGPGART: aperture: 64M @ 0xe0000000
> NVRM: AGPGART: aperture mapped from 0xe0000000 to 0xe1988000
> NVRM: AGPGART: mode 4x
> NVRM: AGPGART: allocated 16 pages
> Creative EMU10K1 PCI Audio Driver, version 0.18, 23:08:05 Jul  8 2002
> PCI: Enabling device 00:0c.0 (0000 -> 0001)
> emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xd400-0xd41f, IRQ
> 11
> ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> =====
> o   O      Hennings tog              \ | / 
>          o  O   OO                             - (_) -
>             ___      ===========  ===========   / | \
>       _U___|o|  ...  [ U U U U ]  [ U U U U ]        
>       L______| [___] [_________]  [_________]
>        oo OOO  oo oo  oo     oo    oo     oo  
> ==================================================
> 
> _____________________________________________________
> Følg VM i fodbold på tæt hold fra Yahoo!s officielle VM-side 
> www.yahoo.dk/vm2002
>  

_____________________________________________________
Få den nye Yahoo! Messenger på www.yahoo.dk/messenger
Nu med webkamera, talechat, interaktive baggrunde og meget mere!
