Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271855AbRHUUZQ>; Tue, 21 Aug 2001 16:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271856AbRHUUZG>; Tue, 21 Aug 2001 16:25:06 -0400
Received: from [145.254.149.107] ([145.254.149.107]:21231 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S271855AbRHUUYw>;
	Tue, 21 Aug 2001 16:24:52 -0400
Message-ID: <3B82C336.880F1270@pcsystems.de>
Date: Tue, 21 Aug 2001 22:23:18 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Juergen E. Fischer" <fischer@linux-buechse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: aha152x problem
In-Reply-To: <3B1285CC.EB151D8A@pcsystems.de> <20010529125500.A24647@linux-buechse.de> <3B5D0C10.C9B2C39E@pcsystems.de> <20010724205745.A16230@linux-buechse.de>
Content-Type: multipart/mixed;
 boundary="------------51692101DE5D1B3E65B663AB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------51692101DE5D1B3E65B663AB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Juergen E. Fischer" wrote:

> Moin Nico,
>
> On Tue, Jul 24, 2001 at 07:48:00 +0200, Nico Schottelius wrote:
> > eiche:~ # modprobe aha152x io=0x140 irq=9 synchronous=0
>
> achso, sorry heisst ja auch nicht synchronous, sondern sync.

modprobe aha152x io=0x140 irq=9 sync=0

tried that and recieved a segmentation fault of modprobe
and a nice kernel oops!


Attached necessary files!

Nico

--------------51692101DE5D1B3E65B663AB
Content-Type: text/plain; charset=us-ascii;
 name="DMESG_SEGFAULT"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMESG_SEGFAULT"

Linux version 2.4.7 (root@eiche) (gcc version 2.95.2 19991024 (release)) #4 Tue Oct 2 16:55:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=new ro root=801 vga=0x0301 nmi_watchdog=1
Initializing CPU#0
Detected 399.329 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 255276k/262144k available (1254k kernel code, 6484k reserved, 434k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 8MB @ 0xE6000000)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169493kB/56497kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV3064D, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59794560 sectors (30615 MB) w/434KiB Cache, CHS=3722/255/63
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 205816k swap-space (priority -1)
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa400,  00:60:08:50:b3:45, IRQ 10
  product code 4b4b rev 00.0 date 08-12-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
isapnp: Scanning for PnP cards...
Unable to handle kernel NULL pointer dereference at virtual address 0000000e
 printing eip:
d2907e54
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<d2907e54>]
EFLAGS: 00010246
eax: 0000000e   ebx: c39cf000   ecx: c2249c72   edx: 00000213
esi: 00000000   edi: c2249c54   ebp: c2249c40   esp: c1e61e84
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 318, stackpage=c1e61000)
Stack: c2249c40 c1e61ede c1e61edd 00000001 c1e61eae c1e61ead 00000000 00000000 
       00000001 00000000 000082c3 00000001 c2249c40 c1e61ede c1e61edd 1698825c 
       d298823f c2249c40 00000006 c2249c40 00000001 c1e61f08 00060246 d2981110 
Call Trace: [<c0129492>] [<c0113ced>] [<c0106ae7>] 

Code: 00 00 00 00 00 00 00 00 6c 7e 90 d2 24 7e 90 d2 00 00 00 00 

--------------51692101DE5D1B3E65B663AB
Content-Type: text/plain; charset=us-ascii;
 name="KSYMOOPS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="KSYMOOPS"

ksymoops 0.7c on i686 2.4.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_cast_buffer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_copy_to_buffer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_object) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_reference_list) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_simple_integer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_extract_package_data) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_context) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_info) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_power_state) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_status) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_node) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_osl_generate_event) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_proc_root) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_register_driver) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_request) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_search) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_set_device_power_state) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_unregister_driver) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_fadt_R__ver_acpi_fadt not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol __module_author  , 3c59x says d2984960, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ac0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_description  , 3c59x says d29849a0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b00.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_device_id  , 3c59x says d2984ab4, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c14.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_ioaddr  , 3c59x says d2984a8d, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bed.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_irq  , 3c59x says d2984aa2, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c02.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_debug  , 3c59x says d29849ea, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b4a.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_device_id  , 3c59x says d2984e60, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985fc0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_ioaddr  , 3c59x says d2984da0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985f00.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_irq  , 3c59x says d2984e00, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985f60.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_debug  , 3c59x says d2984ae0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c40.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_enable_wol  , 3c59x says d2984c80, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985de0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_flow_ctrl  , 3c59x says d2984c20, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985d80.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_full_duplex  , 3c59x says d2984b80, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ce0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_hw_checksums  , 3c59x says d2984bc0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985d20.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_max_interrupt_work  , 3c59x says d2984d40, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ea0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_options  , 3c59x says d2984b20, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c80.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_rx_copybreak  , 3c59x says d2984ce0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985e40.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_watchdog  , 3c59x says d2984ec0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2986020.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_enable_wol  , 3c59x says d2984a4a, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985baa.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_flow_ctrl  , 3c59x says d2984a36, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b96.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_full_duplex  , 3c59x says d2984a09, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b69.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_hw_checksums  , 3c59x says d2984a1f, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b7f.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_max_interrupt_work  , 3c59x says d2984a73, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bd3.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_options  , 3c59x says d29849f7, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b57.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_rx_copybreak  , 3c59x says d2984a5f, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bbf.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_watchdog  , 3c59x says d2984acc, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c2c.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Unable to handle kernel NULL pointer dereference at virtual address 0000000e
d2907e54
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<d2907e54>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 0000000e   ebx: c39cf000   ecx: c2249c72   edx: 00000213
esi: 00000000   edi: c2249c54   ebp: c2249c40   esp: c1e61e84
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 318, stackpage=c1e61000)
Stack: c2249c40 c1e61ede c1e61edd 00000001 c1e61eae c1e61ead 00000000 00000000 
       00000001 00000000 000082c3 00000001 c2249c40 c1e61ede c1e61edd 1698825c 
       d298823f c2249c40 00000006 c2249c40 00000001 c1e61f08 00060246 d2981110 
Call Trace: [<c0129492>] [<c0113ced>] [<c0106ae7>] 
Code: 00 00 00 00 00 00 00 00 6c 7e 90 d2 24 7e 90 d2 00 00 00 00 
Error (Oops_bfd_perror): (null) Bad address

>>EIP; d2907e54 <_end+125fc7fc/12673a08>   <=====
Trace; c0129492 <__free_pages+1a/1c>
Trace; c0113ced <sys_init_module+505/5a8>
Trace; c0106ae7 <system_call+33/38>


46 warnings and 1 error issued.  Results may not be reliable.

--------------51692101DE5D1B3E65B663AB
Content-Type: text/plain; charset=us-ascii;
 name="SEGFAULT"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SEGFAULT"

modprobe aha152x irq=9 io=0x140 sync=0

--------------51692101DE5D1B3E65B663AB--

