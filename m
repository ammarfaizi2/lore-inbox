Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132126AbRDAKPy>; Sun, 1 Apr 2001 06:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132151AbRDAKPp>; Sun, 1 Apr 2001 06:15:45 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:5387 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S132126AbRDAKPf>;
	Sun, 1 Apr 2001 06:15:35 -0400
Date: Sun, 1 Apr 2001 03:15:19 -0700 (PDT)
From: nak@apfbioelectronics.com
To: linux-kernel@vger.kernel.org, linux-arm@lists.arm.linux.org.uk
Subject: kernel crash
Message-ID: <Pine.LNX.4.10.10104010306200.7185-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a general plea for help .. We were told Linux was the most stable OS
for embedded work so we put it to use in running our ARM based pacemaker.

It did well on the preliminary tests using simulated output we managed 3
weeks with no problems and almost perfect rhythm generation.

On the fourth week we began animal testing our product and it did fine for 5
days 3 hours and 10 minutes. 

On Thursday March 22 at 0419 hrs a software crash caused a malfunction in 
the pacemaker resulting in a large discharge of current, defibrilating the 
heart and forcing it into an angonal rhythm from which we were unable to 
cardiovert.
 
On top of that, the catastrophic failure means we will be unable to begin
human testing of our product until early 2003.

One of our techs managed to retrieve something he called an "oops"? from the
monitor and I've enclosed it below.  If anyone can help us with this please
get back to me.  We need to fix this as soon as possible so we can make final
product release as early as possible.

	sincerely, 
	Dr. Nakasumo
        Cardiac Products Dept.
        APF Bioelectronics

Unable to handle kernel paging request at virtual address ea0032fb
pgd = c0004000
*pgd = 00000000, *pmd = 00000000
Internal error: Oops: 2
CPU: 0
pc : [<c0021124>]    lr : [<c0021450>]
sp : c8785c98  ip : a0000013  fp : c8785cd0
r10: 01000000  r9 : 00000003  r8 : c8785cf8
r7 : 00000003  r6 : 00003240  r5 : e7933000  r4 : ea0032fb
r3 : 00000001  r2 : 01000000  r1 : c016209c  r0 : ea0032fb
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: C860117F  Table: C860117F  DAC: 0000001D
Process mtdblockd (pid: 7, stackpage=c8785000)
Stack:
c8785c80:                   c0021450 c0021124  00000013 ffffffff 00000000 00000
000
c8785ca0: 00000000 00000004 ffffffff ea0032fb  c8785cf8 c0121cf4 00000003 a0000
013
c8785cc0: 00000000 c8785cf4 c8785cd4 c0021450  c0020e44 ffffffff c8785d2c c9000
000
c8785ce0: c8785e28 00000005 c8785d4c c8785cf8  c001ab20 c0021390 00003240 00000
000
c8785d00: ea0032fb ea0000bb ffffffff c8784000  c9000000 c8785e28 00000005 00000
000
c8785d20: 00000000 c8785d4c c0374821 c8785d40  c0020d00 c0020afc a0000013 fffff
fff
c8785d40: c8785e00 c8785d50 c0020d00 c0020ad0  00000000 00000000 00000000 00000
000
c8785d60: 00000000 00000000 00000000 c8784000  00000000 00000001 c8785da4 c8785
d88
c8785d80: c0036390 c0036260 40000013 fa000000  c8785e0c fa000014 c8785dbc c8785
da8
c8785da0: c00367e4 c0036368 40000013 fa000000  c8785ddc c8785dc0 c001aa08 c0036
7c0
c8785dc0: 00000000 0000001a 00000000 c01893b0  c8785e08 c8785de0 ffffffff c9000
000
c8785de0: c8785e28 c0121d0c 00000005 20000013  00800080 c8785e24 c8785e04 c0021
450
c8785e00: c0020b2c ffffffff c8785e5c 00000000  00000000 ffffffff c8785e94 c8785
e28
c8785e20: c001ab20 c0021390 c9000000 e8040020  0003ffe0 00000000 00000000 00000
000
c8785e40: 00000000 00000000 ffffffff ffffffff  00800080 c8785e94 ffffffff c8785
e70
c8785e60: c00bf190 c011a7c0 20000013 ffffffff  00040000 00040000 c9000000 00040
000
c8785e80: 00000000 c8036504 c8785eb0 c8785e98  c00bf190 c011a78c c0189c60 c8036
4c0
c8785ea0: c015ddf0 c8785f28 c8785eb4 c00bc964  c00bf168 c8784000 c8036504 c8784
000
c8785ec0: 0000090d 00000000 00040000 00000000  00040000 00000000 c80364c0 00040
000
c8785ee0: 00000000 c8784000 00000000 00000000  00000000 c8784000 00000000 00000
000
c8785f00: 00040000 00000000 00000000 00000000  00040000 c9000000 c8785f78 c8785
f5c
c8785f20: c8785f2c c00b9ed4 c00bc0e4 c8785f78  c9000000 c01cf428 c01cf420 00001
000
c8785f40: 00000000 00040000 00000000 00000000  c8785fa4 c8785f60 c00bf588 c00b9
e1c
c8785f60: c8785f78 c9000000 00040000 c01db160  c0350000 00001000 00000000 c01cf
428
c8785f80: c02d0660 00000008 c018e158 c015de90  6901b116 c015de78 c8785fc4 c8785
fa8
c8785fa0: c00bfcd4 c00bf414 00000000 c8784000  c8785fc8 c018e158 c8785ffc c8785
fc8
c8785fc0: c00bfee4 c00bfba8 00000000 c8784000  c015de94 c015de94 00000000 c0187
160
c8785fe0: c0187120 c0188ba4 c018c494 c0014c34  00000000 c8786000 c001c620 c00bf
d8c
Backtrace:
Function entered at [<c0020e38>] from [<c0021450>] do_alignment
Function entered at [<c0021384>] from [<c001ab20>] do_data_abort
 r8 = 00000005  r7 = C8785E28  r6 = C9000000  r5 = C8785D2C
 r4 = FFFFFFFF
