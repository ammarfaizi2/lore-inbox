Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281215AbRKLX56>; Mon, 12 Nov 2001 18:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281220AbRKLX5t>; Mon, 12 Nov 2001 18:57:49 -0500
Received: from ns1.deanox.com ([209.197.23.235]:17 "EHLO server.deanox.com")
	by vger.kernel.org with ESMTP id <S281215AbRKLX5l>;
	Mon, 12 Nov 2001 18:57:41 -0500
Message-Id: <3.0.6.32.20011112165757.00e404b0@server.deanox.com>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 12 Nov 2001 16:57:57 -0700
To: linux-kernel@vger.kernel.org
From: Lee Howard <faxguy@deanox.com>
Subject: lp oops with kernel 2.4.15-pre2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nov 12 12:01:44 zelda kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE]
Nov 12 12:01:44 zelda kernel: parport0: Printer, Hewlett-Packard HP
LaserJet 1200
Nov 12 12:01:44 zelda kernel: parport_pc: Via 686A parallel port: io=0x378
Nov 12 12:01:44 zelda kernel: lp0: using parport0 (polling).
Nov 12 12:01:44 zelda kernel: lp0: console ready
Nov 12 12:01:44 zelda kernel: lp0: compatibility mode
Nov 12 12:02:44 zelda kernel: Unable to handle kernel paging request at
virtual address f9c4bc58
Nov 12 12:02:44 zelda kernel:  printing eip:
Nov 12 12:02:44 zelda kernel: c0127264
Nov 12 12:02:44 zelda kernel: *pde = 00000000
Nov 12 12:02:44 zelda kernel: Oops: 0000
Nov 12 12:02:44 zelda kernel: CPU:    0
Nov 12 12:02:44 zelda kernel: EIP:    0010:[kmem_cache_alloc+100/176]
Not tainted
Nov 12 12:02:44 zelda kernel: EFLAGS: 00010807
Nov 12 12:02:44 zelda kernel: eax: 0bf02310   ebx: cffea0c0   ecx: ca043000
  edx: c1a322a0
Nov 12 12:02:44 zelda kernel: esi: 00000246   edi: f8118800   ebp: 000001f0
  esp: c6623ed4
Nov 12 12:02:44 zelda kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 12:02:44 zelda kernel: Process lpd (pid: 8470, stackpage=c6623000)
Nov 12 12:02:44 zelda kernel: Stack: 00000004 00000000 00000000 ffffffff
00000000 c320bdc0 c6623f44 00000005 
Nov 12 12:02:44 zelda kernel:        c013df77 cffea0c0 000001f0 399dc0c4
c02378a5 c6623f28 c020bd42 00000000 
Nov 12 12:02:44 zelda kernel:        c320bdc0 c6623f44 00000005 c01cbf49
c1404240 c6623f5c c01fddcc c1a322a0 
Nov 12 12:02:44 zelda kernel: Call Trace: [d_alloc+23/368] [sprintf+18/32]
[sock_map_fd+153/352] [unix_create+92/112] [sock_create+214/256] 
Nov 12 12:02:44 zelda kernel:    [dentry_open+346/384] [sys_socket+41/80]
[sys_socketcall+96/464] [do_page_fault+0/1200] [error_code+52/60]
[system_call+51/56] 
Nov 12 12:02:44 zelda kernel: 
Nov 12 12:02:44 zelda kernel: Code: 8b 44 81 18 89 41 14 03 79 0c 40 75 16
8b 41 04 8b 11 89 42 
Nov 12 12:02:47 zelda kernel:  <1>Unable to handle kernel paging request at
virtual address f9c4bc58

