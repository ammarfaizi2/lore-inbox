Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSKKOqs>; Mon, 11 Nov 2002 09:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265673AbSKKOqs>; Mon, 11 Nov 2002 09:46:48 -0500
Received: from ma-northadams1b-126.bur.adelphia.net ([24.52.166.126]:640 "EHLO
	ma-northadams1b-126.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S265587AbSKKOqr>; Mon, 11 Nov 2002 09:46:47 -0500
Date: Mon, 11 Nov 2002 09:54:34 -0500
From: Eric Buddington <eric@ma-northadams1b-126.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47: oops/panic in ide_inint_queue
Message-ID: <20021111095434.A86@ma-northadams1b-126.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.5.47, mostly modules

vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 945.791
cache size      : 256 KB

pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
hdc: _NEC CD-RW NR-7800A, ATAPI CD/DVD-ROM drive
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
 
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010282
eax: c04ba870   ebx: c04ba91c   ecx: 00000000   edx: 00000000
esi: c04ba92c   edi: c04ba870   ebp: c126c000   esp: c126def4
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=c126c000 task=c126a040)
Stack: c024de5f c04ba91c 00000001 c043b680 c04ba91c c12e6ce4 c024e055 c04ba91c 
       c0255c20 20000000 c04ba880 c12e6ce4 c024e310 c04ba880 c126c000 00000000 
       00000296 00000000 00000001 c04ba870 00000000 c04ba880 c024e5e4 c04ba870 
Call Trace:
 [<c024de5f>] ide_init_queue+0x9f/0xb0
 [<c024e055>] init_irq+0x1e5/0x3d0
 [<c0255c20>] ide_intr+0x0/0x180
 [<c024e310>] alloc_disks+0x70/0xd0
 [<c024e5e4>] hwif_init+0xf4/0x2a0
 [<c024e8ae>] ideprobe_init+0xee/0x100
 [<c010507a>] init+0x3a/0x160
 [<c0105040>] init+0x0/0x160
 [<c010717d>] kernel_thread_helper+0x5/0x18

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!