Function entered at [<c0020ac4>] from [<c0020d00>] __do_vmalloc_fault
Function entered at [<c0020b20>] from [<c0021450>] __do_page_fault
Function entered at [<c0021384>] from [<c001ab20>] do_DataAbort
 r8 = FFFFFFFF  r7 = 00000000  r6 = 00000000  r5 = C8785E5C
 r4 = FFFFFFFF
Function entered at [<c011a780>] from [<c00bf190>] memcpy
 r9 = C8036504  r8 = 00000000  r7 = 00040000  r6 = C9000000
 r5 = 00040000  r4 = 00040000
Function entered at [<c00bf15c>] from [<c00bc964>] sa1100_copy_from
 r6 = C015DDF0  r5 = C80364C0  r4 = C0189C60
Function entered at [<c00bc0d8>] from [<c00b9ed4>] cfi_intelext_read
Function entered at [<c00b9e10>] from [<c00bf588>] part_read
Function entered at [<c00bf408>] from [<c00bfcd4>] do_cached_write
Function entered at [<c00bfb9c>] from [<c00bfee4>] handle_mtdblock_request
 r7 = C018E158  r6 = C8785FC8  r5 = C8784000  r4 = 00000000
Function entered at [<c00bfd80>] from [<c001c620>] mtdblock_thread
Aiee, killing interrupt handler
Scheduling in interrupt
kernel BUG at sched.c:698!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
*pgd = c01a0001, *pmd = c01a0001, *pte = c000308b, *ppte = c000300a
Internal error: Oops: 0
CPU: 0
pc : [<c001fdc8>]    lr : [<c002e0ac>]
sp : c8785b08  ip : c8785ac4  fp : c8785b18
r10: 00000000  r9 : c0189c60  r8 : 00000000
r7 : 0000000b  r6 : c8784000  r5 : c8784000  r4 : 00000000
r3 : 00000000  r2 : c0154ea8  r1 : 00000000  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: C860117F  Table: C860117F  DAC: 0000001D
Process mtdblockd (pid: 7, stackpage=c8785000)


