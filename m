Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSKHE5y>; Thu, 7 Nov 2002 23:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSKHE5y>; Thu, 7 Nov 2002 23:57:54 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:24839 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S261594AbSKHE5x>; Thu, 7 Nov 2002 23:57:53 -0500
Message-ID: <3DCB4740.7B4456D5@compuserve.com>
Date: Fri, 08 Nov 2002 00:10:24 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: [WARN] IPv6 issues timer warning - bk tree
Content-Type: multipart/mixed;
 boundary="------------72028CA471544E3D2376E5D6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------72028CA471544E3D2376E5D6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

During boot I see the attached timer warning message with latest bk
tree.

-- 
Kevin
--------------72028CA471544E3D2376E5D6
Content-Type: text/plain; charset=us-ascii;
 name="bk_timer_warn"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bk_timer_warn"

Nov  7 23:50:07 sea kernel: IPv6 v0.8 for NET4.0
Nov  7 23:50:07 sea kernel: Uninitialised timer!
Nov  7 23:50:07 sea kernel: This is just a warning.  Your computer is OK
Nov  7 23:50:07 sea kernel: function=0xe09ebc40, data=0xd65acea0
Nov  7 23:50:07 sea kernel: Call Trace:
Nov  7 23:50:07 sea kernel:  [<c012af9d>] check_timer_failed+0x6d/0x70
Nov  7 23:50:07 sea kernel:  [<e09ebc40>] igmp6_timer_handler+0x0/0x70 [ipv6]
Nov  7 23:50:07 sea kernel:  [<c012b2fb>] del_timer+0x1b/0x90
Nov  7 23:50:07 sea kernel:  [<e09eba51>] igmp6_join_group+0xa1/0x170 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09ea9b8>] igmp6_group_added+0xa8/0x110 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09eacfc>] ipv6_dev_mc_inc+0x1cc/0x300 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09d6cca>] addrconf_join_solict+0x4a/0x50 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09d871c>] addrconf_dad_start+0x1c/0x1c0 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09d6075>] ipv6_add_addr+0x235/0x280 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09ffda0>] inet6addr_chain+0x0/0x20 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09d7eb1>] addrconf_add_linklocal+0x41/0x70 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09d7f83>] addrconf_dev_config+0xa3/0xd0 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09d9b3d>] addrconf_init+0xcd/0xf0 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09f7995>] .rodata.str1.1+0xb01/0xb2c [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09d30c0>] init_module+0x280/0x310 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09f6ef8>] .rodata.str1.1+0x64/0xb2c [ipv6]
Nov  7 23:50:07 sea kernel:  [<c012304f>] sys_init_module+0x4ef/0x640
Nov  7 23:50:07 sea kernel:  [<e09d2060>] inet6_sock_destruct+0x0/0x20 [ipv6]
Nov  7 23:50:07 sea kernel:  [<e09d2060>] inet6_sock_destruct+0x0/0x20 [ipv6]
Nov  7 23:50:07 sea kernel:  [<c010b373>] syscall_call+0x7/0xb
Nov  7 23:50:07 sea kernel: 
Nov  7 23:50:07 sea kernel: IPv6 over IPv4 tunneling driver

--------------72028CA471544E3D2376E5D6--

