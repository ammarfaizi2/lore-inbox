Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbUKCF7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUKCF7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 00:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUKCF7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 00:59:49 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:16804 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261433AbUKCF7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 00:59:30 -0500
Message-ID: <418873A4.8020209@biomail.ucsd.edu>
Date: Tue, 02 Nov 2004 21:59:00 -0800
From: John Gilbert <jgilbert@biomail.ucsd.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops in  2.6.10-rc1-mm2 module_refcount
Content-Type: multipart/mixed;
 boundary="------------030701040803080807090503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030701040803080807090503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,
Here's the log with the oops. It seems to be running on anyway.
Oh, and BTW, changing to CONFIG_PNPACPI=n fixed my non working keyboard 
on this machine.
Thanks.
John G.
jgilbert@biomail.ucsd.edu

--------------030701040803080807090503
Content-Type: text/plain;
 name="10r1m2log02"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="10r1m2log02"

Linux version 2.6.10-rc1-mm2-pleiades (root@pleiades) (gcc version 3.4.2) #1 Tue Nov 2 21:40:12 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffea800 (usable)
 BIOS-e820: 000000001ffea800 - 0000000020000000 (reserved)
 BIOS-e820: 00000000feea0000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131050
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126954 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fde50
ACPI: RSDT (v001 DELL    CPi R   0x27d30303 ASL  0x00000061) @ 0x000fde64
ACPI: FADT (v001 DELL    CPi R   0x27d30303 ASL  0x00000061) @ 0x000fde90
ACPI: BOOT (v001 DELL    CPi R   0x27d30303 ASL  0x00000061) @ 0x000fdf04
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6.10r1m2 ro root=301 hdb=ide-cd
ide_setup: hdb=ide-cd
CPU 0 irqstacks, hard=c058f000 soft=c058e000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1196.319 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513864k/524200k available (3491k kernel code, 9816k reserved, 972k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2367.48 BogoMIPS (lpj=1183744)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1200MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc06e, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041015
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5 7)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: Power Resource [PADA] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: the driver 'system' has been registered
Simple Boot Flag at 0x79 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1099432244.631:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
radeonfb_pci_register BEGIN
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
radeonfb: probed DDR SGRAM 65536k videoram
radeonfb: mapped 16384k videoram
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=260.00 Mhz, System=183.00 MHz
radeonfb: PLL min 12000 max 40000
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-1: registered as adapter #1
i2c_adapter i2c-2: registered as adapter #2
i2c_adapter i2c-3: registered as adapter #3
1 chips in connector info
 - chip 1 has 1 connectors
  * connector 0 of type 2 (CRT) : 2300
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
radeonfb: I2C (port 2) ... not found
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
radeonfb: I2C (port 3) ... not found
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
radeonfb: I2C (port 4) ... not found
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
radeonfb: I2C (port 2) ... not found
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
radeonfb: I2C (port 4) ... not found
Non-DDC laptop panel detected
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
radeonfb: I2C (port 3) ... not found
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: LCD LTM15C166
          
radeonfb: detected LVDS panel size from BIOS: 1600x1200
BIOS provided panel power delay: 1000
radeondb: BIOS provided dividers will be used
ref_divider = 2
post_divider = 1
fbk_divider = 18
Scanning BIOS table ...
 320 x 350
 320 x 400
 320 x 400
 320 x 480
 400 x 600
 512 x 384
 640 x 350
 640 x 400
 640 x 475
 640 x 480
 720 x 480
 720 x 576
 800 x 600
 848 x 480
 1024 x 768
 1280 x 1024
 1600 x 1200
Found panel in BIOS table:
  hblank: 560
  hOver_plus: 56
  hSync_width: 192
  vblank: 50
  vOver_plus: 1
  vSync_width: 3
  clock: 16200
