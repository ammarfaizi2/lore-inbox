Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbTGLRfc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 13:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbTGLRfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 13:35:32 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:5248 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S268000AbTGLRfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 13:35:30 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.75 slab corruption
Date: Sat, 12 Jul 2003 19:50:12 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307121950.12931.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For me 2.5.75 is worse than anything since I am testing 2.5.x (2.5.66),
how can I debug this one ?,
the call stack seems very small,
where can I begin ?
I never had a stable 2.5 on this computer, 
thinking about hard problem ?


Nicolas.

Jul 12 19:39:57 hal9003 kernel:  printing eip:
Jul 12 19:39:57 hal9003 kernel: 78116ef1
Jul 12 19:39:57 hal9003 kernel: Oops: 0000 [#1]
Jul 12 19:39:57 hal9003 kernel: CPU:    0
Jul 12 19:39:57 hal9003 kernel: EIP:    0060:[<78116ef1>]    Not tainted
Jul 12 19:39:57 hal9003 kernel: EFLAGS: 00010047
Jul 12 19:39:57 hal9003 kernel: EIP is at 0x78116ef1
Jul 12 19:39:57 hal9003 kernel: eax: 00000088   ebx: e77ca73c   ecx: c02e00c0   
edx: 00000027
Jul 12 19:39:57 hal9003 kernel: esi: f799e100   edi: c02de788   ebp: e5565fbc   
esp: e5565f9c
Jul 12 19:39:57 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jul 12 19:39:57 hal9003 kernel: Process kpat (pid: 14040, threadinfo=e5564000 
task=e5fd1880)
Jul 12 19:39:57 hal9003 kernel: Stack: c0147abc e5a6ad98 080986f8 0000061c 
e5fd1880 00000003 080986f8 080981b8
Jul 12 19:39:57 hal9003 kernel:        e5564000 c010900a 00000003 080986f8 
0000061c 080986f8 080981b8 bfffeb08
Jul 12 19:39:57 hal9003 kernel:        0000061c c010007b 0000007b 00000004 
40f6d728 00000073 00000246 bfffeae8
Jul 12 19:39:57 hal9003 kernel: Call Trace:
Jul 12 19:39:57 hal9003 kernel:  [sys_write+63/93] sys_write+0x3f/0x5d
Jul 12 19:39:57 hal9003 kernel:  [<c0147abc>] sys_write+0x3f/0x5d
Jul 12 19:39:57 hal9003 kernel:  [work_resched+5/22] work_resched+0x5/0x16
Jul 12 19:39:57 hal9003 kernel:  [<c010900a>] work_resched+0x5/0x16
Jul 12 19:39:57 hal9003 kernel:
Jul 12 19:39:57 hal9003 kernel: Code:  Bad EIP value.

