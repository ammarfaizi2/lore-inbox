Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbTAFCT1>; Sun, 5 Jan 2003 21:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTAFCT1>; Sun, 5 Jan 2003 21:19:27 -0500
Received: from dp.samba.org ([66.70.73.150]:29882 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265681AbTAFCT1>;
	Sun, 5 Jan 2003 21:19:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: rth@twiddle.net, bjornw@axis.com, davidm@hpl.hp.com, geert@linux-m68k.org,
       ralf@gnu.org, mkp@mkp.net, willy@debian.org, anton@samba.org,
       gniibe@m17n.org, kkojima@rr.iij4u.or.jp, Jeff Dike <jdike@karaya.com>
Subject: Userspace Test Framework for module loader porting
Date: Mon, 06 Jan 2003 13:27:02 +1100
Message-Id: <20030106022803.902F82C0E2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The userspace test framework I used to develop module loading on
different archs is up at:

	http://www.kernel.org/pub/linux/kernel/people/rusty/modules/module-test-framework.tar.gz 

I found it much easier to use for each arch than doing the
crash/reboot cycle (and you can use a real debugger).

BTW, the change to use shared objects for modules is going to be a 2.7
thing: after 10 architectures, MIPS toolchain issues made it
non-trivial.  So the current stuff is what is going to be there for
2.6, so no point waiting 8)

Please report any problems!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
