Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTKEC3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 21:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTKEC3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 21:29:43 -0500
Received: from d40.sstar.com ([209.205.179.40]:20734 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id S262725AbTKEC3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 21:29:41 -0500
From: "Andrew S. Johnson" <andy@asjohnson.com>
To: linux-kernel@vger.kernel.org
Subject: Recurring random freezes with 2.6.0-test9
Date: Tue, 4 Nov 2003 20:29:38 -0600
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311042029.38749.andy@asjohnson.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 2.4.22 running fine on this box, before and after
trying 2.6.0-test9.  What happens is that I can use the
box for a few minutes, then it locks up hard for no apparent
reason.  The hard drive light comes on and stays on,
sysrq is unresponsive, and no response via ethernet.
This has happened everytime I've used -test9 (about
4-6 times).  The kernel is compiled for K7 (Athlon).

I have support for IDE disk, VIA vt82c686b, HPT370A,
and PDC20269 compiled in.  There is nothing in any
log file that hints of trouble.  Here's part of syslog, FWIW:

kernel: PCI: Probing PCI hardware
kernel: PCI: Probing PCI hardware (bus 00)
kernel: Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
kernel: pty: 256 Unix98 ptys configured
kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
kernel: hda: Maxtor 94610U6, ATA DISK drive
kernel: Using anticipatory io scheduler
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: hdc: HL-DT-ST RW/DVD GCC-4480B, ATAPI CD/DVD-ROM drive
kernel: ide1 at 0x170-0x177,0x376 on irq 15
kernel: hde: Maxtor 6Y160P0, ATA DISK drive
kernel: ide2 at 0xbc00-0xbc07,0xc002 on irq 11
kernel: HPT37X: using 33MHz PCI clock
kernel: hdi: MAXTOR 4K080H4, ATA DISK drive
kernel: ide4 at 0xdc00-0xdc07,0xe002 on irq 11
kernel: hda: max request size: 128KiB
kernel: hde: max request size: 1024KiB
kernel: hdi: max request size: 128KiB
kernel: EXT2-fs warning (device hda5): ext2_fill_super: mounting ext3 filesystem as ext2
kernel:
kernel: VFS: Mounted root (ext2 filesystem) readonly.
kernel: sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
kernel: blk: queue dfe10400, I/O limit 4095Mb (mask 0xffffffff)
kernel: blk: queue dfe02400, I/O limit 4095Mb (mask 0xffffffff)
kernel: blk: queue dfdf7800, I/O limit 4095Mb (mask 0xffffffff)

Is there anything else I can provide that would be useful?
Is there anything I can turn on to get more info when this happens?

Andy Johnson

