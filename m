Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265849AbRF2KVD>; Fri, 29 Jun 2001 06:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265850AbRF2KUn>; Fri, 29 Jun 2001 06:20:43 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:58278 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S265849AbRF2KUf>;
	Fri, 29 Jun 2001 06:20:35 -0400
Date: Fri, 29 Jun 2001 11:21:16 GMT
From: James Stevenson <mistral@stev.org>
Message-Id: <200106291121.f5TBLGL03880@cyrix.stev.org>
To: linux-kernel@vger.kernel.org
Subject: [OPPS] 2.4.5-ac15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.3.7 on i686 2.4.5-ac15  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac15 (default)
     -m /boot/System.map-2.4.5-ac15 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

invalid operand: 0000 
CPU:    0 
EIP:    0010:c0218c>] 
EFLAGS: 00210202 
esi: 00007000   ed c1000010   ebp: 00007000  sp: c0ed3ea0 
ds: 0018   es: 0018   ss: 0018 
Process Maelstrom (pid: 30242, stackpage=c0ed3000) 
Stack: 000068d0 00200286 00000000 c024fdb4 000000e0 c024ffac 00000000 c024ffa8  
       c012b292 00000007 00000001 00000000 c0ed3f54 c0baa2c0 c6c1fe8c c012b478  
       c013e1e3 c4561120 c0baa2c0 00000000 00000145 c01b5477 c0baa2c0 c6c1fe8c  
Call Trace: [<c012b292>] [<c012b478>] [<c013e1e3>] [<c01b5477>] [<c01b075f>]  
   [<c013e41c>] [<c013e8b9>] [<c0119152>] [<c0106cb7>]  
Code: 0f 0b 89 d8 eb 14 45 83 c7 0c 83 fd 09 0f 86 f5 fd ff ff ff  
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c012b292 <__alloc_pages+62/230>
Trace; c012b478 <__get_free_pages+18/30>
Trace; c013e1e3 <__pollwait+33/1070>
Trace; c01b5477 <datagram_poll+27/190>
Trace; c01b075f <sock_recvmsg+3df/5e0>
Trace; c013e41c <__pollwait+26c/1070>
Trace; c013e8b9 <__pollwait+709/1070>
Trace; c0119152 <get_fast_time+7e2/910>
Trace; c0106cb7 <__up_wakeup+113b/2594>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   89 d8                     mov    %ebx,%eax
Code;  00000004 Before first symbol
   4:   eb 14                     jmp    1a <_EIP+0x1a> 0000001a Before first symbol
Code;  00000006 Before first symbol
   6:   45                        inc    %ebp
Code;  00000007 Before first symbol
   7:   83 c7 0c                  add    $0xc,%edi
Code;  0000000a Before first symbol
   a:   83 fd 09                  cmp    $0x9,%ebp
Code;  0000000d Before first symbol
   d:   0f 86 f5 fd ff ff         jbe    fffffe08 <_EIP+0xfffffe08> fffffe08 <END_OF_CODE+377951b5/????>
Code;  00000013 Before first symbol
  13:   ff 00                     incl   (%eax)

