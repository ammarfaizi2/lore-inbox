Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262145AbSJJTkT>; Thu, 10 Oct 2002 15:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262143AbSJJTkT>; Thu, 10 Oct 2002 15:40:19 -0400
Received: from netsonic.fi ([194.29.192.20]:41224 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S262145AbSJJTkS>;
	Thu, 10 Oct 2002 15:40:18 -0400
Date: Thu, 10 Oct 2002 22:46:02 +0300 (EEST)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: =?ISO-8859-1?Q?Oops_with=A02=2E5=2E40?=
Message-ID: <Pine.LNX.4.33.0210102240450.22300-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case you folks are interested, the kernel was compiled by me and all
the compiled files and symbol tables are still on my disk so if you want
something, let me know.

Linux mybox.fi 2.5.40 #1 SMP Sun Oct 6 03:18:20 EEST 2002 i686 unknown

Unable to handle kernel paging request at virtual address 5a5a5ad6
 printing eip:
c011249b
*pde = 00000000
Oops: 0000
tuner bttv video-buf i2c-algo-bit i2c-core videodev 3c59x usbcore
CPU:    0
EIP:    0060:[<c011249b>]    Tainted: G S
EFLAGS: 00010202
EIP is at flush_tlb_mm+0x1b/0x90
eax: c0ec1100   ebx: 5a5a5a5a   ecx: 00000000   edx: fffffffe
esi: 00400000   edi: 0018f000   ebp: c1d6cbf0   esp: ce597f04
ds: 0068   es: 0068   ss: 0068
Process java (pid: 11999, threadinfo=ce596000 task=c0ec1100)
Stack: 0018f000 c013897f 5a5a5a5a c1d6cbf0 defe5610 c0138af3 c150a7f0 c2e131e8
       ce597f30 c0ec17b0 ce597fc4 0000000b 00100077 00100077 00000000 c2e131e8
       c0138d3d c2e131e8 bf000000 bed8f000 00000025 00000025 d9e0c0c4 00100077
Call Trace:
 [<c013897f>]change_protection+0x1af/0x200
 [<c0138af3>]mprotect_attempt_merge+0x123/0x1e0
 [<c0138d3d>]mprotect_fixup+0x18d/0x1b0
 [<c0138ec4>]sys_mprotect+0x164/0x2f3
 [<c014d541>]sys_write+0x31/0x40
 [<c010786f>]syscall_call+0x7/0xb

Code: 23 53 7c 39 58 60 75 38 8b 40 5c 85 c0 74 08 0f 20 d8 0f 22
 <6>note: java[11999] exited with preempt_count 2

Thanks,
 Sampsa Ranta
 sampsa@netsonic.fi

