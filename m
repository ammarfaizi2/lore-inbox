Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTEAVlN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbTEAVlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 17:41:13 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:49547 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S262700AbTEAVlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 17:41:12 -0400
Message-ID: <3EB1975D.5060306@blue-labs.org>
Date: Thu, 01 May 2003 17:53:33 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030429
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.68, unmap_vmas
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel paging request at virtual address 6b6b6b6f
 printing eip:
c0150ada
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0150ada>]    Not tainted
EFLAGS: 00010202
EIP is at unmap_vmas+0x10a/0x330
eax: 40016000   ebx: 00001000   ecx: 00000000   edx: 6b6b6b6b
esi: 40016000   edi: 40016000   ebp: c367bed8   esp: cb747ec8
ds: 007b   es: 007b   ss: 0068
Process bmilter (pid: 12280, threadinfo=cb746000 task=dfc660a0)
Stack: c0586960 c367bed8 40015000 40016000 cb746000 cb746000 cb746000 
cb746000
       40016000 00000001 001f9000 00000000 cb746000 df551b04 40016000 
c0150e01
       cb747f24 df551b04 c367bed8 40015000 40016000 cb747f28 df551b38 
c0586960
Call Trace:
 [<c0150e01>] zap_page_range+0x101/0x1b0
 [<c015440e>] do_mmap_pgoff+0x38e/0x700
 [<c0110f9a>] sys_mmap2+0x7a/0xb0
 [<c01098bb>] syscall_call+0x7/0xb

Code: 39 42 04 72 22 90 85 d2 89 d5 74 0f 8b 52 04 3b 54 24 50 89
 <6>note: bmilter[12280] exited with preempt_count 1

-- 
Stupid disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.  Don't attach stupid disclaimers to your emails.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


