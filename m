Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRFYTcH>; Mon, 25 Jun 2001 15:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFYTb5>; Mon, 25 Jun 2001 15:31:57 -0400
Received: from tungsten.btinternet.com ([194.73.73.81]:35510 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S261561AbRFYTbn> convert rfc822-to-8bit; Mon, 25 Jun 2001 15:31:43 -0400
Date: Mon, 25 Jun 2001 20:33:17 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Jeff Dike <jdike@karaya.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state
Message-ID: <Pine.LNX.4.30.0106252031240.25982-100000@cyrix.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi again

i have a stack now an

#0  schedule () at sched.c:536
#1  0x1002f932 in __wait_on_buffer (bh=0x50eb16e4) at  buffer.c:157
#2  0x10036f46 in block_read (filp=0x5009787c, buf=0x80c08f0
	"¤\201", count=8192, ppos=0x5009789c) at
	/home/mistral/dev/kernel/linux-2.4.5-um9/include/linux/locks.h:20
#3  0x1002eb4b in sys_read (fd=3, buf=0x80c00f0 "¤\201", count=8192)
	at read_write.c:133
#4  0x100fb807 in execute_syscall (regs={regs = {3, 135004400, 8192,
	1283476480, 0, 3212835652, 4294967258, 43, 43, 0, 0, 3,
	1074582884, 35, 582, 3212835588, 43}}) at syscall_kern.c:332
#5  0x100fb926 in syscall_handler (unused=0x0) at
	syscall_user.c:80

this should still be on #umldebug on irc.openproject.net
for the next few ours if anybodys intresting at taking a look though
gdb via a bot.

	James

-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
  8:30pm  up 2 days, 42 min,  4 users,  load average: 1.00, 0.94, 0.64