Setting up default mode based on panel info
radeonfb: Power Management enabled for Mobility chipsets
hStart = 1656, hEnd = 1848, hTotal = 2160
vStart = 1201, vEnd = 1204, vTotal = 1250
h_total_disp = 0xc7010d	   hsync_strt_wid = 0x180672
v_total_disp = 0x4af04e1	   vsync_strt_wid = 0x304b0
pixclock = 6172
freq = 16202
Console: switching to colour frame buffer device 200x150
radeonfb: ATI Radeon LW  DDR SGRAM 64 MB
radeonfb_pci_register END
vesafb: probe of vesafb0 failed with error -6
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THM] (59 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: the driver 'parport_pc' has been registered
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC0] at I/O 0x3f2-0x3f5, 0x3f7 irq 6 dma channel 2
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:06.0: 3Com PCI 3c556 Laptop Tornado at 0xe800. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2M: IDE controller at PCI slot 0000:00:1f.1
ICH2M: chipset revision 3
ICH2M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK4018GAP, ATA DISK drive
hdb: HL-DT-STCD-RW/DVD-ROM GCC-4240N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
PCI: Enabling device 0000:02:0f.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:02:0f.0[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:0f.0 [1028:00e6]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:0f.0, mfunc 0x05033002, devctl 0x64
Yenta: ISA IRQ mask 0x0098, PCI irq 10
Socket status: 30000010
PCI: Enabling device 0000:02:0f.1 (0000 -> 0002)
ACPI: PCI interrupt 0000:02:0f.1[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:0f.1 [1028:00e6]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:0f.1, mfunc 0x05033002, devctl 0x64
Yenta: ISA IRQ mask 0x0098, PCI irq 10
Socket status: 30000010
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 10, io base 0xdce0
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.7
 180 degree mounted touchpad
 Sensor: 1
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
Please email the following PERFCTR INIT lines to mikpe@csd.uu.se
To remove this message, rebuild the driver with CONFIG_PERFCTR_INIT_TESTS=n
PERFCTR INIT: vendor 0, family 6, model 11, stepping 1, clock 1196319 kHz
PERFCTR INIT: NITER == 64
PERFCTR INIT: loop overhead is 239 cycles
PERFCTR INIT: rdtsc cost is 34.4 cycles (2443 total)
PERFCTR INIT: rdpmc cost is 35.9 cycles (2540 total)
PERFCTR INIT: rdmsr (counter) cost is 90.4 cycles (6028 total)
PERFCTR INIT: rdmsr (evntsel) cost is 71.9 cycles (4843 total)
PERFCTR INIT: wrmsr (counter) cost is 100.7 cycles (6687 total)
PERFCTR INIT: wrmsr (evntsel) cost is 96.1 cycles (6392 total)
PERFCTR INIT: read cr4 cost is 1.8 cycles (358 total)
PERFCTR INIT: write cr4 cost is 42.2 cycles (2944 total)
PERFCTR INIT: sync_core cost is 147.3 cycles (9669 total)
perfctr: driver 2.7.6, cpu type Intel P6 at 1196319 kHz
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 324 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S4bios S5)
ACPI wakeup devices: 
 LID PBTN PCI0 UAR1 USB0 PCIE MPCI 
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0820-0x08ff: excluding 0x8c0-0x8cf
cs: IO port probe 0x0800-0x080f: clean.
cs: IO port probe 0x03e0-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0100-0x03af: excluding 0x170-0x177 0x280-0x287 0x370-0x37f
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Unable to handle kernel NULL pointer dereference at virtual address 000000a0
 printing eip:
c0146807
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in:
CPU:    0
EIP:    0060:[<c0146807>]    Not tainted VLI
EFLAGS: 00010282   (2.6.10-rc1-mm2-pleiades) 
EIP is at module_refcount+0x7/0x10
eax: 00000000   ebx: df21af1c   ecx: c051dc74   edx: c051dc2c
esi: c051dc20   edi: c0523bcc   ebp: df21aee0   esp: df21aec4
ds: 007b   es: 007b   ss: 0068
Process cardmgr (pid: 1315, threadinfo=df21a000 task=df687710)
Stack: c038c0e0 00000000 c051dc74 c051dc2c df21aee0 c051dc2c c0523b80 df21af04 
       c033923a c051dc2c df21af1c 00000000 c0523bf8 df554000 df554000 00000400 
       df21af24 c038c13f c0523b80 00000000 df21af1c c038c0c0 df554000 00000000 
Call Trace:
 [<c010645f>] show_stack+0x7f/0xa0
 [<c01065f6>] show_registers+0x156/0x1d0
 [<c0106886>] die+0x156/0x2f0
 [<c0118cf6>] do_page_fault+0x496/0x6b5
 [<c0105f7d>] error_code+0x2d/0x38
 [<c033923a>] bus_for_each_drv+0x7a/0xd0
 [<c038c13f>] proc_read_drivers+0x2f/0x40
 [<c01cb014>] proc_file_read+0xc4/0x260
 [<c0180598>] vfs_read+0xf8/0x140
 [<c018086b>] sys_read+0x4b/0x80
 [<c0105dd3>] syscall_call+0x7/0xb
Code: 5d c3 89 f6 8b 03 89 04 24 e8 16 00 00 00 85 c0 74 e2 8b 43 08 c7 00 00 00 00 00 b8 f5 ff ff ff 5a 5b 5d c3 55 89 e5 8b 45 08 5d <8b> 80 a0 00 00 00 c3 89 f6 55 89 e5 57 bf a0 1b 4d c0 89 f9 56 
 <6>ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 5 (level, low) -> IRQ 5
maestro3: enabled hack for 'Dell Inspiron 8100'
i8xx TCO timer: initialized (0x0860). heartbeat=30 sec (nowayout=0)

--------------030701040803080807090503--
