Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbTBVEhb>; Fri, 21 Feb 2003 23:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266851AbTBVEhb>; Fri, 21 Feb 2003 23:37:31 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:62911 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S264908AbTBVEha>; Fri, 21 Feb 2003 23:37:30 -0500
Message-ID: <3E5700EA.9070905@blue-labs.org>
Date: Fri, 21 Feb 2003 23:47:38 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.62, bootup, do_add_mount
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pentium II, kernel compiled with gcc 2.95.3

[...]
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
BIOS EDD facility v0.09 2003-Jan-22, 3 devices found
ACPI: (supports S0 S1 S4 S5)
Started krxiod 12
Started krxsecd 13
(filter_get_filter_fs,l. 234): ops at c05d4918
(fs/intermezzo/super.c:presto_get_sb,l. 253 1): Presto: unrecognized fs 
type or cache type
Unable to handle kernel NULL pointer dereference at virtual address 0000003c
 printing eip:
c016a6a4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c016a6a4>]    Not tainted
EFLAGS: 00010217
EIP is at do_kern_mount+0x58/0xa8
eax: 00000000   ebx: c3fe9720   ecx: c3f55000   edx: c3f55010
esi: 00000000   edi: c05124a0   ebp: c3fcbee0   esp: c3fcbed4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c3fca000 task=c3fc8000)
Stack: 00008001 c3fca000 c3e2800a c3fcbf04 c0186546 c3e28000 00008001 
c11ff000
       00000000 00008001 00000000 c3fcbf38 c3fcbf54 c018683d c3fcbf38 
c3e28000
       00008001 00000000 c11ff000 00000000 c3fca000 00000001 c3e29000 
c11ff000
Call Trace:
 [<c0186546>] do_add_mount+0x62/0x150
 [<c018683d>] do_mount+0x139/0x150
 [<c018718e>] sys_mount+0x136/0x224
 [<c010545e>] prepare_namespace+0xfe/0x140
 [<c01051a5>] init+0xcd/0x288
 [<c01050d8>] init+0x0/0x288
 [<c0107211>] kernel_thread_helper+0x5/0xc

Code: 8b 46 3c 85 c0 74 06 ff 00 80 48 04 08 89 43 10 8b 46 3c 89
 <0>Kernel panic: Attempted to kill init!

-- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


