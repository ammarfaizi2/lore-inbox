Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTKAPL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 10:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTKAPL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 10:11:29 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:36277 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263851AbTKAPLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 10:11:22 -0500
Date: Sat, 01 Nov 2003 07:11:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1468] New: oops while running xawtv with bttv	driver
Message-ID: <1440000.1067699472@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1468

           Summary: oops while running xawtv with bttv driver
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: tom@carrott.org


Distribution: Debian Unstable
Hardware Environment: intel pentium 3

Nov  2 01:08:25 tv syslogd 1.4.1#13: restart.
Nov  2 01:08:25 tv kernel: klogd 1.4.1#13, log source = /proc/kmsg started.
Nov  2 01:08:25 tv kernel: Inspecting /boot/System.map-2.6.0-test9
Nov  2 01:08:25 tv kernel: Loaded 21492 symbols from /boot/System.map-2.6.0-test9.
Nov  2 01:08:25 tv kernel: Symbols match kernel version 2.6.0.
Nov  2 01:08:25 tv kernel: No module symbols loaded - kernel modules not enabled.
Nov  2 01:08:25 tv kernel: Linux version 2.6.0-test9 (tparker@amislave) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Wed Oct 29
 00:52:45 NZDT 2003
Nov  2 01:08:25 tv kernel: BIOS-provided physical RAM map:
Nov  2 01:08:25 tv kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Nov  2 01:08:25 tv kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov  2 01:08:25 tv kernel:  BIOS-e820: 0000000000100000 - 0000000007f9e000 (usable)
Nov  2 01:08:25 tv kernel:  BIOS-e820: 0000000007f9e000 - 0000000008000000 (reserved)
Nov  2 01:08:25 tv kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Nov  2 01:08:25 tv kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Nov  2 01:08:25 tv kernel:  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Nov  2 01:08:25 tv kernel: 127MB LOWMEM available.
Nov  2 01:08:25 tv kernel: On node 0 totalpages: 32670
Nov  2 01:08:25 tv kernel:   DMA zone: 4096 pages, LIFO batch:1
Nov  2 01:08:25 tv kernel:   Normal zone: 28574 pages, LIFO batch:6
Nov  2 01:08:25 tv kernel:   HighMem zone: 0 pages, LIFO batch:1
Nov  2 01:08:25 tv kernel: DMI 2.3 present.
Nov  2 01:08:25 tv kernel: ACPI: RSDP (v000 DELL                                      ) @ 0x000fd720
Nov  2 01:08:25 tv kernel: ACPI: RSDT (v001 DELL    WS 220  0x00000008 ASL  0x00000061) @ 0x000fd734
Nov  2 01:08:25 tv kernel: ACPI: FADT (v001 DELL    WS 220  0x00000008 ASL  0x00000061) @ 0x000fd760
Nov  2 01:08:25 tv kernel: ACPI: MADT (v001 DELL    WS 220  0x00000008 ASL  0x00000061) @ 0x000fd7d4
Nov  2 01:08:25 tv kernel: ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000b) @ 0x00000000
Nov  2 01:08:25 tv kernel: Building zonelist for node : 0
Nov  2 01:08:25 tv kernel: Kernel command line: rw root=/dev/nfs root=/dev/nfs nfsroot=192.168.1.1:/tv,exec ip=192.168.1.7:192.168.1.1:
255.255.255.0:tv:eth0
Nov  2 01:08:25 tv kernel: Initializing CPU#0
Nov  2 01:08:25 tv kernel: PID hash table entries: 512 (order 9: 4096 bytes)
Nov  2 01:08:25 tv kernel: Detected 662.225 MHz processor.
Nov  2 01:08:25 tv kernel: Console: colour VGA+ 80x25
Nov  2 01:08:25 tv kernel: Memory: 125656k/130680k available (1808k kernel code, 4484k reserved, 827k data, 284k init, 0k highmem)
Nov  2 01:08:25 tv kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Nov  2 01:08:25 tv kernel: Calibrating delay loop... 1306.62 BogoMIPS
Nov  2 01:08:25 tv kernel: Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Nov  2 01:08:25 tv kernel: Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Nov  2 01:08:25 tv kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Nov  2 01:08:25 tv kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Nov  2 01:08:25 tv kernel: CPU: L2 cache: 256K
Nov  2 01:08:25 tv kernel: Intel machine check architecture supported.
Nov  2 01:08:25 tv kernel: Intel machine check reporting enabled on CPU#0.
Nov  2 01:08:25 tv kernel: CPU: Intel Pentium III (Coppermine) stepping 01
Nov  2 01:08:25 tv kernel: Enabling fast FPU save and restore... done.
Nov  2 01:08:25 tv kernel: Enabling unmasked SIMD FPU exception support... done.
Nov  2 01:08:25 tv kernel: Checking 'hlt' instruction... OK.
Nov  2 01:08:25 tv kernel: POSIX conformance testing by UNIFIX
Nov  2 01:08:25 tv kernel: NET: Registered protocol family 16
Nov  2 01:08:25 tv kernel: PCI: PCI BIOS revision 2.10 entry at 0xfc05e, last bus=2
Nov  2 01:08:25 tv kernel: PCI: Using configuration type 1
Nov  2 01:08:25 tv kernel: mtrr: v2.0 (20020519)
Nov  2 01:08:25 tv kernel: ACPI: Subsystem revision 20031002
Nov  2 01:08:25 tv kernel: ACPI: Interpreter enabled
Nov  2 01:08:25 tv kernel: ACPI: Using PIC for interrupt routing
Nov  2 01:08:25 tv kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Nov  2 01:08:25 tv kernel: PCI: Probing PCI hardware (bus 00)
Nov  2 01:08:25 tv kernel: Transparent bridge - 0000:00:1e.0
Nov  2 01:08:25 tv kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 15)
Nov  2 01:08:25 tv kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Nov  2 01:08:25 tv kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Nov  2 01:08:25 tv kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Nov  2 01:08:25 tv kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Nov  2 01:08:25 tv kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Nov  2 01:08:25 tv kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
Nov  2 01:08:25 tv kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Nov  2 01:08:25 tv kernel: PCI: Using ACPI for IRQ routing
Nov  2 01:08:25 tv kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Nov  2 01:08:25 tv kernel: ACPI: Power Button (FF) [PWRF]
Nov  2 01:08:25 tv kernel: ACPI: Processor [CPU0] (supports C1)
Nov  2 01:08:25 tv kernel: pty: 256 Unix98 ptys configured
Nov  2 01:08:25 tv kernel: Linux agpgart interface v0.100 (c) Dave Jones
Nov  2 01:08:25 tv kernel: agpgart: Detected an Intel i820 Chipset.
Nov  2 01:08:25 tv kernel: agpgart: Maximum main memory to use for agp memory: 94M
Nov  2 01:08:25 tv kernel: agpgart: AGP aperture is 64M @ 0xf0000000
Nov  2 01:08:25 tv kernel: [drm] Initialized mga 3.1.0 20021029 on minor 0
Nov  2 01:08:25 tv kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Nov  2 01:08:25 tv kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov  2 01:08:25 tv kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Nov  2 01:08:25 tv kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Nov  2 01:08:25 tv kernel: 0000:02:0c.0: 3Com PCI 3c905C Tornado at 0xec00. Vers LK1.1.19
Nov  2 01:08:25 tv kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Nov  2 01:08:25 tv kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov  2 01:08:25 tv kernel: ICH: IDE controller at PCI slot 0000:00:1f.1
Nov  2 01:08:25 tv kernel: ICH: chipset revision 2
Nov  2 01:08:25 tv kernel: ICH: not 100%% native mode: will probe irqs later
Nov  2 01:08:25 tv kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Nov  2 01:08:25 tv kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Nov  2 01:08:25 tv kernel: hda: QUANTUM BIGFOOT1280A, ATA DISK drive
Nov  2 01:08:25 tv kernel: Using anticipatory io scheduler
Nov  2 01:08:25 tv kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov  2 01:08:25 tv kernel: hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 013, ATAPI CD/DVD-ROM drive
Nov  2 01:08:25 tv kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov  2 01:08:25 tv kernel: hda: max request size: 128KiB
Nov  2 01:08:25 tv kernel: hda: 2511936 sectors (1286 MB) w/87KiB Cache, CHS=2492/16/63, DMA
Nov  2 01:08:25 tv kernel:  hda: hda1
Nov  2 01:08:25 tv kernel: end_request: I/O error, dev hdc, sector 0
Nov  2 01:08:25 tv kernel: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Nov  2 01:08:25 tv kernel: Uniform CD-ROM driver Revision: 3.12
Nov  2 01:08:25 tv kernel: mice: PS/2 mouse device common for all mice
Nov  2 01:08:25 tv kernel: input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
Nov  2 01:08:25 tv kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov  2 01:08:25 tv kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov  2 01:08:25 tv kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov  2 01:08:25 tv kernel: NET: Registered protocol family 2
Nov  2 01:08:25 tv kernel: IP: routing cache hash table of 128 buckets, 4Kbytes
Nov  2 01:08:25 tv kernel: TCP: Hash tables configured (established 8192 bind 2340)
Nov  2 01:08:25 tv kernel: NET: Registered protocol family 1
Nov  2 01:08:25 tv kernel: NET: Registered protocol family 17
Nov  2 01:08:25 tv kernel: Looking up port of RPC 100003/2 on 192.168.1.1
Nov  2 01:08:25 tv kernel: Looking up port of RPC 100005/1 on 192.168.1.1
Nov  2 01:08:25 tv kernel: VFS: Mounted root (nfs filesystem).
Nov  2 01:08:25 tv kernel: Freeing unused kernel memory: 284k freed
Nov  2 01:08:25 tv kernel: Adding 1255928k swap on /dev/hda1.  Priority:-1 extents:1
Nov  2 01:08:25 tv kernel: Real Time Clock Driver v1.12
Nov  2 01:08:31 tv xfs: ignoring font path element /usr/lib/X11/fonts/CID/ (unreadable)
Nov  2 01:08:31 tv xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable)
Nov  2 01:08:40 tv kernel: Linux video capture interface: v1.00
Nov  2 01:08:40 tv kernel: bttv: driver version 0.9.12 loaded
Nov  2 01:08:40 tv kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Nov  2 01:08:40 tv kernel: bttv: Bt8xx card found (0).
Nov  2 01:08:40 tv kernel: bttv0: Bt878 (rev 17) at 0000:02:0b.0, irq: 9, latency: 64, mmio: 0xf6001000
Nov  2 01:08:40 tv kernel: bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
Nov  2 01:08:40 tv kernel: bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
Nov  2 01:08:40 tv kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not found
Nov  2 01:08:40 tv kernel: bttv0: miro: id=25 tuner=1 radio=no stereo=no
Nov  2 01:08:40 tv kernel: bttv0: using tuner=1
Nov  2 01:08:40 tv kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not found
Nov  2 01:08:40 tv kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found
Nov  2 01:08:40 tv kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Nov  2 01:08:40 tv kernel: tvaudio: TV audio decoder + audio/video mux driver
Nov  2 01:08:40 tv kernel: tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),t
a8874z
Nov  2 01:08:41 tv kernel: tuner: chip found @ 0xc0
Nov  2 01:08:41 tv kernel: tuner: type set to 1 (Philips PAL_I (FI1246 and compatibles))
Nov  2 01:08:41 tv kernel: registering 0-0060
Nov  2 01:08:41 tv kernel: bttv0: registered device video0
Nov  2 01:08:41 tv kernel: bttv0: registered device vbi0
Nov  2 01:08:41 tv kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Nov  2 01:08:44 tv kernel: mtrr: base(0xf4000000) is not aligned on a size(0x1800000) boundary
Nov  2 01:08:44 tv kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Nov  2 01:08:44 tv kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Nov  2 01:08:44 tv kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Nov  2 01:09:10 tv gconfd (tparker-379): starting (version 2.4.0.1), pid 379 user 'tparker'
Nov  2 01:09:10 tv gconfd (tparker-379): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source at
 position 0
