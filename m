Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSHMN0K>; Tue, 13 Aug 2002 09:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSHMN0K>; Tue, 13 Aug 2002 09:26:10 -0400
Received: from imail.ricis.com ([64.244.234.16]:41740 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S315337AbSHMN0I>;
	Tue, 13 Aug 2002 09:26:08 -0400
Date: Tue, 13 Aug 2002 08:43:58 -0500
From: Lee Leahu <lee@ricis.com>
To: linux-kernel@vger.kernel.org
Cc: lee@ricis.com
Subject: kernel crashes with 2.4.17
Message-Id: <20020813084358.7e8de7d3.lee@ricis.com>
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
X-Declude-Sender: lee@ricis.com [10.16.0.22]
X-Note: Total spam weight of this E-mail is 0. 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running the Linux Kernel 2.4.17.

>From what I have put here, what can you tell might be the problem?


Aug 13 06:38:38 list kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug 13 06:40:39 list kernel: general protection fault: 0000
Aug 13 06:40:39 list kernel: CPU:    0
Aug 13 06:40:39 list kernel: EIP:    0010:[<c010b036>]    Not tainted
Aug 13 06:40:39 list kernel: EFLAGS: 00010246
Aug 13 06:40:39 list kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: bffea93c
Aug 13 06:40:39 list kernel: esi: c001a53c   edi: f5a53bc0   ebp: fffffff2   esp: f5a23f84
Aug 13 06:40:39 list kernel: ds: 0018   es: 0018   ss: 0018
Aug 13 06:40:39 list kernel: Process rpm (pid: 1755, stackpage=f5a23000)
Aug 13 06:40:39 list kernel: Stack: f5a22000 80000000 00023370 bffea98c 00000000 c02d0900 00000000 f5a23fbc 
Aug 13 06:40:39 list kernel:        00000046 00000000 00024000 00000003 00000022 ffffffff 00000000 000004cc 
Aug 13 06:40:39 list kernel:        00000004 08143fc0 08143fc0 00023370 00000018 081b3a70 08143fc0 bffea99c 
Aug 13 06:40:39 list kernel: Call Trace: 
Aug 13 06:40:39 list kernel: 
Aug 13 06:40:39 list kernel: Code: cb eb 10 8d b4 26 00 00 00 00 31 c0 b9 06 00 00 00 f3 ab 85 
Aug 13 06:40:40 list kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Aug 13 06:40:40 list kernel:  printing eip:
Aug 13 06:40:40 list kernel: c013ed78
Aug 13 06:40:40 list kernel: *pde = 00000000
Aug 13 06:40:40 list kernel: Oops: 0000
Aug 13 06:40:40 list kernel: CPU:    0
Aug 13 06:40:40 list kernel: EIP:    0010:[<c013ed78>]    Not tainted
Aug 13 06:40:40 list kernel: EFLAGS: 00010213
Aug 13 06:40:40 list kernel: eax: c21968f8   ebx: fffffff0   ecx: 00000011   edx: b0c1a2dc
Aug 13 06:40:40 list kernel: esi: 00000000   edi: f5939fa4   ebp: 00000000   esp: f5939f14
Aug 13 06:40:40 list kernel: ds: 0018   es: 0018   ss: 0018
Aug 13 06:40:40 list kernel: Process mksusewmrc (pid: 1771, stackpage=f5939000)
Aug 13 06:40:40 list kernel: Stack: f5939f74 00000000 f5939fa4 f579ac00 c21968f8 f7eaa02b b0c1a2dc 0000000a 
Aug 13 06:40:40 list kernel:        c01370a4 f579c9a0 f5939f74 f5939f74 c0137728 f579c9a0 f5939f74 00000000 
Aug 13 06:40:40 list kernel:        f7eaa000 00000000 f5939fa4 00000009 c0136ebe 00000009 f7eaa035 00000000 
Aug 13 06:40:40 list kernel: Call Trace: [<c01370a4>] [<c0137728>] [<c0136ebe>] [<c013797a>] [<c0137cd5>] 
Aug 13 06:40:40 list kernel:    [<c0134f81>] [<c0106d73>] 
Aug 13 06:40:40 list kernel: 
Aug 13 06:40:40 list kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75 
Aug 13 06:40:40 list kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Aug 13 06:40:40 list kernel:  printing eip:
Aug 13 06:40:40 list kernel: c013ed78
Aug 13 06:40:40 list kernel: *pde = 00000000
Aug 13 06:40:40 list kernel: Oops: 0000
Aug 13 06:40:40 list kernel: CPU:    0
Aug 13 06:40:40 list kernel: EIP:    0010:[<c013ed78>]    Not tainted
Aug 13 06:40:40 list kernel: EFLAGS: 00010207
Aug 13 06:40:40 list kernel: eax: c2103630   ebx: fffffff4   ecx: 00000011   edx: 7c5691ec
Aug 13 06:40:40 list kernel: esi: 00000000   edi: f6c29fa4   ebp: 00000004   esp: f6c29f14
Aug 13 06:40:40 list kernel: ds: 0018   es: 0018   ss: 0018
Aug 13 06:40:40 list kernel: Process depmod (pid: 1778, stackpage=f6c29000)
Aug 13 06:40:40 list kernel: Stack: f6c29f74 00000000 f6c29fa4 f5762c20 c2103630 f7bcd031 7c5691ec 00000008 
Aug 13 06:40:40 list kernel:        c01370a4 f5765b60 f6c29f74 f6c29f74 c0137728 f5765b60 f6c29f74 00000000 
Aug 13 06:40:40 list kernel:        f7bcd000 00000000 f6c29fa4 00000008 c0136ebe 00000008 f7bcd039 00000000 
Aug 13 06:40:40 list kernel: Call Trace: [<c01370a4>] [<c0137728>] [<c0136ebe>] [<c013797a>] [<c0137cd5>] 
Aug 13 06:40:40 list kernel:    [<c0134ff9>] [<c0106d73>] 
Aug 13 06:40:40 list kernel: 
Aug 13 06:40:40 list kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75 
Aug 13 06:41:05 list kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Aug 13 06:41:05 list kernel:  printing eip:
Aug 13 06:41:05 list kernel: c013ed78
Aug 13 06:41:05 list kernel: *pde = 00000000
Aug 13 06:41:05 list kernel: Oops: 0000
Aug 13 06:41:05 list kernel: CPU:    0
Aug 13 06:41:05 list kernel: EIP:    0010:[<c013ed78>]    Not tainted
Aug 13 06:41:05 list kernel: EFLAGS: 00010207
Aug 13 06:41:05 list kernel: eax: c2103630   ebx: fffffff4   ecx: 00000011   edx: 7c5691ec
Aug 13 06:41:05 list kernel: esi: 00000000   edi: f56b3fa4   ebp: 00000004   esp: f56b3f14
Aug 13 06:41:05 list kernel: ds: 0018   es: 0018   ss: 0018
Aug 13 06:41:05 list kernel: Process depmod (pid: 1781, stackpage=f56b3000)
Aug 13 06:41:05 list kernel: Stack: f56b3f74 00000000 f56b3fa4 f5762c20 c2103630 f70c1031 7c5691ec 00000008 
Aug 13 06:41:05 list kernel:        c01370a4 f5765b60 f56b3f74 f56b3f74 c0137728 f5765b60 f56b3f74 00000000 
Aug 13 06:41:05 list kernel:        f70c1000 00000000 f56b3fa4 00000008 c0136ebe 00000008 f70c1039 00000000 
Aug 13 06:41:05 list kernel: Call Trace: [<c01370a4>] [<c0137728>] [<c0136ebe>] [<c013797a>] [<c0137cd5>] 
Aug 13 06:41:05 list kernel:    [<c0134ff9>] [<c0106d73>] 
Aug 13 06:41:05 list kernel: 
Aug 13 06:41:05 list kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75 
Aug 13 06:41:11 list kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Aug 13 06:41:11 list kernel:  printing eip:
Aug 13 06:41:11 list kernel: c013ed78
Aug 13 06:41:11 list kernel: *pde = 00000000
Aug 13 06:41:11 list kernel: Oops: 0000
Aug 13 06:41:11 list kernel: CPU:    0
Aug 13 06:41:11 list kernel: EIP:    0010:[<c013ed78>]    Not tainted
Aug 13 06:41:11 list kernel: EFLAGS: 00010207
Aug 13 06:41:11 list kernel: eax: c2103630   ebx: fffffff4   ecx: 00000011   edx: 7c5691ec
Aug 13 06:41:11 list kernel: esi: 00000000   edi: f56bffa4   ebp: 00000004   esp: f56bff14
Aug 13 06:41:11 list kernel: ds: 0018   es: 0018   ss: 0018
Aug 13 06:41:11 list kernel: Process depmod (pid: 1783, stackpage=f56bf000)
Aug 13 06:41:11 list kernel: Stack: f56bff74 00000000 f56bffa4 f5762c20 c2103630 f7869031 7c5691ec 00000008 
Aug 13 06:41:11 list kernel:        c01370a4 f5765b60 f56bff74 f56bff74 c0137728 f5765b60 f56bff74 00000000 
Aug 13 06:41:11 list kernel:        f7869000 00000000 f56bffa4 00000008 c0136ebe 00000008 f7869039 00000000 
Aug 13 06:41:11 list kernel: Call Trace: [<c01370a4>] [<c0137728>] [<c0136ebe>] [<c013797a>] [<c0137cd5>] 
Aug 13 06:41:11 list kernel:    [<c0134ff9>] [<c0106d73>] 
Aug 13 06:41:11 list kernel: 
Aug 13 06:41:11 list kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75 
Aug 13 06:41:33 list kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Aug 13 06:41:33 list kernel:  printing eip:
Aug 13 06:41:33 list kernel: c0112483
Aug 13 06:41:33 list kernel: *pde = 00000000
Aug 13 06:41:33 list kernel: Oops: 0000
Aug 13 06:41:33 list kernel: CPU:    0
Aug 13 06:41:33 list kernel: EIP:    0010:[<c0112483>]    Not tainted
Aug 13 06:41:33 list kernel: EFLAGS: 00010883
Aug 13 06:41:33 list kernel: eax: 00000000   ebx: 7b8ba401   ecx: 00000000   edx: f7be33a0
Aug 13 06:41:33 list kernel: esi: 00000046   edi: 00000001   ebp: f5679eb4   esp: f5679e9c
Aug 13 06:41:33 list kernel: ds: 0018   es: 0018   ss: 0018
Aug 13 06:41:33 list kernel: Process ps (pid: 1788, stackpage=f5679000)
Aug 13 06:41:33 list kernel: Stack: f7160f3c f7174060 f709baa0 f7160f40 00000286 00000001 f7ba64e0 c0201916 
Aug 13 06:41:33 list kernel:        f7174060 f709b5a0 c023d37b f7174060 00000000 f56741e0 f5679f14 0000006e 
Aug 13 06:41:33 list kernel:        bffff74c 00000018 7fffffff ffffff91 bffff6dc c01ffb17 f56741e0 f5679f14 
Aug 13 06:41:33 list kernel: Call Trace: [<c0201916>] [<c023d37b>] [<c01ffb17>] [<c01ff798>] [<c0200434>] 
Aug 13 06:41:33 list kernel:    [<c0106e84>] [<c0106d73>] 
Aug 13 06:41:33 list kernel: 
Aug 13 06:41:33 list kernel: Code: 8b 01 85 45 fc 74 4d 31 c0 9c 5e fa c7 01 00 00 00 00 83 79 
Aug 13 07:06:03 list kernel: Unable to handle kernel paging request at virtual address fffc7728
Aug 13 07:06:03 list kernel:  printing eip:
Aug 13 07:06:03 list kernel: c01225cc
Aug 13 07:06:03 list kernel: *pde = 00001063
Aug 13 07:06:03 list kernel: *pte = 00000000
Aug 13 07:06:03 list kernel: Oops: 0002
Aug 13 07:06:03 list kernel: CPU:    0
Aug 13 07:06:03 list kernel: EIP:    0010:[<c01225cc>]    Not tainted
Aug 13 07:06:03 list kernel: EFLAGS: 00010246
Aug 13 07:06:03 list kernel: eax: 00000000   ebx: c1f7ecc0   ecx: c1f7ecc0   edx: fffc7728
Aug 13 07:06:03 list kernel: esi: 00000000   edi: 00000000   ebp: f2637c90   esp: f25f5e38
Aug 13 07:06:03 list kernel: ds: 0018   es: 0018   ss: 0018
Aug 13 07:06:03 list kernel: Process removeaddys (pid: 1127, stackpage=f25f5000)
Aug 13 07:06:03 list kernel: Stack: c01225f6 c1f7ecc0 c0122729 c1f7ecc0 c1f7ecc0 c012288c c1f7ecc0 00000000 
Aug 13 07:06:03 list kernel:        f25f5e88 00000000 f2637c90 00000000 00000001 f25f5e88 00000000 c012292d 
Aug 13 07:06:03 list kernel:        00000000 00000000 f2637be0 00000000 00000000 c0120c41 f2637c90 00000000 
Aug 13 07:06:03 list kernel: Call Trace: [<c01225f6>] [<c0122729>] [<c012288c>] [<c012292d>] [<c0120c41>] 
Aug 13 07:06:03 list kernel:    [<c0140b5b>] [<c01809af>] [<c0140c80>] [<c012d999>] [<c0137bf0>] [<c01381f3>] 
Aug 13 07:06:03 list kernel:    [<c012e78b>] [<c012ead6>] [<c0106d73>] 
Aug 13 07:06:03 list kernel: 
Aug 13 07:06:03 list kernel: Code: 89 02 c7 41 30 00 00 00 00 ff 0d 60 c4 29 c0 c3 8b 54 24 04 
Aug 13 07:06:03 list kernel: apm: set display: Power management disabled
Aug 13 07:08:22 list kernel:  <1>Unable to handle kernel paging request at virtual address fffb233c
Aug 13 07:08:22 list kernel:  printing eip:
Aug 13 07:08:22 list kernel: c01225cc
Aug 13 07:08:22 list kernel: *pde = 00001063
Aug 13 07:08:22 list kernel: *pte = 00000000
Aug 13 07:08:22 list kernel: Oops: 0002
Aug 13 07:08:22 list kernel: CPU:    0
Aug 13 07:08:22 list kernel: EIP:    0010:[<c01225cc>]    Not tainted
Aug 13 07:08:22 list kernel: EFLAGS: 00010246
Aug 13 07:08:22 list kernel: eax: 00000000   ebx: c1f73a00   ecx: c1f73a00   edx: fffb233c
Aug 13 07:08:22 list kernel: esi: 00000000   edi: 00000000   ebp: f258dc30   esp: f252fe38
Aug 13 07:08:22 list kernel: ds: 0018   es: 0018   ss: 0018
Aug 13 07:08:22 list kernel: Process removeaddys (pid: 1224, stackpage=f252f000)
Aug 13 07:08:22 list kernel: Stack: c01225f6 c1f73a00 c0122729 c1f73a00 c1f73a00 c012288c c1f73a00 00000000 
Aug 13 07:08:22 list kernel:        f252fe88 00000000 f258dc30 00000000 00000001 f252fe88 00000000 c012292d 
Aug 13 07:08:22 list kernel:        00000000 00000000 f258db80 00000000 00000000 c0120c41 f258dc30 00000000 
Aug 13 07:08:22 list kernel: Call Trace: [<c01225f6>] [<c0122729>] [<c012288c>] [<c012292d>] [<c0120c41>] 
Aug 13 07:08:22 list kernel:    [<c0140b5b>] [<c01809af>] [<c0140c80>] [<c012d999>] [<c0137bf0>] [<c01381f3>] 
Aug 13 07:08:22 list kernel:    [<c012e78b>] [<c012ead6>] [<c0106d73>] 
Aug 13 07:08:22 list kernel: 
Aug 13 07:08:22 list kernel: Code: 89 02 c7 41 30 00 00 00 00 ff 0d 60 c4 29 c0 c3 8b 54 24 04 
Aug 13 07:17:53 list kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000018
Aug 13 07:17:53 list kernel:  printing eip:
Aug 13 07:17:53 list kernel: c01226d2
Aug 13 07:17:53 list kernel: *pde = 00000000
Aug 13 07:17:53 list kernel: Oops: 0000
Aug 13 07:17:53 list kernel: CPU:    0
Aug 13 07:17:53 list kernel: EIP:    0010:[<c01226d2>]    Not tainted
Aug 13 07:17:53 list kernel: EFLAGS: 00010282
Aug 13 07:17:53 list kernel: eax: 00000000   ebx: c1f7ee00   ecx: 00000000   edx: c1f7ee00
Aug 13 07:17:53 list kernel: esi: 00000000   edi: 00000000   ebp: f258d870   esp: f24d3e3c
Aug 13 07:17:53 list kernel: ds: 0018   es: 0018   ss: 0018
Aug 13 07:17:53 list kernel: Process removeaddys (pid: 1293, stackpage=f24d3000)
Aug 13 07:17:53 list kernel: Stack: c0122703 c1f7ee00 00000000 c1f7ee00 c012288c c1f7ee00 00000000 f24d3e88 
Aug 13 07:17:53 list kernel:        00000000 f258d870 00000000 00000001 f24d3e88 00000000 c012292d 00000000 
Aug 13 07:17:53 list kernel:        00000000 f258d7c0 00000000 00000000 c0120c41 f258d870 00000000 00000000 
Aug 13 07:17:53 list kernel: Call Trace: [<c0122703>] [<c012288c>] [<c012292d>] [<c0120c41>] [<c0140b5b>] 
Aug 13 07:17:53 list kernel:    [<c01809af>] [<c0140c80>] [<c012d999>] [<c0137bf0>] [<c01381f3>] [<c012e78b>] 
Aug 13 07:17:53 list kernel:    [<c012ead6>] [<c0106d73>] 
Aug 13 07:17:53 list kernel: 
Aug 13 07:17:53 list kernel: Code: 8b 40 18 85 c0 74 08 51 52 ff d0 83 c4 08 c3 6a 01 51 52 e8 

-- 
+----------------------------------+---------------------------------+
| Lee Leahu                        | voice -> 708-444-2690           |
| Internet Technology Specialist   | fax -> 708-444-2697             |
| RICIS, Inc.                      | email -> lee@ricis.com          |
+----------------------------------+---------------------------------+
| I cannot conceive that anybody will require multiplications at the |
| rate of 40,000 or even 4,000 per hour ...                          |
|		-- F. H. Wales (1936)                                |
+--------------------------------------------------------------------+
