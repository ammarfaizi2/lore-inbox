Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271138AbRHTJjM>; Mon, 20 Aug 2001 05:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271142AbRHTJjE>; Mon, 20 Aug 2001 05:39:04 -0400
Received: from altern.org ([212.73.209.210]:49931 "HELO altern.org")
	by vger.kernel.org with SMTP id <S271138AbRHTJiu>;
	Mon, 20 Aug 2001 05:38:50 -0400
Date: Mon, 20 Aug 2001 11:39:00 +0200 (CEST)
From: <deb@altern.org>
Subject: Oops in 2.2.19
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Message-Id: <20010820093857Z271138-761+2714@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0002
CPU:    0
EIP:    0010:[get_unmapped_area+124/156]
EFLAGS: 00010286
eax: 0000003d   ebx: c67f4560   ecx: ffffffff   edx: 0000003c
esi: c7feb740   edi: 00000286   ebp: c031eaa0   esp: c7f8fecc
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, process nr: 4, stackpage=c7f8f000)
Stack: c67f4560 c031eaa0 c01f4000 c029d888 c0108a78 c5ac1b40 c5ac1b40 c4ea06c0 
       c5ac1b40 c01246da c7feb740 c67f4560 c7feb740 c56d9fc0 c67f4560 c0123b20 
       00000010 00000206 c67f4560 c67f4560 c67f4ce0 c0125079 c67f4560 00001994 
Call Trace: [do_general_protection+820/876] [rw_swap_page_base+686/1160] [kmem_cache_reap+144/524] [__get_free_pages+685/748] [__get_free_pages+676/74     8] [__get_free_pages+733/748] [jiffiestotv+14/68] 
Code: c7 05 00 00 00 00 00 00 00 00 eb 12 83 c4 fc 56 53 68 3e c4 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0
Code;  00000007 Before first symbol
   7:   00 00 00 
Code;  0000000a Before first symbol
   a:   eb 12                     jmp    1e <_EIP+0x1e> 0000001e Before first symbol
Code;  0000000c Before first symbol
   c:   83 c4 fc                  add    $0xfffffffc,%esp
Code;  0000000f Before first symbol
   f:   56                        push   %esi
Code;  00000010 Before first symbol
  10:   53                        push   %ebx
Code;  00000011 Before first symbol
  11:   68 3e c4 00 00            push   $0xc43e


1 warning and 1 error issued.  Results may not be reliable.

