Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbTGTXy4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269107AbTGTXyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:54:55 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:20600 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S269100AbTGTXyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:54:52 -0400
Subject: [IPV6 Problem in 2.6.0-test1] Unable to handle kernel paging
	request at virtual address 6b6b6b6b
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1058746191.3240.2.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 20 Jul 2003 20:09:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jul 20 20:06:42 aurora kernel: Unable to handle kernel paging request at
virtual address 6b6b6b6b
Jul 20 20:06:42 aurora kernel:  printing eip:
Jul 20 20:06:42 aurora kernel: 6b6b6b6b
Jul 20 20:06:42 aurora kernel: *pde = 00000000
Jul 20 20:06:42 aurora kernel: Oops: 0000 [#1]
Jul 20 20:06:42 aurora kernel: CPU:    0
Jul 20 20:06:42 aurora kernel: EIP:    0060:[<6b6b6b6b>]    Not tainted
Jul 20 20:06:42 aurora kernel: EFLAGS: 00010286
Jul 20 20:06:42 aurora kernel: EIP is at 0x6b6b6b6b
Jul 20 20:06:42 aurora kernel: eax: dca4c084   ebx: dc95ccbc   ecx:
dd178104   edx: cd94db40
Jul 20 20:06:42 aurora kernel: esi: dc95ccbc   edi: 00000000   ebp:
00000000   esp: c3aa7cac
Jul 20 20:06:42 aurora kernel: ds: 007b   es: 007b   ss: 0068
Jul 20 20:06:42 aurora kernel: Process ogg123 (pid: 4504,
threadinfo=c3aa6000 task=cd236080)
Jul 20 20:06:42 aurora kernel: Stack: e0984a96 dc95ccbc 00000000
00000000 c3aa7d90 cd9772a4 00000000 00000000
Jul 20 20:06:42 aurora kernel:        000005dc dc95ccbc 00000000
00000028 e0984ed1 dc95ccbc c3aa7d50 00000010
Jul 20 20:06:42 aurora kernel:        00000000 cf88e084 df7683fc
4122c000 00000001 00000001 cd236080 dc68c60c
Jul 20 20:06:42 aurora kernel: Call Trace:
Jul 20 20:06:42 aurora kernel:  [<e0984a96>] ip6_output2+0x166/0x240
[ipv6]
Jul 20 20:06:42 aurora kernel:  [<e0984ed1>] ip6_xmit+0x1f1/0x370 [ipv6]
Jul 20 20:06:42 aurora kernel:  [<e09a4936>] tcp_v6_xmit+0x116/0x230
[ipv6]
Jul 20 20:06:42 aurora kernel:  [<c02621bf>]
tcp_transmit_skb+0x39f/0x5a0
Jul 20 20:06:42 aurora kernel:  [<c0264a91>] tcp_connect+0x3a1/0x470
Jul 20 20:06:42 aurora kernel:  [<e09a1937>] tcp_v6_connect+0x397/0x750
[ipv6]
Jul 20 20:06:42 aurora kernel:  [<c0277418>]
inet_stream_connect+0xe8/0x210
Jul 20 20:06:42 aurora kernel:  [<c02337bb>] sys_connect+0x9b/0xd0
Jul 20 20:06:42 aurora kernel:  [<c023236a>] sock_map_fd+0xfa/0x130
Jul 20 20:06:42 aurora kernel:  [<c023328b>] sock_create+0x10b/0x170
Jul 20 20:06:42 aurora kernel:  [<c023332d>] sys_socket+0x3d/0x60
Jul 20 20:06:42 aurora kernel:  [<c02343bd>] sys_socketcall+0xcd/0x2a0
Jul 20 20:06:42 aurora kernel:  [<c01608c5>] do_fcntl+0xb5/0x1a0
Jul 20 20:06:42 aurora kernel:  [<c0160ab9>] sys_fcntl64+0x79/0xc0
Jul 20 20:06:43 aurora kernel:  [<c010a839>] sysenter_past_esp+0x52/0x71
Jul 20 20:06:43 aurora kernel:
Jul 20 20:06:43 aurora kernel: Code:  Bad EIP value.

System is nVideo nForce 2 based motherboard running a mostly RedHat
Rawhide (up to date) with 2.6.0-test rpms by arjanv at RedHat.

Trever
--
"Having Microsoft give us advice on open standards is like W.C. Fields
giving moral advice to the Mormon Tabernacle Choir" -- Scott McNealy,
Sun Microsystems Inc.

