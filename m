Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUIEUMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUIEUMh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 16:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUIEUMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 16:12:37 -0400
Received: from [65.61.200.145] ([65.61.200.145]:11161 "EHLO dotnoc.dotnoc.com")
	by vger.kernel.org with ESMTP id S267189AbUIEULq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 16:11:46 -0400
Message-ID: <1094411544.413b65185bdba@mail.dreamtoy.net>
Date: Sun,  5 Sep 2004 12:12:24 -0700
From: Nathan <lists@netdigix.com>
To: keepalived-devel@lists.sourceforge.net
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Kernel panic issues
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 216.232.223.77
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  I have a server running debian 3.0r1 kernel 2.4.25 and I get these kernel 
panic about 5 times this week.  If anyone can tell me what it means it would be 
greatly appreciated.  Any additional instructions on how to read kernel panic 
dumps would also be appreciated.


asdasdkernel BUG as slab.c:1263!
Invalid operand: 0000
CPU:	0
EIP:	0010:[<c012609d>] Not tainted
EFLAGS: 00010012
eax: f31eafff	ebx: c19ad700	ecx: 00000001	edx: 00000001
esi: f31ea800	edi: f31eabd3	ebp: c02cfca8	esp: c02cfc8c
ds: 0018	es: 0018	ss: 0018
Process swapper (pid: 0, stackpage=c02cf000)
Stack:	f69657fc c03397e0 00000020 00000800 00012800 f31eabd3 00000246 c02cfcc4
	c01f6b5e 0000065c 00000020 00000008 0000001c f74ec160 c02cfcf f887afe3
	00000620 00000020 00000008 0000001c f74ec160 c01fa090 00000000 f6ebec
Call Trace:	[<c01f6b5e>] [<f887afe3>] [<c01fa090>] [<f887ae58>] [<f887ae58>]
	[<c0107ee0>] [<c010806f>] [<c0125f2c>] [<c0231d11>] [<c02320c8>] 
[<c0207b60>]
	[<f887b4ef>] [<c010806f>] [<c0207b60>] [<c02010b7>] [<c0207b60>] 
[<c02079f5>]
	[<c0207b60>] [<c01fa40b>] [<c01fa4ad>] [<c01fa5bf>] [<c011552b>] 
[<c010809d>]
	[<c0105260>] [<c0105260>] [<c0105260>] [<c0105260>] [<c0105286>] 
[<c01052f9>]
	[<c0105000>] [<c010502a>]

Code: 0f 0b ef 04 60 33 26 c0 8b 7d f4 f7 c7 00 04 00 00 74 36 b8
 <0>Kernel panic: Aiee, Killing interrupt handler!
In interrupt handler - not syncing



Thanks and best regards,

- Nathan
- http://www.netdigix.com

