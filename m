Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267458AbUBSS2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUBSS2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:28:46 -0500
Received: from may.nosdns.com ([207.44.240.96]:53425 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S267458AbUBSS2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:28:40 -0500
Date: Thu, 19 Feb 2004 11:27:56 -0700
From: Elikster <elik@webspires.com>
X-Mailer: The Bat! (v2.02.3 CE) Personal
Reply-To: Elikster <elik@webspires.com>
Organization: WebSpires Technologies
X-Priority: 3 (Normal)
Message-ID: <1514338595.20040219112756@webspires.com>
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Kernel Oops - 2.4.24 Kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux,

  I been getting those Oops of late that seems to have started nearly a month ago and been persisting thoughout, dispite changing the kernels few times to try and shake this out.  Could this be the results of bad memory modules?

Feb 19 07:03:20 gettysburg kernel: swap_free: Bad swap offset entry 3d000000
Feb 19 07:03:20 gettysburg kernel: kernel BUG at page_alloc.c:124!
Feb 19 07:03:20 gettysburg kernel: invalid operand: 0000
Feb 19 07:03:20 gettysburg kernel: CPU:    0
Feb 19 07:03:20 gettysburg kernel: EIP:    0010:[<c0138494>]    Not tainted
Feb 19 07:03:20 gettysburg kernel: EFLAGS: 00010286
Feb 19 07:03:20 gettysburg kernel: eax: 01000010   ebx: c118ae90   ecx: c0ed1f00   edx: c0306800
Feb 19 07:03:20 gettysburg kernel: esi: 00000000   edi: c1000030   ebp: 00000000   esp: d4c9bd78
Feb 19 07:03:20 gettysburg kernel: ds: 0018   es: 0018   ss: 0018
Feb 19 07:03:20 gettysburg kernel: Process exim (pid: 9590, stackpage=d4c9b000)
Feb 19 07:03:20 gettysburg kernel: Stack: c02b80a2 c02a5b7d 3d000000 3d000000 c0ed1f04 0000001e c0ed1f00 c0365b14
Feb 19 07:03:20 gettysburg kernel:        00000001 00000001 00003000 c0126dbc c118ae90 00003000 00000001 fffed4f8
Feb 19 07:03:20 gettysburg kernel:        00000001 0013e000 d0752004 00400000 c0365b00 00000001 00003000 00400000
Feb 19 07:03:20 gettysburg kernel: Call Trace:    [<c0126dbc>] [<c0138bfb>] [<c0138cca>] [<c012c9c9>] [<c013e4ed>]
Feb 19 07:03:20 gettysburg kernel:   [<c0129ef9>] [<c013e4ed>] [<c01285aa>] [<c01186f8>] [<c011b7fe>] [<c0121d8d>]
Feb 19 07:03:20 gettysburg kernel:   [<c0121e7d>] [<c0121a33>] [<c0106db8>] [<c0141310>] [<c010cd27>] [<c011c462>]
Feb 19 07:03:20 gettysburg kernel:   [<c0115690>] [<c0106fbc>]
Feb 19 07:03:20 gettysburg kernel:
Feb 19 07:03:20 gettysburg kernel: Code: 0f 0b 7c 00 2a 80 2b c0 b8 02 00 00 00 f0 0f b3 43 18 b8 04
Feb 19 07:18:05 gettysburg kernel:  kernel BUG at page_alloc.c:124!
Feb 19 07:18:05 gettysburg kernel: invalid operand: 0000
Feb 19 07:18:05 gettysburg kernel: CPU:    2
Feb 19 07:18:05 gettysburg kernel: EIP:    0010:[<c0138494>]    Not tainted
Feb 19 07:18:05 gettysburg kernel: EFLAGS: 00010286
Feb 19 07:18:05 gettysburg kernel: eax: 01000010   ebx: c118ae90   ecx: c0ed1f00   edx: 00000000
Feb 19 07:18:05 gettysburg kernel: esi: 00000000   edi: c1000030   ebp: 00000000   esp: e8f73b84
Feb 19 07:18:05 gettysburg kernel: ds: 0018   es: 0018   ss: 0018
Feb 19 07:18:05 gettysburg kernel: Process httpd (pid: 12934, stackpage=e8f73000)
Feb 19 07:18:05 gettysburg kernel: Stack: c610fe68 c1c40030 c02eeaf0 00000206 c0ed1f04 0000001d c0ed1f00 ffffffff
Feb 19 07:18:05 gettysburg kernel:        c1000030 00950200 0007d000 c0126c4c c118ae90 00100000 0000007e fffd7574
Feb 19 07:18:05 gettysburg kernel:        00000000 0a1e0000 dbe6b0a0 0a0e0000 c0366b00 00000000 00100000 0a0e0000
Feb 19 07:18:05 gettysburg kernel: Call Trace:    [<c0126c4c>] [<c0156e42>] [<c0158971>] [<c0131eda>] [<c01435d8>]
Feb 19 07:18:05 gettysburg kernel:   [<c0129ef9>] [<c012c060>] [<c01499ec>] [<c014999c>] [<c0149c72>] [<c0163174>]
Feb 19 07:18:05 gettysburg kernel:   [<c0170a25>] [<c0170a36>] [<c0170bf9>] [<c012c112>] [<c014999c>] [<c0162da0>]
Feb 19 07:18:05 gettysburg kernel:   [<c014a350>] [<c014a632>] [<c014b8de>] [<c0105a90>] [<c0106f83>]
Feb 19 07:18:05 gettysburg kernel:
Feb 19 07:18:05 gettysburg kernel: Code: 0f 0b 7c 00 2a 80 2b c0 b8 02 00 00 00 f0 0f b3 43 18 b8 04
Feb 19 09:02:23 gettysburg kernel:  <7>sending pkt_too_big (len[1492] pmtu[1454]) to self
Feb 19 09:03:59 gettysburg kernel: sending pkt_too_big (len[1492] pmtu[1454]) to self
Feb 19 11:01:13 gettysburg kernel: swap_free: Bad swap offset entry f8000000
Feb 19 11:01:13 gettysburg kernel: Page has mapping still set. This is a serious situation. However if you
Feb 19 11:01:13 gettysburg kernel: are using the NVidia binary only module please report this bug to
Feb 19 11:01:13 gettysburg kernel: NVidia and not to the linux kernel mailinglist.
Feb 19 11:01:13 gettysburg kernel: kernel BUG at page_alloc.c:107!
Feb 19 11:01:13 gettysburg kernel: invalid operand: 0000
Feb 19 11:01:13 gettysburg kernel: CPU:    0
Feb 19 11:01:13 gettysburg kernel: EIP:    0010:[<c01383f7>]    Not tainted
Feb 19 11:01:13 gettysburg kernel: EFLAGS: 00010296
Feb 19 11:01:13 gettysburg kernel: eax: 00000033   ebx: c3d73bf8   ecx: 00000001   edx: c02ecbc8
Feb 19 11:01:13 gettysburg kernel: esi: 00000000   edi: 000000df   ebp: d871c944   esp: f0705d6c
Feb 19 11:01:13 gettysburg kernel: ds: 0018   es: 0018   ss: 0018
Feb 19 11:01:13 gettysburg kernel: Process cpaneld (pid: 7098, stackpage=f0705000)
Feb 19 11:01:13 gettysburg kernel: Stack: c02b78c0 c02b7860 c02b7800 c610fe68 d871c944 00000040 000000df c012a274
Feb 19 11:01:13 gettysburg kernel:        d871c880 00000004 c0365e8c 000000e3 000000df c202d390 c0126dbc c3d73bf8
Feb 19 11:01:13 gettysburg kernel:        000e7000 000000e2 fffed870 000000e2 0821c000 ced57084 08400000 c0365b00
Feb 19 11:01:13 gettysburg kernel: Call Trace:    [<c012a274>] [<c0126dbc>] [<c01556ec>] [<c0253a85>] [<c0129ef9>]
Feb 19 11:01:13 gettysburg kernel:   [<c01186f8>] [<c011b7fe>] [<c021bbf1>] [<c0121a33>] [<c0106db8>] [<c0121f72>]
Feb 19 11:01:13 gettysburg kernel:   [<c0107d50>] [<c01222e1>] [<c0108064>] [<c011c462>] [<c0107d50>] [<c0106fbc>]
Feb 19 11:01:13 gettysburg kernel:
Feb 19 11:01:13 gettysburg kernel: Code: 0f 0b 6b 00 2a 80 2b c0 83 c4 0c 8b 3d b0 52 37 c0 89 d8 29
Feb 19 11:33:03 gettysburg kernel:  <2>Page has mapping still set. This is a serious situation. However if you
Feb 19 11:42:59 gettysburg kernel: klogd 1.4.1, log source = /proc/kmsg started.
Feb 19 11:42:59 gettysburg kernel: Linux version 2.4.24-ow5 (root@gettysburg.hostforweb.net) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)) #2 SMP Fri Jan 30 12:37:19 EST 2004

-- 
Best regards,
 Elikster                          mailto:elik@webspires.com

