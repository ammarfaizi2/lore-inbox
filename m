Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269087AbUHaTvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269087AbUHaTvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268889AbUHaTrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:47:07 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:15175 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267310AbUHaTpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:45:09 -0400
Message-ID: <e2ae0e3b040831124553354bfa@mail.gmail.com>
Date: Tue, 31 Aug 2004 15:45:09 -0400
From: Jamie <white.phoenix@gmail.com>
Reply-To: Jamie <white.phoenix@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] 2.6.9-rc1-mm2 fails to compile (others report same error)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      kernel/wait.o
kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
include/linux/wait.h:143: error: previous declaration of
'__wait_on_bit' was here
kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
include/linux/wait.h:143: error: previous declaration of
'__wait_on_bit' was here
kernel/wait.c:170: error: conflicting types for '__wait_on_bit_lock'
include/linux/wait.h:144: error: previous declaration of
'__wait_on_bit_lock' was here
kernel/wait.c:170: error: conflicting types for '__wait_on_bit_lock'
include/linux/wait.h:144: error: previous declaration of
'__wait_on_bit_lock' was here
make[1]: *** [kernel/wait.o] Error 1
make: *** [kernel] Error 2


Linux Selphie 2.6.9-rc1-mm1 #1 Tue Aug 31 09:46:50 EDT 2004 i686 AMD
K7 processo AuthenticAMD GNU/Linux

Gnu C                  3.4.1
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         md5 ipv6 iptable_mangle ipt_MASQUERADE
iptable_nat ipt_state iptable_filter ip_tables nvidia 8139cp nvnet
