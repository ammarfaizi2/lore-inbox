Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSKDCsl>; Sun, 3 Nov 2002 21:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264633AbSKDCsl>; Sun, 3 Nov 2002 21:48:41 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:40576 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S264630AbSKDCsk>; Sun, 3 Nov 2002 21:48:40 -0500
Date: Mon, 4 Nov 2002 13:54:59 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.45 / boottime oops (pnp bios I think)
Message-ID: <20021104025458.GA3088@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I unselect PNP BIOS the kernel boots fine. With it I get the
oops below. Please note that it was typed out manually and that that was
all that I could get as I could not scroll up or down in any way.

The PC is a Gateway laptop.

If you need more info, please holler.

CPU:	0
EIP:	0088:[<0000922d>]	Not tainted
EFLAGS:	00010046
EIP is at E Using_Versions+0x992c/0xc01172bf
eax: 00000040	ebx: 00009bd1	ecx: 00150000	edx: 00000005
esi: 0000c1b1	edi: 00000000	ebp: cffa1e0c	esp: cffa1db8
ds: 0090   es: 00a0   ss: 0068
Process swapper (pid: 1, threadinfo=cffa0000 task:c129e040)
Stack: c1f60090 9bd10005 c1d03032 c1940003 0a110011 0018c157 x1449bcb 0000c130
       c11b9bca 0000c109 00030000 1e0c0000 1dfecffa 9bb2cffa 00000000 00180000
       03010015 x7110000 02f8bc81 be12bcfc bdc70300 c776bdef 000001d0 1e84db40
Call Trace:
 [<c012ed0e>] cache_alloc_refill+0x1fa/0x260
 [<c015143e>] inode_init_once+0x10a/0x110
 [<c012f104>] kmem_cache_alloc+0xbc/0xc8
 [<c027217c>] __pnp_bios_get_dev_node+0x120/0x17c
 [<c0210000>] uart_shutdown+0x6c/0xc4
 [<c02721ee>] pnp_bios_get_dev_node+0x16/034
 [<c010508b>] init+0x33/0x188
 [<c0105058>] init+0x0/0x188
 [<c01054f9>] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
