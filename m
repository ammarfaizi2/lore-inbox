Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSEAMgL>; Wed, 1 May 2002 08:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSEAMgL>; Wed, 1 May 2002 08:36:11 -0400
Received: from ulima.unil.ch ([130.223.144.143]:65152 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S311564AbSEAMgG>;
	Wed, 1 May 2002 08:36:06 -0400
Date: Wed, 1 May 2002 14:36:05 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.1[012] Oops (id-secsi)
Message-ID: <20020501123605.GA3055@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have just booted 2.5.12 and got same result as with 2.5.1[01]:

Linux version 2.5.12 (greg@ulima.unil.ch) (gcc version 2.96 20000731 (Mandrake Linux 8.3 2.96-0.79mdk)) #13 Wed May 1 13:00:06 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ffe000 (usable)
 BIOS-e820: 0000000017ffe000 - 0000000018000000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98302
zone(0): 4096 pages.
zone(1): 94206 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2.5.12 rw root=302 video=atyfb:1024x768-16@100 console=ttyS0
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 548.327 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 1094.45 BogoMIPS
Memory: 387268k/393208k available (1275k kernel code, 5556k reserved, 301k data, 232k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 548.3387 MHz.
..... host bus clock speed is 99.6977 MHz.
cpu: 0, clocks: 996977, slice: 498488
CPU0<T0:996976,T1:498480,D:8,S:498488,C:996977>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfcaee, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: Card 'CS4236B'
isapnp: 1 Plug & Play card detected total
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
PnPBIOS: PNP0c01: ioport range 0x800-0x83f has been reserved
PnPBIOS: PNP0c01: ioport range 0x850-0x85f has been reserved
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
atyfb: 3D RAGE PRO (BGA, AGP) [0x4742 rev 0x7c] 8M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
Console: switching to colour frame buffer device 128x48
fb0: ATY Mach64 frame buffer device on PCI
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 256 slots per queue, batch=32
PCI: Found IRQ 11 for device 00:11.0
PCI: Sharing IRQ 11 with 00:07.2
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:11.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xcc00. Vers LK1.1.17
phy=0, phyx=24, mii_status=0x786d
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
Intel Corp. 82371AB PIIX4 IDE: unknown IDE controller on PCI slot 00:07.1, vendor=8086, device=7111
Intel Corp. 82371AB PIIX4 IDE: chipset revision 1
Intel Corp. 82371AB PIIX4 IDE:
 not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL CX13.6A, ATA DISK drive
hdc: CRD-8400B, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 26760384 sectors w/418KiB Cache, CHS=26548/16/63, UDMA(33)
Partition check:
 hda: [PTBL] [1665/255/63] hda1 hda2
 hdd:ide-scsi: unsup command: dev 16:40: REQ_CMD REQ_STARTED sector 0, nr/cnr 8/2

end_request: I/O error, dev 16:40, sector 0
end_buffer_io_async: I/O error
ide-scsi: unsup command: dev 16:40: REQ_CMD REQ_STARTED sector 2, nr/cnr 6/2

end_request: I/O error, dev 16:40, sector 2
end_buffer_io_async: I/O error
ide-scsi: unsup command: dev 16:40: REQ_CMD REQ_STARTED sector 4, nr/cnr 4/2

end_request: I/O error, dev 16:40, sector 4
end_buffer_io_async: I/O error
ide-scsi: unsup command: dev 16:40: REQ_CMD REQ_STARTED sector 6, nr/cnr 2/2

end_request: I/O error, dev 16:40, sector 6
end_buffer_io_async: I/O error
ide-scsi: unsup command: dev 16:40: REQ_CMD REQ_STARTED sector 0, nr/cnr 8/2

end_request: I/O error, dev 16:40, sector 0
end_buffer_io_async: I/O error
ide-scsi: unsup command: dev 16:40: REQ_CMD REQ_STARTED sector 2, nr/cnr 6/2

end_request: I/O error, dev 16:40, sector 2
end_buffer_io_async: I/O error
ide-scsi: unsup command: dev 16:40: REQ_CMD REQ_STARTED sector 4, nr/cnr 4/2

end_request: I/O error, dev 16:40, sector 4
end_buffer_io_async: I/O error
ide-scsi: unsup command: dev 16:40: REQ_CMD REQ_STARTED sector 6, nr/cnr 2/2

end_request: I/O error, dev 16:40, sector 6
end_buffer_io_async: I/O error
 unable to read partition table
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IOMEGA    Model: ZIP 250           Rev: 41.S
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: LG        Model: CD-ROM CRD-8400B  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 489532 512-byte hdwr sectors (251 MB)
sda: Write Protect is off
 sda:<1>Unable to handle kernel NULL pointer dereference at virtual address 000000a0
 printing eip:
c01b90e7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b90e7>]    Not tainted
EFLAGS: 00010292
eax: 00000000   ebx: d7dc19c0   ecx: d7dc19c0   edx: 00000001
esi: d7d8e000   edi: 00000000   ebp: d7dc19c0   esp: c13fbb94
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, threadinfo=c13fa000 task=c13f8040)
Stack: 000003e8 00000000 00000000 00000000 00000000 c02f68a0 c01c2437 d7dc19c0 
       d7d8e000 00000000 d7dc19c0 c01c768b 00000000 d7dc19c0 d7d8e000 c01c288b 
       c02f6990 d7dc19c0 00000000 d7d8f000 c02f6ba4 c02f68a0 d7dc19c0 c01c7763 
