Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbULRNc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbULRNc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 08:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbULRNc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 08:32:28 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:5505 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S262248AbULRNcX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 08:32:23 -0500
Message-ID: <41C43165.8010700@ribosome.natur.cuni.cz>
Date: Sat, 18 Dec 2004 14:32:21 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20041217
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: OOPS in 2.4.29-pre2
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm testing 2.4.29-pre2 kernelon my ASUS L3800C laptop.
I have already managed to get several, this is one of them.
Please Cc: me in replies. Thanks.


Unable to handle kernel paging request at virtual address 5a5a5a5a
5a5a5a5a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<5a5a5a5a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: f7428294   ebx: 5a5a5a5a   ecx: 5a5a5a5a   edx: 5a5a5a5a
esi: f7ee5f80   edi: f7ee4000   ebp: f7ee5f90   esp: f7ee5f78
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=f7ee5000)
Stack: c011fc4a 5a5a5a5a c04e3704 f7428294 00000000 00000000 f7ee5fec c0127dd7 
       c042ec30 f7ee5fb0 00000000 f7ee4000 f7ee4570 f7ee4560 00000001 00000000 
       0000001b 00010000 00000000 00000700 c0127c20 c04a7330 00000000 f7ee4000 
Call Trace:    [<c011fc4a>] [<c0127dd7>] [<c0127c20>] [<c0105000>] [<c01056de>]
  [<c0127c20>]
Code:  Bad EIP value.


>>EIP; 5a5a5a5a Before first symbol   <=====

>>eax; f7428294 <_end+36f2b9bc/39421788>
>>esi; f7ee5f80 <_end+379e96a8/39421788>
>>edi; f7ee4000 <_end+379e7728/39421788>
>>ebp; f7ee5f90 <_end+379e96b8/39421788>
>>esp; f7ee5f78 <_end+379e96a0/39421788>

Trace; c011fc4a <__run_task_queue+4a/60>
Trace; c0127dd7 <context_thread+1b7/1c0>
Trace; c0127c20 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c01056de <arch_kernel_thread+2e/40>
Trace; c0127c20 <context_thread+0/1c0>

