Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbRCTVme>; Tue, 20 Mar 2001 16:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbRCTVmZ>; Tue, 20 Mar 2001 16:42:25 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:61057 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S131020AbRCTVmJ>; Tue, 20 Mar 2001 16:42:09 -0500
Date: Tue, 20 Mar 2001 21:45:08 GMT
From: James Stevenson <mistral@stev.org>
Message-Id: <200103202145.f2KLj8901031@stev.org>
To: linux-kernel@vger.kernel.org
Subject: OPPS 2.2.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.3.4 on i686 2.2.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel paging request at virtual address 72043a2e
current->tss.cr3 = 04074000, %cr3 = 04074000
*pde = 0000000
Oops: 0000
CPU:    0
EIP:    0010:[<c00f36a1>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: c7be1000   ecx: 00000000   edx: 00000078
esi: 0ab936c1   edi: c01818f0   ebp: c3de3c78   esp: c5525cac
ds: 0018   es: 0018   ss: 0018
Process diff (pid: 1805, process nr: 49, stackpage=c5525000)
Stack: 00000000 c02106d4 c01ef30d c018195a c7be1000 c5524000 c5525d84 c0162ac0 
       c3de3c78 c5525d84 00000078 c5525cf8 c5524000 c3de3c78 c3e34000 00000078 
       c5525cf8 c01818f0 c5525cf8 0000070d 000001f4 00000190 00000000 00000000 
Call Trace: [<c01ef30d>] [<c018195a>] [<c0162ac0>] [<c01818f0>] [<c019e687>] [<c019f9a0>] [<c019f92a>] 
       [<c019de78>] [<c01a1873>] [<c01a1acb>] [<c01534e4>] [<c015356e>] [<c0153688>] [<c0153213>] [<c01538c1>] 
       [<c011cb68>] [<c012b8df>] [<c011ccd7>] [<c011cc24>] [<c0152bae>] [<c0124a56>] [<c0109374>] 
Code: 00 90 2e 3a 04 72 0c 2e 3a 44 01 77 06 2e 84 54 02 75 09 83 

>>EIP; c00f36a1 Before first symbol   <=====
Trace; c01ef30d <timer_bug_msg+48ed/70a0>
Trace; c018195a <inet_sendmsg+6a/90>
Trace; c0162ac0 <sock_sendmsg+88/ac>
Trace; c01818f0 <inet_sendmsg+0/90>
Trace; c019e687 <xprt_sendmsg+103/18c>
Trace; c019f9a0 <do_xprt_transmit+6c/1c4>
Trace; c019f92a <xprt_transmit+86/90>
Trace; c019de78 <call_transmit+40/68>
Trace; c01a1873 <__rpc_execute+9f/2ac>
Trace; c01a1acb <rpc_execute+4b/50>
Trace; c01534e4 <nfs_pagein_one+144/16c>
Trace; c015356e <nfs_pagein_list+62/8c>
Trace; c0153688 <nfs_pagein_inode+40/5c>
Trace; c0153213 <nfs_readpage_async+143/160>
Trace; c01538c1 <nfs_readpage+95/c8>
Trace; c011cb68 <do_generic_file_read+52c/5e8>
Trace; c012b8df <lookup_dentry+15f/1e8>
Trace; c011ccd7 <generic_file_read+63/7c>
Trace; c011cc24 <file_read_actor+0/50>
Trace; c0152bae <nfs_file_read+6a/74>
Trace; c0124a56 <sys_read+ae/c4>
Trace; c0109374 <system_call+34/38>
Code;  c00f36a1 Before first symbol
00000000 <_EIP>:
Code;  c00f36a1 Before first symbol   <=====
   0:   00 90 2e 3a 04 72         add    %dl,0x72043a2e(%eax)   <=====
Code;  c00f36a7 Before first symbol
   6:   0c 2e                     or     $0x2e,%al
Code;  c00f36a9 Before first symbol
   8:   3a 44 01 77               cmp    0x77(%ecx,%eax,1),%al
Code;  c00f36ad Before first symbol
   c:   06                        push   %es
Code;  c00f36ae Before first symbol
   d:   2e 84 54 02 75            test   %dl,%cs:0x75(%edx,%eax,1)
Code;  c00f36b3 Before first symbol
  12:   09 83 00 00 00 00         or     %eax,0x0(%ebx)


2 warnings issued.  Results may not be reliable.
