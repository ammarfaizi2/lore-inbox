Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUJHKBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUJHKBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 06:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268445AbUJHKBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 06:01:33 -0400
Received: from mail2.nexpoint.net ([128.121.4.6]:35594 "HELO
	mail2.nexpoint.net") by vger.kernel.org with SMTP id S268421AbUJHKBJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 06:01:09 -0400
Message-ID: <4166655F.3090506@hacman.nu>
Date: Fri, 08 Oct 2004 04:01:03 -0600
From: noir@hacman.nu
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.26 kernel BUG at dcache.c:653!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first post ever to a mailing list, so I hope I do alright.
The system was idling when it just hung. After a reboot, I get the 
following error with seemingly no way to get into my system.

kernel BUG at dcache.c:653!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c014a122>]    Not tainted
EFLAGS: 00010207
eax: 00000000    ebx: 00000000    ecx: d7fbd7e0    edx: 00000000
esi: d7fbd7b0    edi: d7fbd7b0    ebp: d7fbd7b0    esp: d7fe5eb4
ds: 0018    es: 0018    ss: 0018
Process swapper (pid: 1, stackpage=d7fe50000)
Stack: d7c2e060 d7fbd7b0 c0173374 d7fbd7b0 00000000 fffffff4 d7c2e0cc 
d7c2e060
        c014148a d7c2e060 d7fbd7b0 00000000 d7c4100c d7fbd740 d7fe5f74 
c0141ae6
        d7fbd740 d7fe5f0c 00000000 00000001 d7c2e060 00000000 d7c41005 
00000007
Call Trace:    [<c0173374>] [<c014148a>] [<c0141ae6>] [<c0141db9>] 
[<c0105000>]
   [<c01421c4>] [<c01d8463>] [<c01d781d>] [<c0105000>] [<c01369ae>] 
[<c0136d5b>]
   [<c0108d73>] [<c0105000>] [<c01050ad>] [<c0107343>] [<c0105060>]

Code: 0f 0b 8d 02 ba d4 2d c0 85 db 74 12 8b 43 10 8d 53 10 89 48
  <0>Kernel panic: Attempted to kill init!

If there is any needed information that I have excluded, please let me 
know and I will put it up as soon as possible.
