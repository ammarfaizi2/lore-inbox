Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752136AbWFLShF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbWFLShF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWFLShF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:37:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:18305 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752136AbWFLShC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:37:02 -0400
Subject: Re: 2.6.16-rc6-mm2
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060609214024.2f7dd72c.akpm@osdl.org>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 11:19:54 -0700
Message-Id: <1150136394.28414.23.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 21:40 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/
> 
> 

Not sure, if its reported earlier .. paniced on my ppc64 machine.

Thanks,
Badari

Memory: 1852532k/1900544k available (5428k kernel code, 47336k reserved,
1508k data, 859k bss, 240k init)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256
Processor 1 found.
Processor 2 found.
Processor 3 found.
Brought up 4 CPUs
migration_cost=3,0
checking if image is initramfs... it is
Freeing initrd memory: 1320k freed
NET: Registered protocol family 16
IOMMU table initialized, virtual merging disabled
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1150133249.344:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
rpaphp: Slot [0001:00:02.4](PCI location=U787E.001.AAA3015-P2-C1) registered
rpaphp: Slot [0001:00:02.2](PCI location=U787E.001.AAA3015-P2-C2) registered
rpaphp: Slot [0001:00:02.6](PCI location=U787E.001.AAA3015-P2-C3) registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
isa bounce pool size: 16 pages
Floppy drive(s): fd0 is 2.88M
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.0.38-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
e1000: 0000:c0:01.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:0d:60:de:a9:d6
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:c0:01.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:0d:60:de:a9:d7
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20275: IDE controller at PCI slot 0000:cc:01.0
PDC20275: chipset revision 1
PDC20275: 100% native mode on irq 134
    ide2: BM-DMA at 0xdec00-0xdec07<3>PDC20275: -- Error, unable to allocate DMA table.
Unable to handle kernel paging request for data at address 0xd000080000000000
Faulting instruction address: 0xc000000000347b70
Oops: Kernel access of bad area, sig: 7 [#1]
SMP NR_CPUS=128 
Modules linked in:
NIP: C000000000347B70 LR: C00000000033E0B8 CTR: C000000000347B5C
REGS: c000000002667610 TRAP: 0300   Not tainted  (2.6.17-rc6-mm2-autokern1)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24004028  XER: 00000006
DAR: D000080000000000, DSISR: 0000000042000000
TASK = c00000000265a800[1] 'idle' THREAD: c000000002664000 CPU: 1
GPR00: C000000000347B5C C000000002667890 C0000000006C8938 000000000000000B 
GPR04: 0000000000000000 C0000000006ABBD8 C0000000006ABAE8 C0000000006ABBA8 
GPR08: C0000000006ABBC0 D000080000000000 0000000000000000 0000000000000000 
GPR12: 0000000000004000 C000000000570080 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000086 0000000000000000 C000000002667BE0 
GPR20: C000000002514800 0000000000000000 C0000000005E97B8 0000000000000000 
GPR24: C000000002514800 C0000000005E97B8 C0000000007AD480 C000000002667A22 
GPR28: C0000000006ABB90 C0000000007AD480 C000000000604768 C0000000007AD480 
NIP [C000000000347B70] .ide_outb+0x14/0x2c
LR [C00000000033E0B8] .pdcnew_new_cable_detect+0x3c/0x78
Call Trace:
[C000000002667890] [C000000002667930] 0xc000000002667930 (unreliable)
[C000000002667920] [C00000000033E19C] .init_hwif_pdc202new+0xa8/0x118
[C0000000026679B0] [C000000000350984] .ide_pci_setup_ports+0x7e8/0x870
[C000000002667AB0] [C000000000350E94] .do_ide_setup_pci_device+0x488/0x4b8
[C000000002667B70] [C00000000035100C] .ide_setup_pci_device+0x2c/0xc4
[C000000002667C10] [C00000000033E39C] .init_setup_pdcnew+0x10/0x24
[C000000002667C90] [C00000000033E258] .pdc202new_init_one+0x4c/0x64
[C000000002667D10] [C000000000532198] .ide_scan_pcidev+0x7c/0xd8
[C000000002667DA0] [C000000000532228] .ide_scan_pcibus+0x34/0x130
[C000000002667E20] [C0000000005320EC] .ide_init+0x78/0xa8
[C000000002667EB0] [C000000000009480] .init+0x1fc/0x3b0
[C000000002667F90] [C0000000000239C4] .kernel_thread+0x4c/0x68
Instruction dump:
eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8 7c0803a6 4e800020 fbc1fff0 
ebc2cc00 e93e8000 60000000 e9290000 <7c6449ae> 7c0004ac 60000000 60000000 
-- 0:conmux-control -- time-stamp -- Jun/12/06 10:30:58 --
-- 0:conmux-control -- time-stamp -- Jun/12/06 10:46:41 --
(bot:conmon-payload) disconnected

