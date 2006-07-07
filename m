Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWGGAQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWGGAQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWGGAQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:16:46 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:8618 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750916AbWGGAQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:16:44 -0400
X-Sasl-enc: X/Ao4HN44RStRT2ijk+LxVIFYbF+s2iyj9IM5sWPjRvT 1152231401
Message-ID: <44ADA84A.9000603@imap.cc>
Date: Fri, 07 Jul 2006 02:18:18 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc1: printk delays
References: <6vtF8-99-7@gated-at.bofh.it>  <44AD9605.6000601@imap.cc> <1152229599.24656.175.camel@cog.beaverton.ibm.com>
In-Reply-To: <1152229599.24656.175.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAAAA1E5918F5BE377F011FC5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAAAA1E5918F5BE377F011FC5
Content-Type: multipart/mixed;
 boundary="------------070505010702050803030907"

This is a multi-part message in MIME format.
--------------070505010702050803030907
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 07.07.2006 01:46, john stultz wrote:

> On Fri, 2006-07-07 at 01:00 +0200, Tilman Schmidt wrote:
> 
>>With kernel 2.6.18-rc1 [t]he last couple of printk
>>lines only appear if I hit a key on the system keyboard. [...]
> 
> Hmmm. I'm assuming this is i386?

Yes, indeed. Sorry I didn't mention that.

> Could you send me a full dmesg?

Attached.

> Also does booting w/ clocksource=jiffies change the behavior?

Nope. That didn't produce any discernible change.

Thanks,
Tilman

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Imagine a world without hypothetical situations.

--------------070505010702050803030907
Content-Type: text/plain;
 name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.out"

