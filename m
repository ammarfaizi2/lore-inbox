Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbTL2TIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbTL2TIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:08:46 -0500
Received: from mx1.metacolo.net ([193.111.87.3]:3031 "EHLO mx1.metacolo.net")
	by vger.kernel.org with ESMTP id S265371AbTL2TGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:06:37 -0500
Date: Mon, 29 Dec 2003 19:06:36 +0000
From: Ryan Lackey <ryan@venona.com>
To: linux-kernel@vger.kernel.org
Subject: cisco airo problem on apm reinsert w/ 2.6.0-*
Message-ID: <20031229190636.GA2100@metacolo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since at least 2.6.0-test7, I've had problems when re-inserting my cisco
airo 340 pc card after sleeping the system.  It doesn't happen 100% of
the time, but happens about 90% of the time -- I haven't figured out a
pattern yet.  Once this happens, I have to reboot before the card will
work again.

(I'm currently using 2.6.0, and the result is the same)

Hardware is a Thinkpad T23 1G/60G; this never happened with a orinico
cards on the same box.

Linux version 2.6.0-test11 (root@atreides) (gcc version 3.3.2 (Debian)) #2 Wed Dec 3 17:18:10 UTC 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff70000 (usable)
 BIOS-e820: 000000003ff70000 - 000000003ff7e000 (ACPI data)
 BIOS-e820: 000000003ff7e000 - 000000003ff80000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009f000 (usable)
 user: 000000000009f000 - 00000000000a0000 (reserved)
 user: 00000000000dc000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000003ff70000 (usable)
 user: 000000003ff70000 - 000000003ff7e000 (ACPI data)
 user: 000000003ff7e000 - 000000003ff80000 (ACPI NVS)
 user: 000000003ff80000 - 0000000040000000 (reserved)
 user: 00000000ff800000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262000
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32624 pages, LIFO batch:7
DMI present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.6.0-test11 ro root=301 mem=1024M
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1132.434 MHz processor.
Console: colour VGA+ 80x25
Memory: 1032676k/1048000k available (2687k kernel code, 14388k reserved, 932k data, 128k init, 130496k highmem)
Calibrating delay loop... 2244.60 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/248c] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:02.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
lp0: console ready
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:02.0
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25T060ATCS05-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
PCI: Found IRQ 11 for device 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
Yenta: CardBus bridge found at 0000:02:00.0 [1014:023b]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 06b8, PCI irq11
Socket status: 30000010
PCI: Found IRQ 11 for device 0000:02:00.1
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:00:1f.5
Yenta: CardBus bridge found at 0000:02:00.1 [1014:023b]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 06b8, PCI irq11
Socket status: 30000006
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:00.0
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.1
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:02.0
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
PCI: Found IRQ 11 for device 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:02:00.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801CA-ICH3 at 0x1c00, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 128k freed
Real Time Clock Driver v1.12
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

PCI: Found IRQ 11 for device 0000:02:08.0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

drivers/usb/core/usb.c: registered new driver rio500
drivers/usb/misc/rio500.c: v1.1:USB Rio 500 driver
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
Non-volatile memory driver v1.2
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda7) for (hda7)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda9) for (hda9)
Using r5 hash to sort names
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:d:29:17:de:9c
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
NET: Registered protocol family 10
Disabled Privacy Extensions on device c044a4a0(lo)
IPv6 over IPv4 tunneling driver
eth1: no IPv6 routers present
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f200000000000111
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Found IRQ 11 for device 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.3
PCI: Sharing IRQ 11 with 0000:02:00.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
airo:  Probing for PCI adapters
kobject_register failed for airo (-17)
Call Trace:
 [<c021d34b>] kobject_register+0x5b/0x60
 [<c025bf3c>] bus_add_driver+0x4c/0xc0
 [<c025c3f1>] driver_register+0x31/0x40
 [<c0185b33>] create_proc_entry+0x83/0xd0
 [<c022b6cb>] pci_register_driver+0x5b/0x80
 [<f89900e8>] airo_init_module+0xe8/0x10e [airo]
 [<c0132065>] sys_init_module+0x135/0x280
 [<c01095bb>] syscall_call+0x7/0xb

airo:  Finished probing for PCI adapters
Unable to handle kernel paging request at virtual address 8826c020
 printing eip:
f89bdb7b
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<f89bdb7b>]    Not tainted
EFLAGS: 00010246
EIP is at issuecommand+0x18b/0x1e0 [airo]
eax: 44136010   ebx: 00071388   ecx: 00000000   edx: 00000100
esi: ec9fc200   edi: f7cd4000   ebp: f7cd5434   esp: f7cd541c
ds: 007b   es: 007b   ss: 0068
Process cardmgr (pid: 420, threadinfo=f7cd4000 task=f7cface0)
Stack: ec9fc200 00000000 00000010 ec9fc340 00000000 ec9fc200 f7cd57a4 f89bd457 
       ec9fc200 f7cd5460 f7cd5458 f7338200 f7cd4000 f7cd5470 f89b2b8d 00000010 
       00000000 00000010 00000000 f7cd548c f7cd5494 f7cd54a0 f89b2c41 f7338200 
