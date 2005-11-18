Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbVKRJQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVKRJQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 04:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbVKRJQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 04:16:07 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:3230 "EHLO pilet.ens-lyon.fr")
	by vger.kernel.org with ESMTP id S932624AbVKRJQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 04:16:04 -0500
Date: Fri, 18 Nov 2005 10:13:18 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-rc1-mm2
Message-ID: <20051118091318.GA18493@ens-lyon.fr>
References: <20051117234645.4128c664.akpm@osdl.org> <40f323d00511180056i5bafa5c3qffbd3b774b499ac4@mail.gmail.com> <20051118010449.4ecc9c1d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20051118010449.4ecc9c1d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 18, 2005 at 01:04:49AM -0800, Andrew Morton wrote:
> Benoit Boissinot <benoit.boissinot@ens-lyon.fr> wrote:
> >
> > On 11/18/05, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm2/
> > >
> > >
> > > - I'm releasing this so that Hugh's MM rework can get a spin.
> > >
> > >   Anyone who had post-2.6.14 problems related to the VM_RESERVED changes
> > >   (device drivers malfunctioning, obscure userspace hardware-poking
> > >   applications stopped working, etc) please test.
> > >
> > >   We'd especially like testing of the graphics DRM drivers across as many
> > >   card types as poss.
> > >
> > I tried running neverball and had "bad page state".
> 
> OK, thanks for that.
> 
> > dmesg and lspci -v attached
> 
> The attachments are empty.   Can you resend the dmesg one please?
[this time with mutt :)]

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.log"

