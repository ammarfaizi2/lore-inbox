Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129398AbRA3QAx>; Tue, 30 Jan 2001 11:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRA3QAd>; Tue, 30 Jan 2001 11:00:33 -0500
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:65325 "EHLO
	mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S129398AbRA3QAW>; Tue, 30 Jan 2001 11:00:22 -0500
Date: Tue, 30 Jan 2001 15:56:28 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: linux-kernel@vger.kernel.org
Subject: [OPPS] 2.2.18
Message-ID: <Pine.LNX.4.21.0101301554110.4183-100000@cyrix.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-BadReturnPath: mistral@cyrix.home rewritten as mistral@stev.org
  using "From" header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

got this opps the other day
on a 2.2.18 kernel
i will get more information if it is needed
though i cannot remember what i was doing at the time

ksymoops 0.7 on i686 2.2.18.  Options used
     -v /home/mistral/data/kernels/P200/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 0000000d
current->tss.cr3 = 02d95000, %cr3 = 02d95000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110b53>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c1cc7b00   ebx: c23cdcc0   ecx: c23cd9a0   edx: 00000001
esi: c23cdcc0   edi: 00000000   ebp: c2b11f0c   esp: c2b11ee0
ds: 0018   es: 0018   ss: 0018
Process gnome-terminal (pid: 884, process nr: 40, stackpage=c2b11000)
Stack: c7b8f920 c0187b09 c23cdcc0 00000054 c1cc7c78 c2b11f74 c01878cc 00000246 
       00000000 c23cd9a0 c57a64f4 c1cc7c78 c0162ac0 c1cc7c78 c2b11f74 00000054 
       c2b11f40 c1cc7c78 c2b11f6c c1cc7c24 00000054 c2b11f40 c01878cc c2b11f40 
Call Trace: [<c0187b09>] [<c01878cc>] [<c0162ac0>] [<c01878cc>] [<c0162cce>] [<c0124b47>] [<c0162c3c>] 
       [<c0109374>] [<c010002b>] 
Code: 53 85 c0 74 30 8d 70 fc 8b 18 85 db 74 27 39 f3 74 23 8b 13 

>>EIP; c0110b53 <__wake_up+7/48>   <=====
Trace; c0187b09 <unix_stream_sendmsg+23d/260>
Trace; c01878cc <unix_stream_sendmsg+0/260>
Trace; c0162ac0 <sock_sendmsg+88/ac>
Trace; c01878cc <unix_stream_sendmsg+0/260>
Trace; c0162cce <sock_write+92/9c>
Trace; c0124b47 <sys_write+db/100>
Trace; c0162c3c <sock_write+0/9c>
Trace; c0109374 <system_call+34/38>
Trace; c010002b <startup_32+2b/11e>
Code;  c0110b53 <__wake_up+7/48>
00000000 <_EIP>:
Code;  c0110b53 <__wake_up+7/48>   <=====
   0:   53                        push   %ebx   <=====
Code;  c0110b54 <__wake_up+8/48>
   1:   85 c0                     test   %eax,%eax
Code;  c0110b56 <__wake_up+a/48>
   3:   74 30                     je     35 <_EIP+0x35> c0110b88 <__wake_up+3c/48>
Code;  c0110b58 <__wake_up+c/48>
   5:   8d 70 fc                  lea    0xfffffffc(%eax),%esi
Code;  c0110b5b <__wake_up+f/48>
   8:   8b 18                     mov    (%eax),%ebx
Code;  c0110b5d <__wake_up+11/48>
   a:   85 db                     test   %ebx,%ebx
Code;  c0110b5f <__wake_up+13/48>
   c:   74 27                     je     35 <_EIP+0x35> c0110b88 <__wake_up+3c/48>
Code;  c0110b61 <__wake_up+15/48>
   e:   39 f3                     cmp    %esi,%ebx
Code;  c0110b63 <__wake_up+17/48>
  10:   74 23                     je     35 <_EIP+0x35> c0110b88 <__wake_up+3c/48>
Code;  c0110b65 <__wake_up+19/48>
  12:   8b 13                     mov    (%ebx),%edx


-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  3:50pm  up 14 days, 23:11,  3 users,  load average: 7.24, 6.63, 6.22

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