[    0.000000] Linux version 2.6.18-rc1-noinitrd (ts@gx110) (gcc version 4.0.2 20050901 (prerelease) (SUSE Linux)) #1 PREEMPT Thu Jul 6 18:17:31 CEST 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001feae000 (usable)
[    0.000000]  BIOS-e820: 000000001feae000 - 0000000020000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] 510MB LOWMEM available.
[    0.000000] On node 0 totalpages: 130734
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 126638 pages, LIFO batch:31
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 DELL                                  ) @ 0x000fd790
[    0.000000] ACPI: RSDT (v001 DELL    GX110   0x00000007 ASL  0x00000061) @ 0x000fd7a4
[    0.000000] ACPI: FADT (v001 DELL    GX110   0x00000007 ASL  0x00000061) @ 0x000fd7cc
[    0.000000] ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000b) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000:dfb00000)
[    0.000000] Detected 931.113 MHz processor.
[   32.476912] Built 1 zonelists.  Total pages: 130734
[   32.476920] Kernel command line: root=/dev/hda3 selinux=0 x11i=vesa video=intelfb:mode=1280x1024-32@70 nmi_watchdog=2 lapic 5
[   32.477544] Local APIC disabled by BIOS -- reenabling.
[   32.477552] Found and enabled local APIC!
[   32.477559] mapped APIC to ffffd000 (fee00000)
[   32.477568] Enabling fast FPU save and restore... done.
[   32.477575] Enabling unmasked SIMD FPU exception support... done.
[   32.477583] Initializing CPU#0
[   32.477719] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   32.479674] Console: colour VGA+ 80x25
[   32.480746] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   32.480829] ... MAX_LOCKDEP_SUBCLASSES:    8
[   32.480888] ... MAX_LOCK_DEPTH:          30
[   32.480946] ... MAX_LOCKDEP_KEYS:        2048
[   32.481004] ... CLASSHASH_SIZE:           1024
[   32.481063] ... MAX_LOCKDEP_ENTRIES:     8192
[   32.481121] ... MAX_LOCKDEP_CHAINS:      8192
[   32.481179] ... CHAINHASH_SIZE:          4096
[   32.481238]  memory used by lock dependency info: 696 kB
[   32.481299]  per task-struct memory footprint: 1200 bytes
[   32.481360] ------------------------
[   32.481417] | Locking API testsuite:
[   32.481473] ----------------------------------------------------------------------------
[   32.481556]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[   32.481639]   --------------------------------------------------------------------------
[   32.481779]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   32.484485]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   32.487182]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   32.489928]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   32.492650]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   32.495438]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   32.498226]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   32.500996]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   32.503670]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   32.506343]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   32.509025]   --------------------------------------------------------------------------
[   32.509108]               recursive read-lock:             |  ok  |             |  ok  |
[   32.510139]            recursive read-lock #2:             |  ok  |             |  ok  |
[   32.511158]             mixed read-write-lock:             |  ok  |             |  ok  |
[   32.512180]             mixed write-read-lock:             |  ok  |             |  ok  |
[   32.513203]   --------------------------------------------------------------------------
[   32.513286]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   32.514665]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   32.516035]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   32.517402]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   32.518785]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[   32.520156]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[   32.521526]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   32.522906]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   32.524278]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   32.525645]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   32.527028]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   32.528413]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   32.529815]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   32.531196]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   32.532582]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   32.533984]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   32.535366]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   32.536748]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   32.538148]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   32.539517]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   32.540892]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   32.542291]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   32.543671]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   32.545055]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   32.546460]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   32.547839]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   32.549230]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   32.550632]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   32.552016]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   32.553399]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   32.554803]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   32.556184]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   32.557574]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   32.558974]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   32.560358]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   32.561763]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   32.563154]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   32.564539]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   32.565946]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   32.567333]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   32.568719]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   32.570121]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   32.571512]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   32.572895]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   32.574303]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   32.575689]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   32.577077]       hard-irq read-recursion/123:  ok  |
[   32.577598]       soft-irq read-recursion/123:  ok  |
[   32.578138]       hard-irq read-recursion/132:  ok  |
[   32.578658]       soft-irq read-recursion/132:  ok  |
[   32.579181]       hard-irq read-recursion/213:  ok  |
[   32.579703]       soft-irq read-recursion/213:  ok  |
[   32.580223]       hard-irq read-recursion/231:  ok  |
[   32.580745]       soft-irq read-recursion/231:  ok  |
[   32.581268]       hard-irq read-recursion/312:  ok  |
[   32.581803]       soft-irq read-recursion/312:  ok  |
[   32.582326]       hard-irq read-recursion/321:  ok  |
[   32.582846]       soft-irq read-recursion/321:  ok  |
[   32.583367] -------------------------------------------------------
[   32.583432] Good, all 218 testcases passed! |
[   32.583490] ---------------------------------
[   32.584669] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   32.586249] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   32.647693] Memory: 511956k/522936k available (2298k kernel code, 10488k reserved, 1194k data, 192k init, 0k highmem)
[   32.647799] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   32.725557] Calibrating delay using timer specific routine.. 1865.36 BogoMIPS (lpj=3730731)
[   32.725918] Security Framework v1.0.0 initialized
[   32.725992] SELinux:  Disabled at boot.
[   32.726188] Mount-cache hash table entries: 512
[   32.727427] CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
[   32.727449] CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
[   32.727477] CPU: L1 I cache: 16K, L1 D cache: 16K
[   32.727568] CPU: L2 cache: 256K
[   32.727626] CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
[   32.727647] Intel machine check architecture supported.
[   32.727710] Intel machine check reporting enabled on CPU#0.
[   32.727812] CPU: Intel Pentium III (Coppermine) stepping 0a
[   32.727970] Checking 'hlt' instruction... OK.
[   32.741719] ACPI: Core revision 20060623
[   32.755776]  tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
[   32.768968] Parsing all Control Methods:
[   32.769233] Table [DSDT](id 0005) - 201 Objects with 22 Devices 65 Methods 12 Regions
[   32.769366] ACPI Namespace successfully loaded at root c069f9b0
[   32.769436] ACPI: setting ELCR to 0200 (from 0e20)
[   32.769827] evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
[   32.882536] NET: Registered protocol family 16
[   32.883983] ACPI: bus type pci registered
[   32.896890] PCI: PCI BIOS revision 2.10 entry at 0xfc0ce, last bus=1
[   32.896962] Setting up standard PCI resources
[   32.901263] evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
[   32.902426] evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 3 Wake, Enabled 0 Runtime GPEs in this block
[   32.908988] Completing Region/Field/Buffer/Package initialization:........................
[   32.917617] Initialized 12/12 Regions 0/0 Fields 6/6 Buffers 6/10 Packages (210 nodes)
[   32.917747] Initializing Device/Processor/Thermal objects by executing _INI methods:
[   32.917871] Executed 0 _INI methods requiring 0 _STA executions (examined 26 objects)
[   32.918245] ACPI: Interpreter enabled
[   32.918303] ACPI: Using PIC for interrupt routing
[   32.923744] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   32.923847] PCI: Probing PCI hardware (bus 00)
[   32.924125] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   32.932615] Boot video device is 0000:00:01.0
[   32.933066] PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
[   32.933147] PCI quirk: region 0880-08bf claimed by ICH4 GPIO
[   32.934852] PCI: Transparent bridge - 0000:00:1e.0
[   32.935018] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   32.951160] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[   32.979933] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 15)
[   32.983266] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[   32.986328] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[   32.989295] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
[   32.990904] Linux Plug and Play Support v0.97 (c) Adam Belay
[   32.991192] pnp: PnP ACPI init
[   33.035668] pnp: PnP ACPI: found 13 devices
[   33.036657] usbcore: registered new driver usbfs
[   33.037279] usbcore: registered new driver hub
[   33.039307] PCI: Using ACPI for IRQ routing
[   33.040605] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   33.054266] pnp: 00:0c: ioport range 0x800-0x85f could not be reserved
[   33.054346] pnp: 00:0c: ioport range 0xc00-0xc7f has been reserved
[   33.054417] pnp: 00:0c: ioport range 0x860-0x8ff could not be reserved
[   33.059085] PCI: Ignore bogus resource 6 [0:0] of 0000:00:01.0
[   33.059184] PCI: Bridge: 0000:00:1e.0
[   33.059248]   IO window: e000-efff
[   33.059317]   MEM window: fd000000-feffffff
[   33.059384]   PREFETCH window: 30000000-300fffff
[   33.059482] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   33.059618] NET: Registered protocol family 2
[   33.093786] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   33.095146] TCP established hash table entries: 16384 (order: 8, 1572864 bytes)
[   33.105170] TCP bind hash table entries: 8192 (order: 7, 819200 bytes)
[   33.110380] TCP: Hash tables configured (established 16384 bind 8192)
[   33.110541] TCP reno registered
[   33.113707] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[   33.113787] apm: overridden by ACPI.
[   33.131553] audit: initializing netlink socket (disabled)
[   33.131796] audit(1152230654.732:1): initialized
[   33.132538] Total HugeTLB memory allocated, 0
[   33.133515] VFS: Disk quotas dquot_6.5.1
[   33.133685] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   33.135473] Initializing Cryptographic API
[   33.135581] io scheduler noop registered
[   33.135701] io scheduler anticipatory registered
[   33.135818] io scheduler deadline registered (default)
[   33.135998] io scheduler cfq registered
[   33.141478] isapnp: Scanning for PnP cards...
[   33.496311] isapnp: No Plug & Play device found
[   33.883938] Real Time Clock Driver v1.12ac
[   33.884532] Linux agpgart interface v0.101 (c) Dave Jones
[   33.885176] agpgart: Detected an Intel i810 E Chipset.
[   33.891903] agpgart: detected 4MB dedicated video ram.
[   33.899128] agpgart: AGP aperture is 64M @ 0xf8000000
[   33.902017] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
[   33.902093] PCI: setting IRQ 9 as level-triggered
[   33.902101] ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[   33.909417] i810-i2c: Probe DDC1 Bus
[   33.939750] i810-i2c: I2C Transfer successful
[   33.939811] i810fb_init_pci: DDC probe successful
[   33.970392] Console: switching to colour frame buffer device 160x64
[   33.989438] I810FB: fb0         : Intel(R) 810E Framebuffer Device v0.9.0
[   33.989442] I810FB: Video RAM   : 4096K
[   33.989445] I810FB: Monitor     : H: 30-83 KHz V: 55-75 Hz
[   33.989449] I810FB: Mode        : 1280x1024-8bpp@60Hz
[   33.990501] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   33.991925] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   33.993379] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   33.998359] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   34.000394] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   34.002983] Floppy drive(s): fd0 is 1.44M
[   34.018591] FDC 0 is a National Semiconductor PC87306
[   34.032956] RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
[   34.039750] loop: loaded (max 8 devices)
[   34.042541] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
[   34.042827] PCI: setting IRQ 5 as level-triggered
[   34.042835] ACPI: PCI Interrupt 0000:01:0c.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
[   34.043424] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[   34.043741] 0000:01:0c.0: 3Com PCI 3c905C Tornado at e081ec00.
[   34.068182] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   34.068500] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   34.069218] ICH: IDE controller at PCI slot 0000:00:1f.1
[   34.069525] ICH: chipset revision 2
[   34.069734] ICH: not 100% native mode: will probe irqs later
[   34.070017]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
[   34.070612]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
[   34.071196] Probing IDE interface ide0...
[   34.356572] hda: IC35L060AVER07-0, ATA DISK drive
[   35.028589] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   35.029875] Probing IDE interface ide1...
[   35.763591] hdc: TOSHIBA DVD-ROM SDM2012C, ATAPI CD/DVD-ROM drive
[   36.435378] ide1 at 0x170-0x177,0x376 on irq 15
[   36.439584] hda: max request size: 128KiB
[   36.450575] hda: 120103200 sectors (61492 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(66)
[   36.451455] hda: cache flushes not supported
[   36.452262]  hda: hda1 hda2 hda3 hda4
[   36.477016] usbcore: registered new driver libusual
[   36.478405] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[   36.487567] serio: i8042 AUX port at 0x60,0x64 irq 12
[   36.494423] serio: i8042 KBD port at 0x60,0x64 irq 1
[   36.503268] mice: PS/2 mouse device common for all mice
[   36.512215] input: PC Speaker as /class/input/input0
[   36.551640] input: AT Translated Set 2 keyboard as /class/input/input1
[   36.558385] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[   36.564603] md: bitmap version 4.39
[   36.571270] TCP bic registered
[   36.577507] NET: Registered protocol family 1
[   36.585803] Testing NMI watchdog ... OK.
[   36.632102] Using IPI Shortcut mode
[   36.638848] Time: tsc clocksource has been installed.
[   36.645532] ACPI: (supports S0 S1 S4 S5)
[   36.654459] md: Autodetecting RAID arrays.
[   36.660901] md: autorun ...
[   36.667186] md: ... autorun DONE.
[   36.683597] ReiserFS: hda3: found reiserfs format "3.6" with standard journal
[   37.304982] input: ImPS/2 Generic Wheel Mouse as /class/input/input2
[   38.025547] ReiserFS: hda3: using ordered data mode
[   38.048748] ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.067295] ReiserFS: hda3: checking transaction log (hda3)
[   38.125765] ReiserFS: hda3: Using r5 hash to sort names
[   38.133504] VFS: Mounted root (reiserfs filesystem) readonly.
[   38.141041] Freeing unused kernel memory: 192k freed
[   38.147971] Write protecting the kernel read-only data: 450k
[   43.746338] device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
[   44.021049] md: Autodetecting RAID arrays.
[   44.027611] md: autorun ...
[   44.033912] md: ... autorun DONE.
[   67.476125] NTFS driver 2.1.27 [Flags: R/W MODULE].
[   67.610810] NTFS volume version 3.1.
[   70.635741] NET: Registered protocol family 10
[   70.642907] lo: Disabled Privacy Extensions
[   70.649952] IPv6 over IPv4 tunneling driver
[   82.051088] Intel 82802 RNG detected
[   82.399666] i8xx TCO timer: initialized (0x0860). heartbeat=30 sec (nowayout=0)
[   82.877894] USB Universal Host Controller Interface driver v3.0
[   82.897061] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[   82.897084] PCI: setting IRQ 11 as level-triggered
[   82.897092] ACPI: PCI Interrupt 0000:00:1f.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   82.897155] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   82.897168] uhci_hcd 0000:00:1f.2: UHCI Host Controller
[   82.910696] uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
[   82.910815] uhci_hcd 0000:00:1f.2: irq 11, io base 0x0000ff80
[   82.931926] usb usb1: configuration #1 chosen from 1 choice
[   82.941973] hub 1-0:1.0: USB hub found
[   82.942102] hub 1-0:1.0: 2 ports detected
[   83.290755] usb 1-1: new full speed USB device using uhci_hcd and address 2
[   83.502695] usb 1-1: configuration #1 chosen from 1 choice
[   84.521490] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[   84.521513] PCI: setting IRQ 10 as level-triggered
[   84.521522] ACPI: PCI Interrupt 0000:00:1f.3[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
[   84.521559] i801_smbus 0000:00:1f.3: Enabling SMBus device
[   85.033456] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
[   85.033563] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   85.385174] intel8x0_measure_ac97_clock: measured 54268 usecs
[   85.385193] intel8x0: clocking to 48000
[   88.356370] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   89.269755] ip_tables: (C) 2000-2006 Netfilter Core Team
[   89.311430] Netfilter messages via NETLINK v0.30.
[   89.355819] ip_conntrack version 2.4 (4085 buckets, 32680 max) - 224 bytes per conntrack
[   96.390608] Adding 514072k swap on /dev/hda2.  Priority:-1 extents:1 across:514072k
[   98.028271] CSLIP: code copyright 1989 Regents of the University of California
[   98.087813] ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/1.1.2.2/1.1.2.2 loaded
[   98.136195] gigaset: Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>, Stefan Eilers
[   98.136216] gigaset: Driver for Gigaset 307x
[   98.171675] gigaset: tty driver initialized
[   98.172853] gigaset: Register driver capabilities to LL
[   98.205502] bas_gigaset: gigaset_probe: Check if device matches .. (Vendor: 0x681, Product: 0x2)
[   98.205515] bas_gigaset: gigaset_probe: wrong alternate setting 0 - trying to switch
[   98.405279] usb 1-1: gigaset_probe: Device matched (Vendor: 0x681, Product: 0x2)
[   98.405643] gigaset: scheduling START
[   98.405678] gigaset: connection state 0, event -110
[   98.405691] gigaset: unblocking all channels
[   98.405698] gigaset: blocking all channels
[   98.405705] gigaset: Scheduling PC_INIT
[   98.405727] gigaset: ISDN_CMD_SETEAZ (id: 0, ch: 0, number: )
[   98.405739] gigaset: ISDN_CMD_SETEAZ (id: 0, ch: 1, number: )
[   98.405834] gigaset: searching scheduled commands
[   98.405847] gigaset: connection state 0, event -27
[   98.405914] usbcore: registered new driver bas_gigaset
[   98.405949] bas_gigaset: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>, Stefan Eilers
[   98.405961] bas_gigaset: USB Driver for Gigaset 307x
[   99.387554] gigaset: scheduling timeout
[   99.387583] gigaset: connection state 100, event -105
[   99.387590] gigaset: stopped waiting
[   99.387604] gigaset: CMD Transmit (4 bytes): ATZ^M
[   99.387735] bas_gigaset: AT channel not open
[   99.413029] bas_gigaset: setting ATREADY timeout of 3/10 secs
[   99.415976] bas_gigaset: write_command: sent 4 bytes, 0 left
[   99.446986] gigaset: received response (6 bytes): ^M^JOK^M^J
[   99.446999] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.447006] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.447012] bas_gigaset: cmd_loop: End of Command (2 Bytes)
[   99.447018] gigaset: raw string: 'OK'
[   99.447025] gigaset: CMD received: OK
[   99.447030] gigaset: available params: 0
[   99.447040] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.447050] gigaset: connection state 101, event 0
[   99.447064] gigaset: CMD Transmit (7 bytes): AT+GMR^M
[   99.447135] bas_gigaset: setting ATREADY timeout of 3/10 secs
[   99.448923] bas_gigaset: write_command: sent 7 bytes, 0 left
[   99.478990] gigaset: received response (22 bytes): ^M^J04.204.02.01^M^J^M^JOK^M^J
[   99.479004] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.479011] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.479017] bas_gigaset: cmd_loop: End of Command (12 Bytes)
[   99.479023] gigaset: raw string: '04.204.02.01'
[   99.479039] gigaset: string==04.204.02.01
[   99.479045] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.479051] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.479057] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.479064] bas_gigaset: cmd_loop: End of Command (2 Bytes)
[   99.479069] gigaset: raw string: 'OK'
[   99.479075] gigaset: CMD received: OK
[   99.479080] gigaset: available params: 0
[   99.479087] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.479097] gigaset: connection state 120, event -20
[   99.479114] gigaset: connection state 121, event 0
[   99.479124] gigaset: firmware version 04.204.02.01
[   99.479131] gigaset: Scheduling PC_CIDMODE
[   99.479140] gigaset: searching scheduled commands
[   99.479154] gigaset: connection state 0, event -27
[   99.479167] gigaset: CMD Transmit (10 bytes): AT\^SGCI=1^M
[   99.479237] bas_gigaset: setting ATREADY timeout of 3/10 secs
[   99.481916] bas_gigaset: write_command: sent 10 bytes, 0 left
[   99.510898] gigaset: received response (6 bytes): ^M^JOK^M^J
[   99.510910] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.510917] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.510924] bas_gigaset: cmd_loop: End of Command (2 Bytes)
[   99.510930] gigaset: raw string: 'OK'
[   99.510936] gigaset: CMD received: OK
[   99.510941] gigaset: available params: 0
[   99.510951] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[   99.510960] gigaset: connection state 150, event 0
[   99.510974] gigaset: unblocking all channels
[   99.510984] gigaset: searching scheduled commands
[  120.109858] eth0:  setting full-duplex.
[  120.604586] NET: Registered protocol family 17
[  129.394336] ACPI: Power Button (FF) [PWRF]
[  129.530714] ACPI: Getting cpuindex for acpiid 0x2
[  130.665798] eth0: no IPv6 routers present
[  131.691049] 
[  131.691055] =============================================
[  131.691074] [ INFO: possible recursive locking detected ]
[  131.691083] ---------------------------------------------
[  131.691092] udevd/3729 is trying to acquire lock:
[  131.691101]  (&inode->i_mutex){--..}, at: [<c033c72a>] mutex_lock+0x1c/0x1f
[  131.691148] 
[  131.691150] but task is already holding lock:
[  131.691158]  (&inode->i_mutex){--..}, at: [<c033c72a>] mutex_lock+0x1c/0x1f
[  131.691177] 
[  131.691179] other info that might help us debug this:
[  131.691189] 1 lock held by udevd/3729:
[  131.691195]  #0:  (&inode->i_mutex){--..}, at: [<c033c72a>] mutex_lock+0x1c/0x1f
[  131.691215] 
[  131.691217] stack backtrace:
[  131.691940]  [<c0103f4d>] show_trace_log_lvl+0x54/0xfd
[  131.691997]  [<c010504d>] show_trace+0xd/0x10
[  131.692044]  [<c0105067>] dump_stack+0x17/0x1c
[  131.692090]  [<c012e3fa>] __lock_acquire+0x758/0x9bf
[  131.692336]  [<c012e93e>] lock_acquire+0x5e/0x80
[  131.692572]  [<c033c5a7>] __mutex_lock_slowpath+0xa7/0x20e
[  131.692796]  [<c033c72a>] mutex_lock+0x1c/0x1f
[  131.693017]  [<c01ba730>] xattr_readdir+0x50/0x456
[  131.694269]  [<c01bb304>] reiserfs_chown_xattrs+0xdd/0x112
[  131.694875]  [<c019dca6>] reiserfs_setattr+0x113/0x250
[  131.695516]  [<c0174619>] notify_change+0x135/0x2c0
[  131.695991]  [<c015b328>] chown_common+0x93/0xab
[  131.696388]  [<c015b373>] sys_chown+0x33/0x45
[  131.696770]  [<c0102cbd>] sysenter_past_esp+0x56/0x8d
[  132.094621] IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
[  145.158775] usbcore: registered new driver usbserial
[  145.167935] drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
[  145.176913] usbcore: registered new driver usbserial_generic
[  145.177015] drivers/usb/serial/usb-serial.c: USB Serial Driver core
[  165.969603] SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.59.116 DST=224.0.0.251 LEN=108 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=88 
[  197.947510] SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.59.116 DST=224.0.0.251 LEN=108 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=88 
[  388.749492] sonypi: Sony Programmable I/O Controller Driver v1.26.
[  389.958726] hdc: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
[  389.958846] Uniform CD-ROM driver Revision: 3.20
[  529.954351] gigaset: 16+0: if_open()
[  529.954513] gigaset: 0: if_ioctl(0x5401)
[  529.954531] gigaset: if_ioctl: arg not supported - 0x5401
[  529.954567] gigaset: 0: if_ioctl(0x5402)
[  529.954582] gigaset: if_ioctl: arg not supported - 0x5402
[  529.954605] gigaset: 0: if_set_termios()
[  529.954622] gigaset: 0: iflag 0 cflag cbd old cbd
[  529.954643] gigaset: 0: if_ioctl(0x5401)
[  529.954658] gigaset: if_ioctl: arg not supported - 0x5401
[  529.954684] gigaset: 0: if_ioctl(0xc0104703)
[  529.954700] gigaset: 0: if_version (1)
[  529.954730] gigaset: 0: if_ioctl(0xc0044700)
[  529.954747] gigaset: 0: if_lock (1)
[  529.954762] gigaset: scheduling IF_LOCK
[  529.954812] gigaset: connection state 0, event -112
[  529.954841] gigaset: allocated all channels
[  529.954874] gigaset: 0: if_ioctl(0xc0104703)
[  529.954890] gigaset: 0: if_version (2)
[  529.954904] gigaset: scheduling IF_VER
[  529.954923] gigaset: connection state 0, event -106
[  529.955017] gigaset: 0: if_write()
[  529.955037] gigaset: CMD Transmit (10 bytes): AT\^SGCI=1^M
[  529.955100] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  529.957405] bas_gigaset: write_command: sent 10 bytes, 0 left
[  529.980397] gigaset: received response (6 bytes): ^M^JOK^M^J
[  530.057733] gigaset: 0: if_write()
[  530.058501] gigaset: CMD Transmit (8 bytes): AT\^SLOG^M
[  530.058595] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  530.061343] bas_gigaset: write_command: sent 8 bytes, 0 left
[  530.092299] gigaset: received response (19 bytes): ^M^JZLOG=} } }%=} ~.^M^J
[  530.162140] gigaset: 0: if_write()
[  530.162247] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%=^M
[  530.162310] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  530.165216] bas_gigaset: write_command: sent 17 bytes, 0 left
[  530.207212] gigaset: received response (130 bytes): ZLOGR=}"J} =}%} } }8}#}3}&}'}&}'}!}-}!}(4797471} }"}&Laura} }%}!},}&}&Laura} }#
[  530.268631] gigaset: 0: if_ioctl(0xc0044700)
[  530.268756] gigaset: 0: if_lock (0)
[  530.268774] gigaset: scheduling IF_LOCK
[  530.269311] gigaset: connection state 0, event -112
[  530.269352] gigaset: unblocking all channels
[  530.269368] gigaset: blocking all channels
[  530.269383] gigaset: Scheduling PC_INIT
[  530.269404] gigaset: searching scheduled commands
[  530.269425] gigaset: connection state 0, event -27
[  530.270147] gigaset: 0: if_close()
[  531.188642] gigaset: scheduling timeout
[  531.188774] gigaset: connection state 100, event -105
[  531.188790] gigaset: stopped waiting
[  531.188817] gigaset: CMD Transmit (4 bytes): ATZ^M
[  531.188875] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  531.191285] bas_gigaset: write_command: sent 4 bytes, 0 left
[  531.219265] gigaset: received response (6 bytes): ^M^JOK^M^J
[  531.219384] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.219400] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.219416] bas_gigaset: cmd_loop: End of Command (2 Bytes)
[  531.219431] gigaset: raw string: 'OK'
[  531.219447] gigaset: CMD received: OK
[  531.219460] gigaset: available params: 0
[  531.219479] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.219497] gigaset: connection state 101, event 0
[  531.219519] gigaset: CMD Transmit (7 bytes): AT+GMR^M
[  531.219552] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  531.221227] bas_gigaset: write_command: sent 7 bytes, 0 left
[  531.251239] gigaset: received response (22 bytes): ^M^J04.204.02.01^M^J^M^JOK^M^J
[  531.251352] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.251369] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.251385] bas_gigaset: cmd_loop: End of Command (12 Bytes)
[  531.251401] gigaset: raw string: '04.204.02.01'
[  531.251423] gigaset: string==04.204.02.01
[  531.251437] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.251453] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.251468] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.251484] bas_gigaset: cmd_loop: End of Command (2 Bytes)
[  531.251499] gigaset: raw string: 'OK'
[  531.251514] gigaset: CMD received: OK
[  531.251528] gigaset: available params: 0
[  531.251543] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.251562] gigaset: connection state 120, event -20
[  531.251587] gigaset: connection state 121, event 0
[  531.251605] gigaset: firmware version 04.204.02.01
[  531.251622] gigaset: Scheduling PC_CIDMODE
[  531.251638] gigaset: searching scheduled commands
[  531.251661] gigaset: connection state 0, event -27
[  531.251684] gigaset: CMD Transmit (10 bytes): AT\^SGCI=1^M
[  531.251715] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  531.254210] bas_gigaset: write_command: sent 10 bytes, 0 left
[  531.283219] gigaset: received response (6 bytes): ^M^JOK^M^J
[  531.283488] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.283506] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.283522] bas_gigaset: cmd_loop: End of Command (2 Bytes)
[  531.283538] gigaset: raw string: 'OK'
[  531.283554] gigaset: CMD received: OK
[  531.283568] gigaset: available params: 0
[  531.283587] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  531.283605] gigaset: connection state 150, event 0
[  531.283635] gigaset: unblocking all channels
[  531.283655] gigaset: searching scheduled commands
[  746.581990] gigaset: 16+0: if_open()
[  746.582132] gigaset: 0: if_ioctl(0x5401)
[  746.582150] gigaset: if_ioctl: arg not supported - 0x5401
[  746.582179] gigaset: 0: if_ioctl(0x5402)
[  746.582195] gigaset: if_ioctl: arg not supported - 0x5402
[  746.582217] gigaset: 0: if_set_termios()
[  746.582233] gigaset: 0: iflag 0 cflag cbd old cbd
[  746.582254] gigaset: 0: if_ioctl(0x5401)
[  746.582269] gigaset: if_ioctl: arg not supported - 0x5401
[  746.582293] gigaset: 0: if_ioctl(0xc0104703)
[  746.582310] gigaset: 0: if_version (1)
[  746.582336] gigaset: 0: if_ioctl(0xc0044700)
[  746.582352] gigaset: 0: if_lock (1)
[  746.582368] gigaset: scheduling IF_LOCK
[  746.582927] gigaset: connection state 0, event -112
[  746.582960] gigaset: allocated all channels
[  746.582994] gigaset: 0: if_ioctl(0xc0104703)
[  746.583012] gigaset: 0: if_version (2)
[  746.583026] gigaset: scheduling IF_VER
[  746.583046] gigaset: connection state 0, event -106
[  746.583136] gigaset: 0: if_write()
[  746.583154] gigaset: CMD Transmit (10 bytes): AT\^SGCI=1^M
[  746.583203] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  746.585887] bas_gigaset: write_command: sent 10 bytes, 0 left
[  746.612869] gigaset: received response (6 bytes): ^M^JOK^M^J
[  746.687844] gigaset: 0: if_write()
[  746.687944] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%!^M
[  746.688002] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  746.690803] bas_gigaset: write_command: sent 17 bytes, 0 left
[  746.734773] gigaset: received response (86 bytes): ZLOGR=}*0} !}%} } } -}1}=}&}&}!},01716271220} }#}'470672} }$}'privat} }(}$}+~^B
[  746.791734] gigaset: 0: if_write()
[  746.791803] gigaset: CMD Transmit (8 bytes): AT\^SLOG^M
[  746.791855] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  746.794693] bas_gigaset: write_command: sent 8 bytes, 0 left
[  746.821681] gigaset: received response (19 bytes): ^M^JZLOG=} } }%=} ~.^M^J
[  746.895472] gigaset: 0: if_write()
[  746.895558] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%"^M
[  746.895616] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  746.898596] bas_gigaset: write_command: sent 17 bytes, 0 left
[  746.943580] gigaset: received response (89 bytes): ZLOGR=}!0} "}%} }  -}1}=}&}&}'}!}&}!})01930100} }#}'470672} }$}'privat} },}$}$}
[  746.999538] gigaset: 0: if_write()
[  746.999588] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%#^M
[  746.999634] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  747.002510] bas_gigaset: write_command: sent 17 bytes, 0 left
[  747.038488] gigaset: received response (57 bytes): ^M^JZLOGR=},}4} #}%} } })5}1}=}&}&}(}$}+~^B} } })}"}!} ADD3^M^J
[  747.103418] gigaset: 0: if_write()
[  747.103485] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%$^M
[  747.103537] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  747.106411] bas_gigaset: write_command: sent 17 bytes, 0 left
[  747.152396] gigaset: received response (124 bytes): ZLOGR=}"E} $}%} } $}"}3}=}&}&}'}!}(}!}(4797471} }"}&Laura} }%}!},}&}&Laura} }#}
[  747.207460] gigaset: 0: if_write()
[  747.207513] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%%^M
[  747.207564] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  747.210317] bas_gigaset: write_command: sent 17 bytes, 0 left
[  747.254283] gigaset: received response (58 bytes): ^M^JZLOGR=},}4} %}%} } }7}6}4}=}&}&}(}$},~^B} } })}"}$} 4958^M^J
[  747.311292] gigaset: 0: if_write()
[  747.311368] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%&^M
[  747.311423] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  747.314228] bas_gigaset: write_command: sent 17 bytes, 0 left
[  747.359206] gigaset: received response (105 bytes): ZLOGR=}+=} &}%} } '}6}4}=}&}&}!}'470672} }"}'privat} }%}!}+}&}(Familie} }#},017
[  747.415255] gigaset: 0: if_write()
[  747.415327] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%'^M
[  747.415384] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  747.418130] bas_gigaset: write_command: sent 17 bytes, 0 left
[  747.463109] gigaset: received response (110 bytes): ZLOGR=}"<} '}%} } $}6}4}=}&}&}'}!})}!}'470672} }"}'privat} }#})01930100} }+}*C}
[  747.519197] gigaset: 0: if_write()
[  747.519254] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%(^M
[  747.519307] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  747.522034] bas_gigaset: write_command: sent 17 bytes, 0 left
[  747.560027] gigaset: received response (125 bytes): ZLOGR=}"E} (}%} } }:}:}/}>}&}&}'}!}*}!}(4797471} }"}&Laura} }%}!},}&}&Laura} }#
[  747.623584] gigaset: 0: if_write()
[  747.623660] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%)^M
[  747.623716] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  747.625956] bas_gigaset: write_command: sent 17 bytes, 0 left
[  747.670920] gigaset: received response (91 bytes): ZLOGR=}!0} )}%} } .2}/}>}&}&}'}!}+}%}!},}&}&Laura} }#}(4797471} }$}&Laura} },}$
[  747.727027] gigaset: 0: if_write()
[  747.727100] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%*^M
[  747.727156] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  747.729843] bas_gigaset: write_command: sent 17 bytes, 0 left
[  747.774825] gigaset: received response (110 bytes): ZLOGR=}!>} *}%} } }(}"}2}>}&}&}'}!}-}!},02211207672} }%}!},}&}&Laura} }#}(47974
[  747.830994] gigaset: 0: if_write()
[  747.831099] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%+^M
[  747.831156] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  747.833753] bas_gigaset: write_command: sent 17 bytes, 0 left
[  747.878740] gigaset: received response (104 bytes): ZLOGR=}$<} +}%} } }6!}2}>}&}&}!}'470672} }"}'privat} }%}!}+}&}(Familie} }#}+022
[  747.934902] gigaset: 0: if_write()
[  747.934982] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%,^M
[  747.935042] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  747.937657] bas_gigaset: write_command: sent 17 bytes, 0 left
[  747.982644] gigaset: received response (105 bytes): ZLOGR=}$<} ,}%} } }+}/}3}>}&}&}!}'470672} }"}'privat} }%}!}+}&}(Familie} }#}+02
[  748.038812] gigaset: 0: if_write()
[  748.038870] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%-^M
[  748.038923] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  748.041552] bas_gigaset: write_command: sent 17 bytes, 0 left
[  748.077538] gigaset: received response (57 bytes): ^M^JZLOGR=},}4} -}%} } 1};}-}"}'}&}(}$}-~^B} } })}"}$} E972^M^J
[  748.142704] gigaset: 0: if_write()
[  748.142782] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%.^M
[  748.142836] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  748.145460] bas_gigaset: write_command: sent 17 bytes, 0 left
[  748.189435] gigaset: received response (57 bytes): ^M^JZLOGR=},}4} .}%} } 2};}-}"}'}&}(}$}.~^B} } })}"}$} 9068^M^J
[  748.246623] gigaset: 0: if_write()
[  748.246684] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%/^M
[  748.246735] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  748.249365] bas_gigaset: write_command: sent 17 bytes, 0 left
[  748.294348] gigaset: received response (105 bytes): ZLOGR=}+=} /}%} } }%}<}-}"}'}&}!}(4797470} }"}#PC} }%}!(}&}*PC Eltern} }#}-0160
[  748.350598] gigaset: 0: if_write()
[  748.350656] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%0^M
[  748.350710] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  748.353269] bas_gigaset: write_command: sent 17 bytes, 0 left
[  748.390248] gigaset: received response (108 bytes): ZLOGR=}"9} 0}%} } }"}<}-}"}'}&}'}!}2}!}(4797470} }"}#PC} }#})01930100} }+}*C} }
[  748.454545] gigaset: 0: if_write()
[  748.454623] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%1^M
[  748.454678] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  748.457176] bas_gigaset: write_command: sent 17 bytes, 0 left
[  748.502162] gigaset: received response (105 bytes): ZLOGR=}+=} 1}%} } }4}<}-}"}'}&}!}(4797470} }"}#PC} }%}!(}&}*PC Eltern} }#}-0160
[  748.558457] gigaset: 0: if_write()
[  748.558516] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%2^M
[  748.558570] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  748.561081] bas_gigaset: write_command: sent 17 bytes, 0 left
[  748.598067] gigaset: received response (108 bytes): ZLOGR=}"9} 2}%} } }1}<}-}"}'}&}'}!}3}!}(4797470} }"}#PC} }#})01930100} }+}*C} }
[  748.662400] gigaset: 0: if_write()
[  748.662472] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%3^M
[  748.662528] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  748.664985] bas_gigaset: write_command: sent 17 bytes, 0 left
[  748.701971] gigaset: received response (80 bytes): ZLOGR=}*)} 3}%} } } }=}-}"}'}&}!}(0193010} }#}(4797470} }$}#PC} }(}$}/~^B} } 22
[  748.766295] gigaset: 0: if_write()
[  748.766367] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%4^M
[  748.766423] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  748.768879] bas_gigaset: write_command: sent 17 bytes, 0 left
[  748.812871] gigaset: received response (87 bytes): ZLOGR=}!-} 4}%} } 7}<}-}"}'}&}'}!}4}!})01930100} }#}(4797470} }$}#PC} },}$}$} }
[  748.870223] gigaset: 0: if_write()
[  748.870307] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%5^M
[  748.870366] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  748.872796] bas_gigaset: write_command: sent 17 bytes, 0 left
[  748.917784] gigaset: received response (112 bytes): ZLOGR=}!A} 5}%} } }?)}1}"}'}&}'}!}6}!}-016097067988} }%}!}+}&}(Familie} }#}'470
[  748.974173] gigaset: 0: if_write()
[  748.974238] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%6^M
[  748.974294] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  748.977708] bas_gigaset: write_command: sent 17 bytes, 0 left
[  749.021683] gigaset: received response (111 bytes): ZLOGR=}!@} 6}%} } })'}2}"}'}&}'}!}8}!}-016097067988} }%}!}6}&}'Keller} }#}'4706
[  749.078113] gigaset: 0: if_write()
[  749.078167] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%7^M
[  749.078220] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  749.080600] bas_gigaset: write_command: sent 17 bytes, 0 left
[  749.117594] gigaset: received response (111 bytes): ZLOGR=}!@} 7}%} } }&/}5}"}'}&}'}!}!}!},07121630023} }%}!}+}&}(Familie} }#}'4706
[  749.181991] gigaset: 0: if_write()
[  749.182040] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%8^M
[  749.182084] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  749.184507] bas_gigaset: write_command: sent 17 bytes, 0 left
[  749.220492] gigaset: received response (72 bytes): ^M^JZLOGR=}# } 8}%} } }+}-}.}#}'}&}#}'465071} }$}%B~|ro} },}$}%} } } BD96^M^J
[  749.285931] gigaset: 0: if_write()
[  749.286000] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%9^M
[  749.286054] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  749.288418] bas_gigaset: write_command: sent 17 bytes, 0 left
[  749.333400] gigaset: received response (135 bytes): ZLOGR=}"N} 9}%} } }2}=}1}#}'}&}'}!}&}!}'470672} }"}'privat} }%}!}+}&}(Familie} 
[  749.389910] gigaset: 0: if_write()
[  749.389984] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%:^M
[  749.390039] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  749.392319] bas_gigaset: write_command: sent 17 bytes, 0 left
[  749.438306] gigaset: received response (128 bytes): ZLOGR=}"H} :}%} } }7}7}-}$}'}&}'}!}(}!}'470672} }"}'privat} }%}!}+}&}(Familie} 
[  749.493832] gigaset: 0: if_write()
[  749.493884] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%;^M
[  749.493939] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  749.497224] bas_gigaset: write_command: sent 17 bytes, 0 left
[  749.541207] gigaset: received response (111 bytes): ZLOGR=}!@} ;}%} } }$,}3}$}'}&}'}!})}!},02289637153} }%}!}+}&}(Familie} }#}'4706
[  749.597741] gigaset: 0: if_write()
[  749.597797] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%<^M
[  749.597850] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  749.600127] bas_gigaset: write_command: sent 17 bytes, 0 left
[  749.637114] gigaset: received response (90 bytes): ZLOGR=}!,} <}%} } }&}#}.}&}'}&}'}!}+}%}!}5}&}$Fax} }#}(4299019} }$}$Fax} },}$}'
[  749.701658] gigaset: 0: if_write()
[  749.701728] gigaset: CMD Transmit (17 bytes): AT\^SLOGR=} } }%=^M
[  749.701782] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  749.704042] bas_gigaset: write_command: sent 17 bytes, 0 left
[  749.750008] gigaset: received response (130 bytes): ZLOGR=}"J} =}%} } }8}#}3}&}'}&}'}!}-}!}(4797471} }"}&Laura} }%}!},}&}&Laura} }#
[  749.805632] gigaset: 0: if_ioctl(0xc0044700)
[  749.805683] gigaset: 0: if_lock (0)
[  749.805699] gigaset: scheduling IF_LOCK
[  749.806345] gigaset: connection state 0, event -112
[  749.806381] gigaset: unblocking all channels
[  749.806397] gigaset: blocking all channels
[  749.806412] gigaset: Scheduling PC_INIT
[  749.806432] gigaset: searching scheduled commands
[  749.806451] gigaset: connection state 0, event -27
[  749.806515] gigaset: 0: if_close()
[  750.736702] gigaset: scheduling timeout
[  750.736802] gigaset: connection state 100, event -105
[  750.736819] gigaset: stopped waiting
[  750.736848] gigaset: CMD Transmit (4 bytes): ATZ^M
[  750.736897] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  750.739074] bas_gigaset: write_command: sent 4 bytes, 0 left
[  750.770048] gigaset: received response (6 bytes): ^M^JOK^M^J
[  750.770093] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.770109] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.770125] bas_gigaset: cmd_loop: End of Command (2 Bytes)
[  750.770140] gigaset: raw string: 'OK'
[  750.770155] gigaset: CMD received: OK
[  750.770169] gigaset: available params: 0
[  750.770185] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.770202] gigaset: connection state 101, event 0
[  750.770221] gigaset: CMD Transmit (7 bytes): AT+GMR^M
[  750.770248] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  750.772024] bas_gigaset: write_command: sent 7 bytes, 0 left
[  750.810011] gigaset: received response (22 bytes): ^M^J04.204.02.01^M^J^M^JOK^M^J
[  750.810064] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.810080] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.810096] bas_gigaset: cmd_loop: End of Command (12 Bytes)
[  750.810111] gigaset: raw string: '04.204.02.01'
[  750.810131] gigaset: string==04.204.02.01
[  750.810146] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.810161] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.810177] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.810192] bas_gigaset: cmd_loop: End of Command (2 Bytes)
[  750.810207] gigaset: raw string: 'OK'
[  750.810221] gigaset: CMD received: OK
[  750.810235] gigaset: available params: 0
[  750.810250] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.810267] gigaset: connection state 120, event -20
[  750.810289] gigaset: connection state 121, event 0
[  750.810306] gigaset: firmware version 04.204.02.01
[  750.810322] gigaset: Scheduling PC_CIDMODE
[  750.810339] gigaset: searching scheduled commands
[  750.810361] gigaset: connection state 0, event -27
[  750.810382] gigaset: CMD Transmit (10 bytes): AT\^SGCI=1^M
[  750.810413] bas_gigaset: setting ATREADY timeout of 3/10 secs
[  750.811988] bas_gigaset: write_command: sent 10 bytes, 0 left
[  750.833980] gigaset: received response (6 bytes): ^M^JOK^M^J
[  750.834013] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.834029] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.834045] bas_gigaset: cmd_loop: End of Command (2 Bytes)
[  750.834060] gigaset: raw string: 'OK'
[  750.834074] gigaset: CMD received: OK
[  750.834087] gigaset: available params: 0
[  750.834102] bas_gigaset: cmd_loop: End of Command (0 Bytes)
[  750.834119] gigaset: connection state 150, event 0
[  750.834140] gigaset: unblocking all channels
[  750.834157] gigaset: searching scheduled commands
[  764.628798] SFW2-INext-ACC-TCP IN=eth0 OUT= MAC=00:b0:d0:ed:50:2a:00:50:da:82:a0:46:08:00 SRC=192.168.59.127 DST=192.168.59.116 LEN=48 TOS=0x00 PREC=0x00 TTL=128 ID=9764 DF PROTO=TCP SPT=1162 DPT=22 WINDOW=16384 RES=0x00 SYN URGP=0 OPT (020405B401010402) 
[ 4341.332193] SFW2-INext-ACC-TCP IN=eth0 OUT= MAC=00:b0:d0:ed:50:2a:00:50:da:82:a0:46:08:00 SRC=192.168.59.127 DST=192.168.59.116 LEN=48 TOS=0x00 PREC=0x00 TTL=128 ID=12798 DF PROTO=TCP SPT=1181 DPT=22 WINDOW=16384 RES=0x00 SYN URGP=0 OPT (020405B401010402) 

--------------070505010702050803030907--

--------------enigAAAA1E5918F5BE377F011FC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErahKMdB4Whm86/kRAohWAJ0Rz3TuqA0PMOwdxpWf9t9xSOY9UQCfYtwv
kBPW5xBJdvLDWa0QzkPWObo=
=LVdn
-----END PGP SIGNATURE-----

--------------enigAAAA1E5918F5BE377F011FC5--