Call Trace: [<c01c2437>] [<c01c768b>] [<c01c288b>] [<c01c7763>] [<c01c7dbf>] 
   [<c01d1f15>] [<c01c2437>] [<c01c288b>] [<c01c294b>] [<c01c2f94>] [<c01d2a62>] 
   [<c01ca7f7>] [<c01cad70>] [<c01d0720>] [<c01b9749>] [<c011c981>] [<c013d4b9>] 
   [<c012a019>] [<c012a0ea>] [<c012b95a>] [<c0159d96>] [<c013f140>] [<c01b60b8>] 
   [<c015a5a7>] [<c015a77c>] [<c01b8b6e>] [<c013f505>] [<c0159b82>] [<c01d3e0f>] 
   [<c0159d23>] [<c0150800>] [<c01d440b>] [<c01cc03e>] [<c0105000>] [<c0105070>] 
   [<c0105000>] [<c0105626>] [<c0105050>] 

Code: 8b 90 a0 00 00 00 c7 44 24 18 00 00 00 00 83 e2 02 89 54 24 
 <0>Kernel panic: Attempted to kill init!
 <6>SysRq : Resetting



Which I saved as /tmp/ooooo and:
ksymoops -o /lib/modules/2.5.12/ -m /usr/src/linux-2.5/System.map -v /usr/src/linux-2.5/vmlinux -K  /tmp/ooooo              01.05 14:28
ksymoops 2.3.5 on i686 2.4.19-pre7.  Options used
     -v /usr/src/linux-2.5/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.12/ (specified)
     -m /usr/src/linux-2.5/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
cpu: 0, clocks: 996977, slice: 498488
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
 sda:<1>Unable to handle kernel NULL pointer dereference at virtual address 000000a0
c01b90e7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b90e7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000000   ebx: d7dc19c0   ecx: d7dc19c0   edx: 00000001
esi: d7d8e000   edi: 00000000   ebp: d7dc19c0   esp: c13fbb94
ds: 0018   es: 0018   ss: 0018
Stack: 000003e8 00000000 00000000 00000000 00000000 c02f68a0 c01c2437 d7dc19c0 
       d7d8e000 00000000 d7dc19c0 c01c768b 00000000 d7dc19c0 d7d8e000 c01c288b 
       c02f6990 d7dc19c0 00000000 d7d8f000 c02f6ba4 c02f68a0 d7dc19c0 c01c7763 