Call Trace:
 [<f89bd457>] setup_card+0xb7/0x650 [airo]
 [<c0163740>] send_sigio+0x90/0x100
 [<c0163a46>] __kill_fasync+0x46/0x80
 [<c02e2072>] mousedev_event+0xc2/0x200
 [<c02e04fb>] input_event+0xfb/0x3f0
 [<c02e3a4c>] psmouse_process_packet+0x15c/0x2a0
 [<c02e3c6e>] psmouse_interrupt+0xde/0x1e0
 [<c02e6dbb>] i8042_interrupt+0x1ab/0x1b0
 [<c02e645a>] serio_interrupt+0x5a/0x60
 [<c02e6d3d>] i8042_interrupt+0x12d/0x1b0
 [<c0124c0c>] send_signal+0x9c/0x150
 [<c01076d3>] copy_thread+0x33/0x260
 [<c011a539>] copy_process+0x6b9/0xb40
 [<c0116d90>] wake_up_forked_process+0x130/0x160
 [<c011aae7>] do_fork+0x127/0x170
 [<f89bc115>] init_airo_card+0x305/0x390 [airo]
 [<c02c14c0>] CardServices+0x210/0x357
 [<f899b6df>] airo_config+0x48f/0x660 [airo_cs]
 [<c02b9f62>] pcmcia_get_next_tuple+0x272/0x2d0
 [<c02b9a2c>] pcmcia_get_first_tuple+0xac/0x160
 [<c02bb40e>] read_tuple+0x2e/0x80
 [<c02b9642>] read_cis_cache+0x102/0x190
 [<c02b9f62>] pcmcia_get_next_tuple+0x272/0x2d0
 [<c02bb55f>] pcmcia_validate_cis+0xff/0x1e0
 [<c0192707>] ext3_do_update_inode+0x187/0x3c0
 [<c019d39f>] journal_get_write_access+0x3f/0x50
 [<c02ba049>] pcmcia_get_tuple_data+0x89/0x90
 [<c02bb368>] pcmcia_parse_tuple+0x108/0x180
 [<c02bb454>] read_tuple+0x74/0x80
 [<c02c3856>] yenta_set_mem_map+0x196/0x1e0
 [<c02b9f62>] pcmcia_get_next_tuple+0x272/0x2d0
 [<c02b9a2c>] pcmcia_get_first_tuple+0xac/0x160
 [<c02bb40e>] read_tuple+0x2e/0x80
 [<c02b9642>] read_cis_cache+0x102/0x190
 [<c02b9f62>] pcmcia_get_next_tuple+0x272/0x2d0
 [<c02bb55f>] pcmcia_validate_cis+0xff/0x1e0
 [<c0192707>] ext3_do_update_inode+0x187/0x3c0
 [<c019d39f>] journal_get_write_access+0x3f/0x50
 [<c0116f1b>] nr_context_switches+0xb/0x10
 [<f899ba0c>] airo_event+0x8c/0x1b0 [airo_cs]
 [<c02bff59>] pcmcia_register_client+0x269/0x2c0
 [<c011f256>] tasklet_action+0x46/0x70
 [<c010b238>] do_IRQ+0x108/0x150
 [<c02c145b>] CardServices+0x1ab/0x357
 [<f899b10e>] airo_attach+0x10e/0x180 [airo_cs]
 [<f899b980>] airo_event+0x0/0x1b0 [airo_cs]
 [<c02bf1ca>] pcmcia_bind_device+0x6a/0xb0
 [<c02c20fc>] bind_request+0x10c/0x230
 [<c02be0a5>] pcmcia_get_socket_by_nr+0x25/0xb0
 [<c02c2ccc>] ds_ioctl+0x52c/0x670
 [<c0331330>] sock_def_readable+0x80/0x90
 [<c038943a>] unix_stream_sendmsg+0x29a/0x410
 [<c032da4e>] sock_sendmsg+0x8e/0xb0
 [<c016a5ae>] alloc_inode+0x1e/0x140
 [<c016b1d0>] get_new_inode_fast+0x40/0xf0
 [<c01176d9>] schedule+0x2f9/0x590
 [<c0117ad1>] __wake_up_locked+0x21/0x30
 [<c0141627>] zap_pte_range+0x77/0x1a0
 [<c01179c0>] default_wake_function+0x0/0x20
 [<c014179e>] zap_pmd_range+0x4e/0x70
 [<c014180e>] unmap_page_range+0x4e/0x80
 [<c014193d>] unmap_vmas+0xfd/0x220
 [<c0145168>] unmap_vma+0x48/0x90
 [<c01451cf>] unmap_vma_list+0x1f/0x30
 [<c014561a>] do_munmap+0x13a/0x180
 [<c0163db0>] sys_ioctl+0x100/0x2a0
 [<c01095bb>] syscall_call+0x7/0xb

Code: c0 34 00 00 00 89 44 24 08 89 7c 24 04 e8 93 f5 ff ff 31 c0 
 <7>eth0: no IPv6 routers present

ii  pciutils       2.1.11-6       Linux PCI Utilities (for 2.*.* kernels)
ii  pcmcia-cs      3.2.5-2        PCMCIA Card Services for Linux
ii  pcmcia-source  3.2.5-2        PCMCIA Card Services source
ii  tpctl          4.8-1          IBM ThinkPad hardware configuration tools

19:06@atreides:/proc/driver/aironet/eth1% more Status
Status: CFG ACT SYN LNK PRIV KEY WEP
Mode: 3bf
Signal Strength: 86
Signal Quality: 76
SSID: vvw
AP:
Freq: 0
BitRate: 11mbs
Driver Version: airo.c 0.6 (Ben Reed & Javier Achirica)
Device: 350 Series
Manufacturer: Cisco Systems
Firmware Version: 4.23
Radio type: 2
Country: 0
Hardware Version: 30
Software Version: 423
Software Subversion: 0
Boot block version: 150



-- 
Ryan Lackey [RL960-RIPE AS24812]   ryan@venona.com   +1 202 258 9251
OpenPGP DH 4096: B8B8 3D95 F940 9760 C64B   DE90 07AD BE07 D2E0 301F
