Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVKHKhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVKHKhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 05:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKHKhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 05:37:04 -0500
Received: from mx1.mail.ru ([194.67.23.121]:27771 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751243AbVKHKhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 05:37:02 -0500
Subject: OOPS in 2.6.14
From: Alexey Maximov <amax@mail.ru>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 08 Nov 2005 16:36:47 +0600
Message-Id: <1131446207.10226.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please help!
See full bug info at http://bugzilla.kernel.org/show_bug.cgi?id=5563

gentoo ~x86 gcc3.4 kernel 32bit/pentiumII

clean oops
**********************************************************

Oops: 0000 [#1]
PREEMPT
Modules linked in: netconsole ne2k_pci 8390 binfmt_misc rtc dm_mirror sl811_hcd
usbhid
CPU:    0
EIP:    0060:[<c03c5350>]    Not tainted VLI
EFLAGS: 00000002   (2.6.14)
EIP is at do_page_fault+0x90/0x5c5
eax: c62f0000   ebx: c62f1000   ecx: c62f00c4   edx: 20656854
esi: 00000000   edi: c03c52c0   ebp: c62f00f0   esp: c62f00a0
ds: 007b   es: 007b   ss: 0068
Unable to handle kernel paging request at virtual address 0013391f
 printing eip:
c03c5350
*pde = 00000000
Oops: 0000 [#2]
PREEMPT
Modules linked in: netconsole ne2k_pci 8390 binfmt_misc rtc dm_mirror sl811_hcd
usbhid
CPU:    0
EIP:    0060:[<c03c5350>]    Not tainted VLI
EFLAGS: 00000006   (2.6.14)
EIP is at do_page_fault+0x90/0x5c5
eax: c62ed000   ebx: c62f00a0   ecx: c62ed0b8   edx: 001338a7
esi: c62f006c   edi: c03c52c0   ebp: c62ed0e4   esp: c62ed094
ds: 007b   es: 007b   ss: 0068
Unable to handle kernel paging request at virtual address ffffcd28
 printing eip:
c03c5350
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Unable to handle kernel paging request at virtual address ffffcec0
 printing eip:
c03c5614
*pde = 00002067
*pte = 00000000
Recursive die() failure, output suppressed
 do_IRQ: stack overflow: 40
 [<c0103e07>] dump_stack+0x17/0x20
 [<c0105046>] do_IRQ+0x96/0xa0
 [<c01039b2>] common_interrupt+0x1a/0x20
 [<c03c563d>] do_page_fault+0x37d/0x5c5
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103a9f>] error_code+0x4f/0x54
 =======================
 =======================
Unable to handle kernel paging request at virtual address 1dfae030
 printing eip:
c0103d2d
*pde = 00000000
Oops: 0000 [#3]
PREEMPT
Modules linked in: netconsole ne2k_pci 8390 binfmt_misc rtc dm_mirror sl811_hcd
usbhid
CPU:    0
EIP:    0060:[<c0103d2d>]    Not tainted VLI
EFLAGS: 00000007   (2.6.14)
EIP is at show_trace+0x6d/0xa0
eax: 1dfaeffd   ebx: c62e8008   ecx: 00000000   edx: c3d0d088
esi: c62e8008   edi: 1dfae000   ebp: c62e7048   esp: c62e7034
ds: 007b   es: 007b   ss: 0068
Process  (pid: 0, threadinfo=c62e6000 task=ffffdcb0)
Stack: c03dbbb7 c0103a9f fffff000 c62e707c 00000000 c62e7054 c0103e07 c62e7060
       c62e7074 c0105046 c03dbd7b 00000028 c62e7000 fffff000 ffffffff c03ddb19
       c62e70ec c01039b2 fffff000 00000074 c3d0d088 ffffffff c03ddb19 c62e70ec
Call Trace:
 =======================
Unable to handle kernel NULL pointer dereference at virtual address 00000030
 printing eip:
c0103d2d
*pde = 00000000
Oops: 0000 [#4]
PREEMPT
Modules linked in: netconsole ne2k_pci 8390 binfmt_misc rtc dm_mirror sl811_hcd
usbhid
CPU:    0
EIP:    0060:[<c0103d2d>]    Not tainted VLI
EFLAGS: 00000007   (2.6.14)
EIP is at show_trace+0x6d/0xa0
eax: 00000ffd   ebx: c62e6f08   ecx: 00000000   edx: 00000000
esi: c62e6f08   edi: 00000000   ebp: c62e6f08   esp: c62e6ef4
ds: 007b   es: 007b   ss: 0068
Process  (pid: 0, threadinfo=c62e6000 task=ffffdcb0)
Stack: c03dbbb7 c62e6f08 c62e7094 00000018 00000000 c62e6f28 c0103dda c03dbbd8
       c62e70ec c62e7034 c62e7034 c62e7000 00000000 c62e6f5c c0103f5a c03dbbef
       ffffde54 00000000 c62e6000 ffffdcb0 00000007 c04394a2 00000001 c62e7000
Call Trace:
 [<c0103dda>] show_stack+0x7a/0x90
 [<c0103f5a>] show_registers+0x14a/0x1c0
 [<c010414d>] die+0xdd/0x170
 [<c03c563d>] do_page_fault+0x37d/0x5c5
 [<c0103a9f>] error_code+0x4f/0x54
 [<c0103dda>] show_stack+0x7a/0x90
 [<c0103f5a>] show_registers+0x14a/0x1c0
 [<c010414d>] die+0xdd/0x170
 [<c03c563d>] do_page_fault+0x37d/0x5c5
 [<c0103a9f>] error_code+0x4f/0x54
 =======================
Code: 3d c0 89 5c 24 04 e8 43 8a 01 00 89 da b8 bb 06 40 c0 e8 b7 43 03 00 c7 04
24 af 27 40 c0 e8 2b 8a 01 00 8b 36 39 fe 77 c5 89 f3 <8b> 77 30 85 f6 74 1d c7
04 24 b7 bb 3d c0 e8 10 8a 01 00 eb a2
 <0>Kernel panic - not syncing: Fatal exception in interrupt



