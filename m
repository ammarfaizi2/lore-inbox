Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268819AbRG0KNv>; Fri, 27 Jul 2001 06:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268821AbRG0KNm>; Fri, 27 Jul 2001 06:13:42 -0400
Received: from abba.synaptique.co.uk ([213.86.145.226]:1120 "HELO
	host.domain.name") by vger.kernel.org with SMTP id <S268819AbRG0KN0>;
	Fri, 27 Jul 2001 06:13:26 -0400
Date: Fri, 27 Jul 2001 11:13:13 +0100
From: Samuel Dupas <samuel@dupas.com>
To: linux-kernel@vger.kernel.org
Subject: swap_free: swap-space map bad (entry 00000100)
Message-Id: <20010727111313.1da63aca.samuel@dupas.com>
X-Mailer: Sylpheed version 0.5.0 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi every body,

I have theses lines in /var/log/messages

Is it a kernel problem, a hardware problem ?

On the archives on mailling lists I found nothing interresting (I mean,
only the same question but no response)
Please help me.

It's on a Cobalt Raq4, 512 Mb RAM, kernel 2.2.16C27_III

The machine write theses lines for a week, but the system doesn't work
like usual (It's very slow).

Thanks for any advice.

(I'm not subscribed to the list, can you add my address in CC please ?)

/var/log/messages
--------------------------------------------------------------------
Jul 25 02:05:12 euro kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000114 
Jul 25 02:05:12 euro kernel: current->tss.cr3 = 0f0be000, %%cr3 = 0f0be000

Jul 25 02:05:12 euro kernel: *pde = 00000000 
Jul 25 02:05:12 euro kernel: Oops: 0000 
Jul 25 02:05:12 euro kernel: CPU:    0 
Jul 25 02:05:12 euro kernel: EIP:    0010:[try_to_free_buffers+18/136] 
Jul 25 02:05:12 euro kernel: EFLAGS: 00010206 
Jul 25 02:05:12 euro kernel: eax: 00000100   ebx: c055e360   ecx: 0001207c
  edx: 00040000 
Jul 25 02:05:12 euro kernel: esi: 00000100   edi: 00000100   ebp: c055e360
  esp: da98be90 
Jul 25 02:05:12 euro kernel: ds: 0018   es: 0018   ss: 0018 
Jul 25 02:05:12 euro kernel: Process rsync (pid: 28186, process nr: 12,
stackpage=da98b000) 
Jul 25 02:05:12 euro kernel: Stack: 00000006 00000013 c011c146 c055e360
da98a000 00000005 c0120faa 00000006  
Jul 25 02:05:12 euro kernel:        00000013 da98a000 00000013 00000000
00004000 00000001 00000008 c0121110  
Jul 25 02:05:12 euro kernel:        00000013 c01218d2 00000013 00003000
db2c6bb0 00000000 00004000 00490ad4  
Jul 25 02:05:12 euro kernel: Call Trace: [shrink_mmap+218/304]
[do_try_to_free_pages+78/232] [try_to_free_pages+20/24]
[__get_free_pages+122/812] [try_
to_read_ahead+254/276] [try_to_read_ahead+47/276]
[do_generic_file_read+750/1508]  
Jul 25 02:05:12 euro kernel:        [generic_file_read+99/124]
[file_read_actor+0/80] [sys_read+174/196] [system_call+52/56]  
Jul 25 02:05:12 euro kernel: Code: 8b 76 14 83 78 20 00 75 06 f6 40 18 46
74 0f 6a 00 e8 70 01  
Jul 25 04:02:44 euro kernel: swap_duplicate at c01222f4: entry 00000100,
unused page 
Jul 25 04:02:44 euro kernel: VM: killing process httpd 
Jul 25 04:02:44 euro kernel: swap_free: swap-space map bad (entry
00000100) 
Jul 25 04:02:44 euro kernel: swap_free: swap-space map bad (entry
00000100) 
Jul 25 04:02:44 euro kernel: swap_duplicate at c01222f4: entry 00000100,
unused page 
Jul 25 04:02:44 euro kernel: VM: killing process httpd 
Jul 25 04:02:44 euro kernel: swap_free: swap-space map bad (entry
00000100) 
Jul 25 04:02:44 euro kernel: swap_free: swap-space map bad (entry
00000100) 
Jul 25 04:02:44 euro kernel: swap_duplicate at c01222f4: entry 00000100,
unused page 
Jul 25 04:02:44 euro kernel: VM: killing process httpd 
Jul 25 04:02:44 euro kernel: swap_free: swap-space map bad (entry
00000100) 
Jul 25 04:02:44 euro kernel: swap_free: swap-space map bad (entry
00000100) 
Jul 25 04:02:44 euro kernel: swap_duplicate at c01222f4: entry 00000100,
unused page 
------------------------------------------------------------------------------------

Samuel Dupas
