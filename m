Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUB2FDP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 00:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUB2FDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 00:03:15 -0500
Received: from web20003.mail.yahoo.com ([216.136.225.48]:51606 "HELO
	web20003.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261976AbUB2FDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 00:03:12 -0500
Message-ID: <20040229050309.41603.qmail@web20003.mail.yahoo.com>
Date: Sat, 28 Feb 2004 21:03:09 -0800 (PST)
From: 3days condor <dayscondor@yahoo.com>
Subject: 2.6.4-rc1 oops with debug 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok...
So whom is screaming here and why did it try to kill
the idle task? Is this important?

Doing alsactl to store mixer settings...
Feb 28 22:42:25 enlaptop kernel: Unable to handle
kernel paging request at virtual address de94b255
Feb 28 22:42:25 enlaptop kernel:  printing eip:
Feb 28 22:42:25 enlaptop kernel: de94b255
Feb 28 22:42:25 enlaptop kernel: *pde = 015d8067
Feb 28 22:42:25 enlaptop kernel: *pte = 00000000
Feb 28 22:42:25 enlaptop kernel: Oops: 0000 [#1]
Feb 28 22:42:25 enlaptop kernel: CPU:    0
Feb 28 22:42:25 enlaptop kernel: EIP:   
0060:[__crc_totalram_pages+86427/3928374]    Tainted:
P
Feb 28 22:42:25 enlaptop kernel: EIP:   
0060:[<de94b255>]    Tainted: P
Feb 28 22:42:25 enlaptop kernel: EFLAGS: 00010202
Feb 28 22:42:25 enlaptop kernel: EIP is at 0xde94b255
Feb 28 22:42:25 enlaptop kernel: eax: f2dd440d   ebx:
00008008   ecx: f2dd3e57   edx: 00008008
Feb 28 22:42:25 enlaptop kernel: esi: dad34eb0   edi:
dad34e00   ebp: c0415fcc   esp: c0415fb4
Feb 28 22:42:26 enlaptop kernel: ds: 007b   es: 007b  
ss: 0068
Feb 28 22:42:26 enlaptop kernel: Process swapper (pid:
0, threadinfo=c0414000 task=c0399ca0)
Feb 28 22:42:26 enlaptop kernel: Stack: 0000007b
dad34e00 ffffff00 c0414000 0009fe00 c0105000 c0415fd8
c01090dd
Feb 28 22:42:26 enlaptop kernel:        00000000
c0415ff8 c04167b9 c0399ca0 00000000 c043ad78 00000021
c04164f0
Feb 28 22:42:26 enlaptop kernel:        c0441280
0008e000 c010017e
Feb 28 22:42:26 enlaptop kernel: Call Trace:
Feb 28 22:42:26 enlaptop kernel:  [_stext+0/96]
rest_init+0x0/0x60
Feb 28 22:42:26 enlaptop kernel:  [<c0105000>]
rest_init+0x0/0x60
Feb 28 22:42:26 enlaptop kernel:  [cpu_idle+45/64]
cpu_idle+0x2d/0x40
Feb 28 22:42:26 enlaptop kernel:  [<c01090dd>]
cpu_idle+0x2d/0x40
Feb 28 22:42:26 enlaptop kernel: 
[start_kernel+377/448] start_kernel+0x179/0x1c0
Feb 28 22:42:26 enlaptop kernel:  [<c04167b9>]
start_kernel+0x179/0x1c0
Feb 28 22:42:26 enlaptop kernel: 
[unknown_bootoption+0/272]
unknown_bootoption+0x0/0x110
Feb 28 22:42:26 enlaptop kernel:  [<c04164f0>]
unknown_bootoption+0x0/0x110
Feb 28 22:42:26 enlaptop kernel:
Feb 28 22:42:26 enlaptop kernel: Code:  Bad EIP value.
Feb 28 22:42:26 enlaptop kernel:  <0>Kernel panic:
Attempted to kill the idle task!
Feb 28 22:42:26 enlaptop kernel: In idle task - not
syncing
Feb 28 22:42:26 enlaptop alsa:  succeeded
Feb 28 22:42:26 enlaptop alsa: ^[[65G
Feb 28 22:42:26 enlaptop alsa: [^[[1;32m
Feb 28 22:42:26 enlaptop alsa:


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
