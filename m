Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVAJUoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVAJUoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVAJUk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:40:56 -0500
Received: from mail.tyan.com ([66.122.195.4]:52750 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262532AbVAJUgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:36:50 -0500
Message-ID: <3174569B9743D511922F00A0C9431423072913A8@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Mon, 10 Jan 2005 12:48:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not lifting bsp to 0x10, it fails on TIMER too.

YH

Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1019432k/1048576k available (3006k kernel code, 0k reserved, 1317k
data, 548k init)
LYH calibrating 0 jiffies = 4294667566, now=2500693458
LYH calibrating 1 jiffies = 4294667571, now=2511802784
LYH calibrating 3 jiffies = 4294667601, now=2579969051
4341.76 BogoMIPS (lpj=2170880)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0
CPU: Physical Processor ID: 0
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0
CPU: Physical Processor ID: 0
CPU0:  stepping 00
per-CPU timeslice cutoff: 1023.91 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp ffff810002217f58
Initializing CPU#1
LYH calibrating 0 jiffies = 4294667672, now=2736795282
LYH calibrating 1 jiffies = 4294667672, now=2736800180
Calibrating delay loop... <7>Calibrating delay loop... ----------- [cut here
] --------- [please bite here ] ---------
Kernel BUG at timer:416
invalid operand: 0000 [1] SMP 
CPU 1 
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.10-bk13
RIP: 0010:[<ffffffff8013958d>] <ffffffff8013958d>{cascade+45}
RSP: 0018:ffff81000221fed8  EFLAGS: 00010007
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff810001e15820
RBP: ffff810001e16838 R08: 00000000fffffff2 R09: 0000000000000009
R10: 00000000ffffffff R11: 0000000000000000 R12: fff
