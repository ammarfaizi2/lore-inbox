Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261731AbSJHWbB>; Tue, 8 Oct 2002 18:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSJHWa3>; Tue, 8 Oct 2002 18:30:29 -0400
Received: from employees.nextframe.net ([212.169.100.200]:39919 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S261731AbSJHW3q>; Tue, 8 Oct 2002 18:29:46 -0400
Date: Wed, 9 Oct 2002 00:43:16 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: linux-kernel@vger.kernel.org
Subject: [OOPS 2.5.41] - Unable to handle kernel paging request ... EIP is at move_one_page+0x26/0x1bc
Message-ID: <20021009004316.A111@sexything>
Reply-To: morten.helgesen@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I`m seing this one on my P3 600 ... the kernel is a 2.5.41 with 
IDE TCQ (does not look like this has anything to do with the
oops, though).

Haven`t seen this one posted to the list yet. 

Unable to handle kernel paging request at virtual address 5a5a5a8e
 printing eip:
c01381a6
*pde = 00000000
Oops: 0000

CPU:    0
EIP:    0060:[move_one_page+38/444]    Not tainted
EFLAGS: 00010202
EIP is at move_one_page+0x26/0x1bc
eax: c266c000   ebx: 5a5a5a8a   ecx: 403e7000   edx: 403eb000
esi: 00001000   edi: 5a5a5a5a   ebp: 403e7000   esp: c266df24
ds: 0068   es: 0068   ss: 0068
Process opera (pid: 572, threadinfo=c266c000 task=c17dc800)
Stack:  00000000 00001000 403e7000 c39d62cc c266df64 00000000 c0138369 c39d62cc
	403eb000 403e7000 00000000 c463b1ec c463b1bc c39d62cc c0138b4e c39d62cc
	403e7000 403eb000 00001000 c463b1bc c266c000 00000000 c463b1d8 c4320f90
Call Trace:
 [move_page_tables+45/112] move_page_tables+0x2d/0x70
 [do_mremap+1954/2392] do_mremap+0x7a2/0x958
 [sys_mremap+83/116] sys_mremap+0x53/0x74
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 81 7b 04 ad 4e ad de 74 1a 68 a6 81 13 c0 68 fd 22 30 c0 e8
 <6>note: opera[572] exited with preempt_count 1


== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
