Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVLDPk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVLDPk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVLDPk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:40:59 -0500
Received: from [202.112.142.40] ([202.112.142.40]:14050 "EHLO
	core.nlsde.buaa.edu.cn") by vger.kernel.org with ESMTP
	id S932255AbVLDPk6 (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:40:58 -0500
Message-Id: <200512041626.jB4GQniA014381@core.nlsde.buaa.edu.cn>
From: "tony" <hqy@nlsde.buaa.edu.cn>
To: "'Linux Kernel Mailing List'" <Linux-Kernel@vger.kernel.org>
Subject: Help!Unable to handle kernel NULL pointer...
Date: Sun, 4 Dec 2005 23:37:02 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcX46nKuiDeMn09ITBWs+BuU/ksYmAAA9xAg
In-Reply-To: <17299.1331.368159.374754@gargle.gargle.HOWL>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.181
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

Recently I met some trouble, and need your help. My system is Redhat linux
2.4.20, and crash every few days. There are some messages in
'/var/log/messages'as following:

I have had searched the archives and found that some guys met this problem
before, but i didn't find the way to fix the trouble.

Is there anybody who would  like give me a hand?

Messages:
Nov 27 21:34:54 SHZX-WG04 kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000080
Nov 27 21:34:54 SHZX-WG04 kernel:  printing eip:
Nov 27 21:34:54 SHZX-WG04 kernel: c012cd07
Nov 27 21:34:54 SHZX-WG04 kernel: *pde = 06a47001
Nov 27 21:34:54 SHZX-WG04 kernel: *pte = 00000000
Nov 27 21:34:54 SHZX-WG04 kernel: Oops: 0000
Nov 27 21:34:54 SHZX-WG04 kernel: ide-cd cdrom lp parport autofs e1000
microcode keybdev mousedev hid input usb-uhci usbcore ext3 jbd aic79xx
sd_mod scsi_mod
Nov 27 21:34:54 SHZX-WG04 kernel: CPU:    2
Nov 27 21:34:54 SHZX-WG04 kernel: EIP:    0060:[<c012cd07>]    Not tainted
Nov 27 21:34:54 SHZX-WG04 kernel: EFLAGS: 00010202
Nov 27 21:34:54 SHZX-WG04 kernel:
Nov 27 21:34:54 SHZX-WG04 kernel: EIP is at access_process_vm [kernel] 0x27
(2.4.20-8bigmem)
Nov 27 21:34:54 SHZX-WG04 kernel: eax: 00000000   ebx: d8d93280   ecx:
00000017   edx: e9910000
Nov 27 21:34:54 SHZX-WG04 kernel: esi: 00000000   edi: e992c000   ebp:
e992c000   esp: edde9ef0
Nov 27 21:34:54 SHZX-WG04 kernel: ds: 0068   es: 0068   ss: 0068
Nov 27 21:34:54 SHZX-WG04 kernel: Process ps (pid: 18326,
stackpage=edde9000)
Nov 27 21:34:54 SHZX-WG04 kernel: Stack: c0160996 e0b9f180 edde9f10 00000202
00000001 00000000 edde9f84 cac05580
Nov 27 21:34:54 SHZX-WG04 kernel:        f421800c 00000202 00000000 e992c000
00000000 00000500 000001f0 d8d93280
Nov 27 21:34:54 SHZX-WG04 kernel:        00000000 e992c000 e9910000 c017b334
e9910000 bffffac8 e992c000 00000017
Nov 27 21:34:54 SHZX-WG04 kernel: Call Trace:   [<c0160996>] link_path_walk
[kernel] 0x656 (0xedde9ef0))
Nov 27 21:34:54 SHZX-WG04 kernel: [<c017b334>] proc_pid_cmdline [kernel]
0x74 (0xedde9f3c))
Nov 27 21:34:54 SHZX-WG04 kernel: [<c017b747>] proc_info_read [kernel] 0x77
(0xedde9f6c))
Nov 27 21:34:54 SHZX-WG04 kernel: [<c0153453>] sys_read [kernel] 0xa3
(0xedde9f94))
Nov 27 21:34:54 SHZX-WG04 kernel: [<c01527d2>] sys_open [kernel] 0xa2
(0xedde9fa8))
Nov 27 21:34:54 SHZX-WG04 kernel: [<c01098bf>] system_call [kernel] 0x33
(0xedde9fc0))
Nov 27 21:34:54 SHZX-WG04 kernel:
Nov 27 21:34:54 SHZX-WG04 kernel:
Nov 27 21:34:54 SHZX-WG04 kernel: Code: f6 80 80 00 00 00 01 74 2d 81 7c 24
30 40 b7 33 c0 74 23 f0

Tony howe
2005-12-04

