Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSJPMTj>; Wed, 16 Oct 2002 08:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbSJPMTj>; Wed, 16 Oct 2002 08:19:39 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2688 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S262476AbSJPMTh>;
	Wed, 16 Oct 2002 08:19:37 -0400
Date: Tue, 15 Oct 2002 17:17:35 -0400 (EDT)
From: davidsen <root@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.41 - APM will not work as a module
Message-ID: <Pine.LNX.4.44.0210151716050.5405-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f net/core/Makefile modules_install
make -f net/ethernet/Makefile modules_install
make -f net/ipv4/Makefile modules_install
make -f net/ipv4/netfilter/Makefile modules_install
make -f net/netlink/Makefile modules_install
make -f net/packet/Makefile modules_install
make -f net/sched/Makefile modules_install
make -f net/sunrpc/Makefile modules_install
make -f net/unix/Makefile modules_install
make -f lib/Makefile modules_install
make -f lib/zlib_inflate/Makefile modules_install
make -f arch/i386/lib/Makefile modules_install
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.41; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.41/kernel/arch/i386/kernel/apm.o
depmod: 	xtime_lock
make: *** [_modinst_post] Error 1
bilbo:root> exit
exit

Script done on Tue Oct 15 11:09:25 2002

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