79569.184000] Allocating PCI resources starting at 30000000 (gap: 20000000:deda0000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[17179569.184000] mapped APIC to ffffd000 (01401000)
[17179569.184000] Enabling fast FPU save and restore... done.
[17179569.184000] Enabling unmasked SIMD FPU exception support... done.
[17179569.184000] Initializing CPU#0
[17179569.184000] Kernel command line: root=/dev/hda5 video=vesa:mtrr vga=0x317 resume=/dev/hda3
[17179569.184000] CPU 0 irqstacks, hard=c03f6000 soft=c03f5000
[17179569.184000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 1598.810 MHz processor.
[    7.254473] Using tsc for high-res timesource
[    7.254509] Console: colour dummy device 80x25
[    7.255211] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    7.255967] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    7.270625] Memory: 515192k/523960k available (2156k kernel code, 8200k reserved, 666k data, 180k init, 0k highmem)
[    7.270637] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    7.349085] Calibrating delay using timer specific routine.. 3201.13 BogoMIPS (lpj=6402260)
[    7.349127] Mount-cache hash table entries: 512
[    7.349227] CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
[    7.349235] CPU: After vendor identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
[    7.349244] CPU: L1 I cache: 32K, L1 D cache: 32K
[    7.349249] CPU: L2 cache: 2048K
[    7.349252] CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
[    7.349258] Intel machine check architecture supported.
[    7.349264] Intel machine check reporting enabled on CPU#0.
[    7.349276] mtrr: v2.0 (20020519)
[    7.349282] CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 06
[    7.349290] Checking 'hlt' instruction... OK.
[    7.377767] ACPI: setting ELCR to 0200 (from 0800)
[    7.380359] NET: Registered protocol family 16
[    7.380383] ACPI: bus type pci registered
[    7.380391] PCI: Using configuration type 1
[    7.380743] ACPI: Subsystem revision 20050916
[    7.396488] ACPI: Interpreter enabled
[    7.396493] ACPI: Using PIC for interrupt routing
[    7.397710] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    7.397716] PCI: Probing PCI hardware (bus 00)
[    7.397839] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[    7.408319] PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
[    7.408326] PCI quirk: region 0880-08bf claimed by ICH4 GPIO
[    7.408372] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    7.408484] Boot video device is 0000:01:00.0
[    7.408715] PCI: Transparent bridge - 0000:00:1e.0
[    7.408814] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    7.431144] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
[    7.431385] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
[    7.431624] ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
[    7.431861] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
[    7.432092] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    7.432335] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    7.433534] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[    7.434240] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
[    7.435197] Linux Plug and Play Support v0.97 (c) Adam Belay
[    7.435208] pnp: PnP ACPI init
[    7.463911] pnp: PnP ACPI: found 13 devices
[    7.463954] Generic PHY: Registered new driver
[    7.464044] SCSI subsystem initialized
[    7.464073] PCI: Using ACPI for IRQ routing
[    7.464078] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    7.469176] pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
[    7.469181] pnp: 00:02: ioport range 0x800-0x805 could not be reserved
[    7.469186] pnp: 00:02: ioport range 0x808-0x80f could not be reserved
[    7.469193] pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
[    7.469197] pnp: 00:03: ioport range 0x806-0x807 has been reserved
[    7.469202] pnp: 00:03: ioport range 0x810-0x85f could not be reserved
[    7.469207] pnp: 00:03: ioport range 0x860-0x87f has been reserved
[    7.469211] pnp: 00:03: ioport range 0x880-0x8bf has been reserved
[    7.469216] pnp: 00:03: ioport range 0x8c0-0x8df has been reserved
[    7.469223] pnp: 00:08: ioport range 0x900-0x97f has been reserved
[    7.469394] PCI: Bridge: 0000:00:01.0
[    7.469398]   IO window: c000-cfff
[    7.469403]   MEM window: fc000000-fdffffff
[    7.469408]   PREFETCH window: e8000000-efffffff
[    7.469424] PCI: Bus 3, cardbus bridge: 0000:02:01.0
[    7.469427]   IO window: 0000d000-0000d0ff
[    7.469433]   IO window: 0000d400-0000d4ff
[    7.469438]   PREFETCH window: 30000000-31ffffff
[    7.469444]   MEM window: f6000000-f7ffffff
[    7.469449] PCI: Bus 7, cardbus bridge: 0000:02:01.1
[    7.469452]   IO window: 0000d800-0000d8ff
[    7.469458]   IO window: 0000dc00-0000dcff
[    7.469463]   PREFETCH window: 32000000-33ffffff
[    7.469469]   MEM window: f8000000-f9ffffff
[    7.469474] PCI: Bridge: 0000:00:1e.0
[    7.469478]   IO window: d000-efff
[    7.469484]   MEM window: f6000000-fbffffff
[    7.469490]   PREFETCH window: 30000000-33ffffff
[    7.469506] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    7.469518] PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
[    7.469693] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    7.469698] PCI: setting IRQ 11 as level-triggered
[    7.469703] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[    7.469721] PCI: Enabling device 0000:02:01.1 (0000 -> 0003)
[    7.469726] ACPI: PCI Interrupt 0000:02:01.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[    7.470225] Initializing Cryptographic API
[    7.470231] io scheduler noop registered
[    7.470237] io scheduler anticipatory registered
[    7.470243] io scheduler deadline registered
[    7.470252] io scheduler cfq registered
[    7.470537] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[    7.470542] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[    7.470583] radeonfb: Retreived PLL infos from BIOS
[    7.470588] radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=220.00 Mhz, System=200.00 MHz
[    7.470593] radeonfb: PLL min 20000 max 35000
[    8.404252] Non-DDC laptop panel detected
[    9.340510] radeonfb: Monitor 1 type LCD found
[    9.340513] radeonfb: Monitor 2 type no found
[    9.340518] radeonfb: panel ID string: 6J5644141XB
[    9.340519]             
[    9.340524] radeonfb: detected LVDS panel size from BIOS: 1024x768
[    9.340528] radeondb: BIOS provided dividers will be used
[    9.459414] radeonfb: Dynamic Clock Power Management enabled
[    9.489255] Console: switching to colour frame buffer device 128x48
[    9.490344] radeonfb (0000:01:00.0): ATI Radeon Lf 
[    9.490536] vesafb: cannot reserve video memory at 0xe8000000
[    9.490614] vesafb: framebuffer at 0xe8000000, mapped to 0xe1900000, using 3072k, total 32704k
[    9.490712] vesafb: mode is 1024x768x16, linelength=2048, pages=20
[    9.490790] vesafb: protected mode interface info at c000:57f3
[    9.490861] vesafb: scrolling: redraw
[    9.490912] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    9.491022] fb1: VESA VGA frame buffer device
[    9.505265] Real Time Clock Driver v1.12
[    9.505337] Linux agpgart interface v0.101 (c) Dave Jones
[    9.505443] agpgart: Detected an Intel 855PM Chipset.
[    9.514101] agpgart: AGP aperture is 128M @ 0xe0000000
[    9.514276] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    9.518178] serio: i8042 AUX port at 0x60,0x64 irq 12
[    9.518556] serio: i8042 KBD port at 0x60,0x64 irq 1
[    9.518695] mice: PS/2 mouse device common for all mice
[    9.528420] input: AT Translated Set 2 keyboard as /class/input/input0
[   12.528986] floppy0: no floppy controllers found
[   12.532694] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   12.536317] loop: loaded (max 8 devices)
[   12.539824] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   12.543262] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   12.546773] ICH4: IDE controller at PCI slot 0000:00:1f.1
[   12.550289] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   12.553860] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   12.557615] ICH4: chipset revision 1
[   12.561405] ICH4: not 100% native mode: will probe irqs later
[   12.565217]     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
[   12.569094]     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
[   12.572849] Probing IDE interface ide0...
[   12.860876] hda: TOSHIBA MK4026GAX, ATA DISK drive
[   13.532258] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   13.536008] Probing IDE interface ide1...
[   14.271758] hdc: SAMSUNG CDRW/DVD SN-324S, ATAPI CD/DVD-ROM drive
[   14.943627] ide1 at 0x170-0x177,0x376 on irq 15
[   14.947743] hda: max request size: 128KiB
[   15.000365] hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
[   15.004225] hda: cache flushes supported
[   15.008063]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
[   15.053371] i2c /dev entries driver
[   15.057345] NET: Registered protocol family 2
[   15.094991] IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
[   15.098972] TCP established hash table entries: 32768 (order: 5, 131072 bytes)
[   15.102958] TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
[   15.106925] TCP: Hash tables configured (established 32768 bind 32768)
[   15.110759] TCP reno registered
[   15.114648] TCP bic registered
[   15.118377] NET: Registered protocol family 1
[   15.122055] NET: Registered protocol family 17
[   15.125702] Using IPI Shortcut mode
[   15.143124] ACPI wakeup devices: 
[   15.146725]  LID PBTN PCI0 USB0 USB1 USB2 USB3 MODM PCIE 
[   15.150564] ACPI: (supports S0 S1 S3 S4 S5)
[   15.164554] ReiserFS: hda5: found reiserfs format "3.6" with standard journal
[   16.027363] ReiserFS: hda5: using ordered data mode
[   16.044862] ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   16.053238] ReiserFS: hda5: checking transaction log (hda5)
[   16.131674] ReiserFS: hda5: Using r5 hash to sort names
[   16.135732] VFS: Mounted root (reiserfs filesystem) readonly.
[   16.139905] Freeing unused kernel memory: 180k freed
[   16.143918] Write protecting the kernel read-only data: 302k
[   18.963302] Adding 979956k swap on /dev/hda3.  Priority:-1 extents:1 across:979956k
[   20.248172] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   20.248182] Uniform CD-ROM driver Revision: 3.20
[   20.375037] ieee80211_crypt: registered algorithm 'NULL'
[   20.419247] ieee80211: 802.11 data/management/control stack, git-1.1.7
[   20.419252] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   20.477128] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
[   20.477132] ipw2200: Copyright(c) 2003-2005 Intel Corporation
[   20.485526] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
[   20.485541] PCI: setting IRQ 5 as level-triggered
[   20.485545] ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[   20.492556] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[   20.942724] tg3.c:v3.43 (Oct 24, 2005)
[   20.942992] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[   20.942995] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   20.975955] eth0: Tigon3 [partno(BCM95705A50) rev 3001 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0f:1f:ca:d7:a8
[   20.975964] eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[   20.975967] eth0: dma_rwctrl[763f0000]
[   21.022269] input: DualPoint Stick as /class/input/input1
[   21.045759] input: AlpsPS/2 ALPS DualPoint TouchPad as /class/input/input2
[   21.260531] usbcore: registered new driver usbfs
[   21.263548] usbcore: registered new driver hub
[   21.302250] ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
[   21.302255] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
[   21.302271] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   21.302276] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   21.302293] ehci_hcd 0000:00:1d.7: debug port 1
[   21.302303] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   21.306234] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   21.306245] ehci_hcd 0000:00:1d.7: irq 11, io mem 0xf4fffc00
[   21.310127] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   21.311920] hub 1-0:1.0: USB hub found
[   21.311931] hub 1-0:1.0: 6 ports detected
[   21.457648] USB Universal Host Controller Interface driver v2.3
[   21.471725] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   21.471741] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   21.471745] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   21.472242] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   21.472252] uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
[   21.487627] hub 2-0:1.0: USB hub found
[   21.487642] hub 2-0:1.0: 2 ports detected
[   21.590272] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   21.590285] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   21.590289] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   21.597523] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   21.597535] uhci_hcd 0000:00:1d.1: irq 11, io base 0x0000bf40
[   21.598488] hub 3-0:1.0: USB hub found
[   21.598495] hub 3-0:1.0: 2 ports detected
[   21.702201] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   21.702215] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   21.702219] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   21.709636] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   21.709648] uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
[   21.710639] hub 4-0:1.0: USB hub found
[   21.710647] hub 4-0:1.0: 2 ports detected
[   21.894807] ACPI: AC Adapter [AC] (on-line)
[   22.425249] ACPI: Battery Slot [BAT0] (battery present)
[   22.425324] ACPI: Battery Slot [BAT1] (battery absent)
[   22.949836] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
[   22.949843] ACPI: Processor [CPU0] (supports 8 throttling states)
[   23.011806] ACPI: Thermal Zone [THM] (50 C)
[   23.106063] ACPI: Lid Switch [LID]
[   23.106072] ACPI: Power Button (CM) [PBTN]
[   23.106078] ACPI: Sleep Button (CM) [SBTN]
[   29.958765] kjournald starting.  Commit interval 5 seconds
[   29.958778] EXT3-fs: mounted filesystem with ordered data mode.
[   29.987017] ReiserFS: hda6: found reiserfs format "3.6" with standard journal
[   32.072568] ReiserFS: hda6: using ordered data mode
[   32.097509] ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   32.097940] ReiserFS: hda6: checking transaction log (hda6)
[   32.140927] ReiserFS: hda6: Using r5 hash to sort names
init: Entering runlevel: 3
rc-scripts: Could not detect custom ALSA settings.  Loading all detected alsa drivers.
[   38.606919] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[   38.606954] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   39.347491] intel8x0_measure_ac97_clock: measured 55460 usecs
[   39.347495] intel8x0: clocking to 48000
[   41.041433] Netfilter messages via NETLINK v0.30.
[   41.103149] ip_conntrack version 2.4 (4093 buckets, 32744 max) - 216 bytes per conntrack
[   41.237313] ip_tables: (C) 2000-2002 Netfilter core team
[   42.066955] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   42.066965] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   42.066968] ide: failed opcode was: 0xec
[   42.074856] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   42.074863] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   42.074867] ide: failed opcode was: 0xec
[   42.082636] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   42.082643] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   42.082647] ide: failed opcode was: 0xec
[   50.310273] [drm] Initialized drm 1.0.1 20051102
[   50.351137] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   50.360327] [drm] Initialized radeon 1.19.0 20050911 on minor 0
[   50.360655] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
[   50.361084] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[   50.361096] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[   50.361121] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[   50.429460] [drm] Loading R200 Microcode
142.118190] Hexdump:
[  142.118192] 000: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118200] 010: 00 00 00 00 2d 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118209] 020: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118217] 030: 00 00 00 00 2e 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118226] 040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118234] 050: 00 00 00 00 2f 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118242] 060: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118250] 070: 00 00 00 00 30 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118259] 080: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118267] 090: 00 00 00 00 31 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118275] 0a0: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118283] 0b0: 00 00 00 00 32 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118292] Trying to fix it up, but a reboot is needed
[  142.118295] Bad page state at free_hot_cold_page (in process 'neverball', page c13a4f00)
[  142.118298] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[  142.118300] Backtrace:
[  142.118301]  [<c0103d17>] dump_stack+0x17/0x20
[  142.118305]  [<c013c3d6>] bad_page+0x86/0x140
[  142.118308]  [<c013cd33>] free_hot_cold_page+0x43/0xf0
[  142.118312]  [<c013cdea>] free_hot_page+0xa/0x10
[  142.118316]  [<c0140311>] __page_cache_release+0x51/0xc0
[  142.118320]  [<c013ffa9>] put_page+0x39/0x80
[  142.118324]  [<c014c2e3>] free_page_and_swap_cache+0x23/0x40
[  142.118328]  [<c014460a>] zap_pte_range+0x11a/0x290
[  142.118331]  [<c0144869>] unmap_page_range+0xe9/0x120
[  142.118335]  [<c014495c>] unmap_vmas+0xbc/0x1c0
[  142.118338]  [<c01488a9>] unmap_region+0x79/0xf0
[  142.118342]  [<c0148b9e>] do_munmap+0xde/0x120
[  142.118345]  [<c0148c1f>] sys_munmap+0x3f/0x60
[  142.118349]  [<c0102e5f>] sysenter_past_esp+0x54/0x75
[  142.118352] Hexdump:
[  142.118354] 000: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118362] 010: 00 00 00 00 2e 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118371] 020: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118379] 030: 00 00 00 00 2f 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118387] 040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118396] 050: 00 00 00 00 30 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118404] 060: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118412] 070: 00 00 00 00 31 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118421] 080: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118429] 090: 00 00 00 00 32 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118437] 0a0: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118445] 0b0: 00 00 00 00 33 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118454] Trying to fix it up, but a reboot is needed
[  142.118456] Bad page state at free_hot_cold_page (in process 'neverball', page c13a4f20)
[  142.118460] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[  142.118462] Backtrace:
[  142.118463]  [<c0103d17>] dump_stack+0x17/0x20
[  142.118467]  [<c013c3d6>] bad_page+0x86/0x140
[  142.118470]  [<c013cd33>] free_hot_cold_page+0x43/0xf0
[  142.118474]  [<c013cdea>] free_hot_page+0xa/0x10
[  142.118478]  [<c0140311>] __page_cache_release+0x51/0xc0
[  142.118482]  [<c013ffa9>] put_page+0x39/0x80
[  142.118485]  [<c014c2e3>] free_page_and_swap_cache+0x23/0x40
[  142.118490]  [<c014460a>] zap_pte_range+0x11a/0x290
[  142.118493]  [<c0144869>] unmap_page_range+0xe9/0x120
[  142.118497]  [<c014495c>] unmap_vmas+0xbc/0x1c0
[  142.118500]  [<c01488a9>] unmap_region+0x79/0xf0
[  142.118504]  [<c0148b9e>] do_munmap+0xde/0x120
[  142.118507]  [<c0148c1f>] sys_munmap+0x3f/0x60
[  142.118511]  [<c0102e5f>] sysenter_past_esp+0x54/0x75
[  142.118514] Hexdump:
[  142.118516] 000: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118524] 010: 00 00 00 00 2f 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118533] 020: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118541] 030: 00 00 00 00 30 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118549] 040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118558] 050: 00 00 00 00 31 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118566] 060: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118574] 070: 00 00 00 00 32 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118583] 080: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118591] 090: 00 00 00 00 33 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118599] 0a0: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118607] 0b0: 00 00 00 00 34 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118616] Trying to fix it up, but a reboot is needed
[  142.118618] Bad page state at free_hot_cold_page (in process 'neverball', page c13a4f40)
[  142.118622] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[  142.118624] Backtrace:
[  142.118625]  [<c0103d17>] dump_stack+0x17/0x20
[  142.118629]  [<c013c3d6>] bad_page+0x86/0x140
[  142.118633]  [<c013cd33>] free_hot_cold_page+0x43/0xf0
[  142.118636]  [<c013cdea>] free_hot_page+0xa/0x10
[  142.118640]  [<c0140311>] __page_cache_release+0x51/0xc0
[  142.118644]  [<c013ffa9>] put_page+0x39/0x80
[  142.118648]  [<c014c2e3>] free_page_and_swap_cache+0x23/0x40
[  142.118652]  [<c014460a>] zap_pte_range+0x11a/0x290
[  142.118655]  [<c0144869>] unmap_page_range+0xe9/0x120
[  142.118659]  [<c014495c>] unmap_vmas+0xbc/0x1c0
[  142.118662]  [<c01488a9>] unmap_region+0x79/0xf0
[  142.118666]  [<c0148b9e>] do_munmap+0xde/0x120
[  142.118670]  [<c0148c1f>] sys_munmap+0x3f/0x60
[  142.118673]  [<c0102e5f>] sysenter_past_esp+0x54/0x75
[  142.118676] Hexdump:
[  142.118678] 000: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118686] 010: 00 00 00 00 30 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118695] 020: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118703] 030: 00 00 00 00 31 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118712] 040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118720] 050: 00 00 00 00 32 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118728] 060: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118736] 070: 00 00 00 00 33 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118745] 080: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118753] 090: 00 00 00 00 34 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118761] 0a0: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118769] 0b0: 00 00 00 00 35 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118778] Trying to fix it up, but a reboot is needed
[  142.118781] Bad page state at free_hot_cold_page (in process 'neverball', page c13a4f60)
[  142.118784] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[  142.118786] Backtrace:
[  142.118787]  [<c0103d17>] dump_stack+0x17/0x20
[  142.118791]  [<c013c3d6>] bad_page+0x86/0x140
[  142.118795]  [<c013cd33>] free_hot_cold_page+0x43/0xf0
[  142.118798]  [<c013cdea>] free_hot_page+0xa/0x10
[  142.118802]  [<c0140311>] __page_cache_release+0x51/0xc0
[  142.118806]  [<c013ffa9>] put_page+0x39/0x80
[  142.118810]  [<c014c2e3>] free_page_and_swap_cache+0x23/0x40
[  142.118814]  [<c014460a>] zap_pte_range+0x11a/0x290
[  142.118817]  [<c0144869>] unmap_page_range+0xe9/0x120
[  142.118821]  [<c014495c>] unmap_vmas+0xbc/0x1c0
[  142.118825]  [<c01488a9>] unmap_region+0x79/0xf0
[  142.118828]  [<c0148b9e>] do_munmap+0xde/0x120
[  142.118832]  [<c0148c1f>] sys_munmap+0x3f/0x60
[  142.118835]  [<c0102e5f>] sysenter_past_esp+0x54/0x75
[  142.118838] Hexdump:
[  142.118840] 000: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118849] 010: 00 00 00 00 31 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118857] 020: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118865] 030: 00 00 00 00 32 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118874] 040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.118882] 050: 00 00 00 00 33 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118890] 060: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118898] 070: 00 00 00 00 34 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118907] 080: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118915] 090: 00 00 00 00 35 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118923] 0a0: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.118931] 0b0: 00 00 00 00 36 7c 0b 00 00 01 10 00 00 02 20 00
[  142.118940] Trying to fix it up, but a reboot is needed
[  142.118943] Bad page state at free_hot_cold_page (in process 'neverball', page c13a4f80)
[  142.118946] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[  142.118948] Backtrace:
[  142.118950]  [<c0103d17>] dump_stack+0x17/0x20
[  142.118953]  [<c013c3d6>] bad_page+0x86/0x140
[  142.118957]  [<c013cd33>] free_hot_cold_page+0x43/0xf0
[  142.118960]  [<c013cdea>] free_hot_page+0xa/0x10
[  142.118964]  [<c0140311>] __page_cache_release+0x51/0xc0
[  142.118968]  [<c013ffa9>] put_page+0x39/0x80
[  142.118972]  [<c014c2e3>] free_page_and_swap_cache+0x23/0x40
[  142.118976]  [<c014460a>] zap_pte_range+0x11a/0x290
[  142.118979]  [<c0144869>] unmap_page_range+0xe9/0x120
[  142.118983]  [<c014495c>] unmap_vmas+0xbc/0x1c0
[  142.118986]  [<c01488a9>] unmap_region+0x79/0xf0
[  142.118990]  [<c0148b9e>] do_munmap+0xde/0x120
[  142.118994]  [<c0148c1f>] sys_munmap+0x3f/0x60
[  142.118997]  [<c0102e5f>] sysenter_past_esp+0x54/0x75
[  142.119000] Hexdump:
[  142.119002] 000: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119011] 010: 00 00 00 00 32 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119019] 020: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119027] 030: 00 00 00 00 33 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119036] 040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119044] 050: 00 00 00 00 34 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119052] 060: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.119060] 070: 00 00 00 00 35 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119069] 080: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.119077] 090: 00 00 00 00 36 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119085] 0a0: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.119093] 0b0: 00 00 00 00 37 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119102] Trying to fix it up, but a reboot is needed
[  142.119105] Bad page state at free_hot_cold_page (in process 'neverball', page c13a4fa0)
[  142.119108] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[  142.119110] Backtrace:
[  142.119111]  [<c0103d17>] dump_stack+0x17/0x20
[  142.119115]  [<c013c3d6>] bad_page+0x86/0x140
[  142.119119]  [<c013cd33>] free_hot_cold_page+0x43/0xf0
[  142.119122]  [<c013cdea>] free_hot_page+0xa/0x10
[  142.119126]  [<c0140311>] __page_cache_release+0x51/0xc0
[  142.119130]  [<c013ffa9>] put_page+0x39/0x80
[  142.119134]  [<c014c2e3>] free_page_and_swap_cache+0x23/0x40
[  142.119138]  [<c014460a>] zap_pte_range+0x11a/0x290
[  142.119141]  [<c0144869>] unmap_page_range+0xe9/0x120
[  142.119145]  [<c014495c>] unmap_vmas+0xbc/0x1c0
[  142.119148]  [<c01488a9>] unmap_region+0x79/0xf0
[  142.119152]  [<c0148b9e>] do_munmap+0xde/0x120
[  142.119156]  [<c0148c1f>] sys_munmap+0x3f/0x60
[  142.119159]  [<c0102e5f>] sysenter_past_esp+0x54/0x75
[  142.119162] Hexdump:
[  142.119164] 000: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119172] 010: 00 00 00 00 33 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119181] 020: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119189] 030: 00 00 00 00 34 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119198] 040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119206] 050: 00 00 00 00 35 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119225] 060: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.119233] 070: 00 00 00 00 36 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119241] 080: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.119249] 090: 00 00 00 00 37 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119258] 0a0: 2c 00 01 80 00 00 00 00 ff ff ff ff 00 00 00 00
[  142.119266] 0b0: f8 3e c9 dc 21 00 00 00 f8 a3 3c c1 38 50 3a c1
[  142.119274] Trying to fix it up, but a reboot is needed
[  142.119277] Bad page state at free_hot_cold_page (in process 'neverball', page c13a4fc0)
[  142.119281] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[  142.119283] Backtrace:
[  142.119284]  [<c0103d17>] dump_stack+0x17/0x20
[  142.119288]  [<c013c3d6>] bad_page+0x86/0x140
[  142.119291]  [<c013cd33>] free_hot_cold_page+0x43/0xf0
[  142.119295]  [<c013cdea>] free_hot_page+0xa/0x10
[  142.119299]  [<c0140311>] __page_cache_release+0x51/0xc0
[  142.119303]  [<c013ffa9>] put_page+0x39/0x80
[  142.119307]  [<c014c2e3>] free_page_and_swap_cache+0x23/0x40
[  142.119311]  [<c014460a>] zap_pte_range+0x11a/0x290
[  142.119314]  [<c0144869>] unmap_page_range+0xe9/0x120
[  142.119318]  [<c014495c>] unmap_vmas+0xbc/0x1c0
[  142.119321]  [<c01488a9>] unmap_region+0x79/0xf0
[  142.119325]  [<c0148b9e>] do_munmap+0xde/0x120
[  142.119328]  [<c0148c1f>] sys_munmap+0x3f/0x60
[  142.119332]  [<c0102e5f>] sysenter_past_esp+0x54/0x75
[  142.119335] Hexdump:
[  142.119337] 000: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119345] 010: 00 00 00 00 34 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119354] 020: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119362] 030: 00 00 00 00 35 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119370] 040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119379] 050: 00 00 00 00 36 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119387] 060: 04 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[  142.119395] 070: 00 00 00 00 37 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119404] 080: 2c 00 01 80 00 00 00 00 ff ff ff ff 00 00 00 00
[  142.119412] 090: f8 3e c9 dc 21 00 00 00 f8 a3 3c c1 38 50 3a c1
[  142.119420] 0a0: 2c 00 01 80 00 00 00 00 ff ff ff ff 00 00 00 00
[  142.119429] 0b0: f8 3e c9 dc 22 00 00 00 18 50 3a c1 58 50 3a c1
[  142.119437] Trying to fix it up, but a reboot is needed
[  142.119440] Bad page state at free_hot_cold_page (in process 'neverball', page c13a4fe0)
[  142.119443] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[  142.119445] Backtrace:
[  142.119447]  [<c0103d17>] dump_stack+0x17/0x20
[  142.119450]  [<c013c3d6>] bad_page+0x86/0x140
[  142.119454]  [<c013cd33>] free_hot_cold_page+0x43/0xf0
[  142.119458]  [<c013cdea>] free_hot_page+0xa/0x10
[  142.119461]  [<c0140311>] __page_cache_release+0x51/0xc0
[  142.119465]  [<c013ffa9>] put_page+0x39/0x80
[  142.119469]  [<c014c2e3>] free_page_and_swap_cache+0x23/0x40
[  142.119473]  [<c014460a>] zap_pte_range+0x11a/0x290
[  142.119477]  [<c0144869>] unmap_page_range+0xe9/0x120
[  142.119480]  [<c014495c>] unmap_vmas+0xbc/0x1c0
[  142.119484]  [<c01488a9>] unmap_region+0x79/0xf0
[  142.119487]  [<c0148b9e>] do_munmap+0xde/0x120
[  142.119491]  [<c0148c1f>] sys_munmap+0x3f/0x60
[  142.119494]  [<c0102e5f>] sysenter_past_esp+0x54/0x75
[  142.119498] Hexdump:
[  142.119499] 000: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119508] 010: 00 00 00 00 35 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119516] 020: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119525] 030: 00 00 00 00 36 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119533] 040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[  142.119541] 050: 00 00 00 00 37 7c 0b 00 00 01 10 00 00 02 20 00
[  142.119550] 060: 2c 00 01 80 00 00 00 00 ff ff ff ff 00 00 00 00
[  142.119558] 070: f8 3e c9 dc 21 00 00 00 f8 a3 3c c1 38 50 3a c1
[  142.119566] 080: 2c 00 01 80 00 00 00 00 ff ff ff ff 00 00 00 00
[  142.119575] 090: f8 3e c9 dc 22 00 00 00 18 50 3a c1 58 50 3a c1
[  142.119583] 0a0: 2c 00 01 80 00 00 00 00 ff ff ff ff 00 00 00 00
[  142.119591] 0b0: f8 3e c9 dc 23 00 00 00 38 50 3a c1 78 50 3a c1
[  142.119600] Trying to fix it up, but a reboot is needed
[  171.963456] ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40

--ew6BAiZeqk4r7MaW--