Nov  2 01:09:10 tv gconfd (tparker-379): Resolved address "xml:readwrite:/home/tparker/.gconf" to a writable config source at position
1
Nov  2 01:09:10 tv gconfd (tparker-379): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at
position 2
Nov  2 01:09:24 tv kernel: cdrom: This disc doesn't have any tracks I recognize!
Nov  2 01:13:20 tv kernel: bttv0: OCERR @ 03f33014,bits: HSYNC OCERR*
Nov  2 01:13:21 tv last message repeated 11 times
Nov  2 01:13:21 tv kernel: bttv0: timeout: risc=03f3301c, bits: HSYNC
Nov  2 01:13:21 tv kernel: bttv0: reset, reinitialize
Nov  2 01:13:21 tv kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Nov  2 01:13:24 tv kernel: bttv0: skipped frame. no signal? high irq latency?
Nov  2 01:14:03 tv kernel: bttv0: skipped frame. no signal? high irq latency?

Software Environment:
This is xawtv-3.90, running on Linux/i686 (2.6.0-test9) 

Problem Description:
Nov  2 01:14:57 tv kernel:  printing eip:
Nov  2 01:14:57 tv kernel: c89ef6f7
Nov  2 01:14:57 tv kernel: Oops: 0002 [#1]
Nov  2 01:14:57 tv kernel: CPU:    0
Nov  2 01:14:58 tv kernel: EIP:    0060:[_end+140482519/1069580512]    Not tainted
Nov  2 01:14:58 tv kernel: EFLAGS: 00010202
Nov  2 01:14:58 tv kernel: EIP is at bttv_risc_packed+0x107/0x158 [bttv]
Nov  2 01:14:58 tv kernel: eax: 00001000   ebx: c4a06000   ecx: 00000008   edx: c5ac1800
Nov  2 01:14:58 tv kernel: esi: 00000408   edi: 14000008   ebp: c25f1e50   esp: c25f1e40
Nov  2 01:14:58 tv kernel: ds: 007b   es: 007b   ss: 0068
Nov  2 01:14:58 tv kernel: Process xawtv (pid: 437, threadinfo=c25f0000 task=c4f25960)
Nov  2 01:14:58 tv kernel: Stack: 00000c00 000d8000 c4bfbef8 00000100 c25f1eb0 c89f0a7d c8a00440 c4bfbfb8
Nov  2 01:14:58 tv kernel:        c5ac0000 00000c00 00000c00 00000c00 00000120 c8a00440 c4bfbfa8 c5ac0000
Nov  2 01:14:58 tv kernel:        00000000 00000c00 00000c00 00000120 00000000 c4bfbef8 00000300 c89c8935
Nov  2 01:14:58 tv kernel: Call Trace:
Nov  2 01:14:58 tv kernel:  [_end+140487517/1069580512] bttv_buffer_risc+0x179/0x4ac [bttv]
Nov  2 01:14:58 tv kernel:  [_end+140323349/1069580512] videobuf_iolock+0xcd/0xdc [video_buf]
Nov  2 01:14:58 tv kernel:  [_end+140455190/1069580512] bttv_prepare_buffer+0x132/0x164 [bttv]
Nov  2 01:14:58 tv kernel:  [_end+140455382/1069580512] buffer_prepare+0x2e/0x34 [bttv]
Nov  2 01:14:58 tv kernel:  [_end+140326232/1069580512] videobuf_read_zerocopy+0x64/0x214 [video_buf]
Nov  2 01:14:58 tv kernel:  [_end+140326786/1069580512] videobuf_read_one+0x7a/0x35c [video_buf]
Nov  2 01:14:58 tv kernel:  [_end+140465975/1069580512] bttv_read+0x87/0xe4 [bttv]
Nov  2 01:14:58 tv kernel:  [vfs_read+162/212] vfs_read+0xa2/0xd4
Nov  2 01:14:58 tv kernel:  [sys_read+48/80] sys_read+0x30/0x50
Nov  2 01:14:58 tv kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov  2 01:14:58 tv kernel:
Nov  2 01:14:58 tv kernel: Code: 89 3b 8b 42 08 83 c3 04 89 03 83 c3 04 89 ce 03 75 1c 8b 4d

tv:/var/log# ksymoops /tmp/oops
ksymoops 2.4.9 on i686 2.6.0-test9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test9/ (default)
     -m /boot/System.map-2.6.0-test9 (default)
 
Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.
 
Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Nov  2 01:14:57 tv kernel: c89ef6f7
Nov  2 01:14:57 tv kernel: Oops: 0002 [#1]
Nov  2 01:14:57 tv kernel: CPU:    0
Nov  2 01:14:58 tv kernel: EIP:    0060:[_end+140482519/1069580512]    Not tainted
Nov  2 01:14:58 tv kernel: EFLAGS: 00010202
Nov  2 01:14:58 tv kernel: eax: 00001000   ebx: c4a06000   ecx: 00000008   edx: c5ac1800
Nov  2 01:14:58 tv kernel: esi: 00000408   edi: 14000008   ebp: c25f1e50   esp: c25f1e40
Nov  2 01:14:58 tv kernel: ds: 007b   es: 007b   ss: 0068
Nov  2 01:14:58 tv kernel: Stack: 00000c00 000d8000 c4bfbef8 00000100 c25f1eb0 c89f0a7d c8a00440 c4bfbfb8
Nov  2 01:14:58 tv kernel:        c5ac0000 00000c00 00000c00 00000c00 00000120 c8a00440 c4bfbfa8 c5ac0000
Nov  2 01:14:58 tv kernel:        00000000 00000c00 00000c00 00000120 00000000 c4bfbef8 00000300 c89c8935
Nov  2 01:14:58 tv kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available
 
 
>> ebx; c4a06000 <_end+46100e0/3fc080e0>
>> edx; c5ac1800 <_end+56cb8e0/3fc080e0>
>> ebp; c25f1e50 <_end+21fbf30/3fc080e0>
>> esp; c25f1e40 <_end+21fbf20/3fc080e0>
 
Nov  2 01:14:58 tv kernel: Code: 89 3b 8b 42 08 83 c3 04 89 03 83 c3 04 89 ce 03 75 1c 8b 4d
Using defaults from ksymoops -t elf32-i386 -a i386
 
 
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 3b                     mov    %edi,(%ebx)
Code;  00000002 Before first symbol
   2:   8b 42 08                  mov    0x8(%edx),%eax
Code;  00000005 Before first symbol
   5:   83 c3 04                  add    $0x4,%ebx
Code;  00000008 Before first symbol
   8:   89 03                     mov    %eax,(%ebx)
Code;  0000000a Before first symbol
   a:   83 c3 04                  add    $0x4,%ebx
Code;  0000000d Before first symbol
   d:   89 ce                     mov    %ecx,%esi
Code;  0000000f Before first symbol
   f:   03 75 1c                  add    0x1c(%ebp),%esi
Code;  00000012 Before first symbol
  12:   8b 4d 00                  mov    0x0(%ebp),%ecx
 
 
2 warnings and 1 error issued.  Results may not be reliable.

Steps to reproduce:
start xawtv, start changing channels, oops results reasonably quickly