Call Trace: [<c01c2437>] [<c01c768b>] [<c01c288b>] [<c01c7763>] [<c01c7dbf>] 
   [<c01d1f15>] [<c01c2437>] [<c01c288b>] [<c01c294b>] [<c01c2f94>] [<c01d2a62>] 
   [<c01ca7f7>] [<c01cad70>] [<c01d0720>] [<c01b9749>] [<c011c981>] [<c013d4b9>] 
   [<c012a019>] [<c012a0ea>] [<c012b95a>] [<c0159d96>] [<c013f140>] [<c01b60b8>] 
   [<c015a5a7>] [<c015a77c>] [<c01b8b6e>] [<c013f505>] [<c0159b82>] [<c01d3e0f>] 
   [<c0159d23>] [<c0150800>] [<c01d440b>] [<c01cc03e>] [<c0105000>] [<c0105070>] 
   [<c0105000>] [<c0105626>] [<c0105050>] 
Code: 8b 90 a0 00 00 00 c7 44 24 18 00 00 00 00 83 e2 02 89 54 24 

>>EIP; c01b90e7 <blk_rq_map_sg+17/160>   <=====
Trace; c01c2437 <start_request+1f7/280>
Trace; c01c768b <build_sglist+fb/1a0>
Trace; c01c288b <queue_commands+13b/190>
Trace; c01c7763 <ide_build_dmatable+33/190>
Trace; c01c7dbf <ide_dmaproc+ff/2a0>
Trace; c01d1f15 <idescsi_issue_pc+75/180>
Trace; c01c2437 <start_request+1f7/280>
Trace; c01c288b <queue_commands+13b/190>
Trace; c01c294b <ide_do_request+6b/90>
Trace; c01c2f94 <ide_do_drive_cmd+e4/130>
Trace; c01d2a62 <idescsi_queue+582/5d0>
Trace; c01ca7f7 <scsi_dispatch_cmd+107/1e0>
Trace; c01cad70 <scsi_done+0/b0>
Trace; c01d0720 <scsi_request_fn+3d0/3f0>
Trace; c01b9749 <generic_unplug_device+29/60>
Trace; c011c981 <__run_task_queue+61/70>
Trace; c013d4b9 <block_sync_page+19/20>
Trace; c012a019 <__lock_page+a9/100>
Trace; c012a0ea <lock_page+3a/40>
Trace; c012b95a <read_cache_page+aa/100>
Trace; c0159d96 <read_dev_sector+36/b0>
Trace; c013f140 <blkdev_readpage+0/20>
Trace; c01b60b8 <serial_console_write+168/1e0>
Trace; c015a5a7 <handle_ide_mess+27/1a0>
Trace; c015a77c <msdos_partition+5c/2e0>
Trace; c01b8b6e <blk_get_ra_pages+2e/40>
Trace; c013f505 <bdget+105/180>
Trace; c0159b82 <check_partition+102/180>
Trace; c01d3e0f <sd_init_onedisk+77f/790>
Trace; c0159d23 <grok_partitions+e3/120>
Trace; c0150800 <.text.lock.namespace+19e/1be>
Trace; c01d440b <sd_finish+10b/130>
Trace; c01cc03e <scsi_register_device+10e/130>
Trace; c0105000 <_stext+0/0>
Trace; c0105070 <init+20/180>
Trace; c0105000 <_stext+0/0>
Trace; c0105626 <kernel_thread+26/30>
Trace; c0105050 <init+0/180>
Code;  c01b90e7 <blk_rq_map_sg+17/160>
00000000 <_EIP>:
Code;  c01b90e7 <blk_rq_map_sg+17/160>   <=====
   0:   8b 90 a0 00 00 00         mov    0xa0(%eax),%edx   <=====
Code;  c01b90ed <blk_rq_map_sg+1d/160>
   6:   c7 44 24 18 00 00 00      movl   $0x0,0x18(%esp,1)
Code;  c01b90f4 <blk_rq_map_sg+24/160>
   d:   00 
Code;  c01b90f5 <blk_rq_map_sg+25/160>
   e:   83 e2 02                  and    $0x2,%edx
Code;  c01b90f8 <blk_rq_map_sg+28/160>
  11:   89 54 24 00               mov    %edx,0x0(%esp,1)

 <0>Kernel panic: Attempted to kill init!


I don't understand anything about it, and if I should send more informations,
just let me know, thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
