Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSLOWzx>; Sun, 15 Dec 2002 17:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSLOWzx>; Sun, 15 Dec 2002 17:55:53 -0500
Received: from mail.michigannet.com ([208.49.116.30]:45574 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S263204AbSLOWzw>; Sun, 15 Dec 2002 17:55:52 -0500
Date: Sun, 15 Dec 2002 18:03:44 -0500
From: Paul <set@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Oops 2.5.51] PnPBIOS: cat /proc/bus/pnp/escd
Message-ID: <20021215230344.GE1432@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi;

	'cat /proc/bus/pnp/escd' consistantly produces this:

Paul
set@pobox.com

(need any more info, just ask)

Unable to handle kernel paging request at virtual address ffffd000
 printing eip:
00007b74
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0088:[<00007b74>]    Not tainted
EFLAGS: 00010007
EIP is at 0x7b74
eax: 000000a0   ebx: 00a0d07b   ecx: 00000400   edx: 00000000
esi: 0000d000   edi: 00000000   ebp: c31e7eb0   esp: c31e7e88
ds: 00a0   es: 0098   ss: 0068
Process md5sum (pid: 25925, threadinfo=c31e6000 task=c7204640)
Stack: 00000000 0090d000 00907b89 d049d4eb 00000042 00680068 0246d016 00920098 
       c31e7efc 0080000b 00000042 00a00098 00000090 00000000 c0217074 00000060 
       00000082 00000000 00000000 00000068 00000068 00000246 00000042 c31e7efc 
Call Trace:
 [<c0217074>] __pnp_bios_read_escd+0xf0/0x14c
 [<c02170df>] pnp_bios_read_escd+0xf/0x30
 [<c02180cf>] proc_read_escd+0x5f/0xf0
 [<c015dab5>] proc_file_read+0xb9/0x174
 [<c0138d27>] vfs_read+0xab/0x150
 [<c0138ff4>] sys_read+0x28/0x3c
 [<c010a7c7>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <6>note: cat[25925] exited with preempt_count 1
