Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267015AbSK2LL0>; Fri, 29 Nov 2002 06:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267020AbSK2LKT>; Fri, 29 Nov 2002 06:10:19 -0500
Received: from dp.samba.org ([66.70.73.150]:6845 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267019AbSK2LKH>;
	Fri, 29 Nov 2002 06:10:07 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: "Adam J. Richter" <adam@yggdrasil.com>, Thomas Molina <tmolina@copper.net>
Subject: [ALPHA RELEASE] module-init-tools 0.9-alpha 
Date: Fri, 29 Nov 2002 21:54:25 +1100
Message-Id: <20021129111730.132532C316@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

0.9-alpha Version
o Fixed patch in NEWS to leave #include linux/elf.h, needed for
  CONFIG_KALLSYMS.
o Fixed extra newline in "in use by" message.
o Fixed parsing for new-style /proc/modules.
o Fixed version parsing code (thanks to Adam Richter's report)
o Fixed "running out of filedescriptors" (Adam Richter)	
o Implemented options in modprobe
o Implemented install in modprobe
o Implemented options in modules.conf2modprobe.conf
o Implemented install in modules.conf2modprobe.conf
o Implemented probeall in modules.conf2modprobe.conf
o Implemented probe in modules.conf2modprobe.conf
o Changed modprobe version to be constant string, for "strings" to work easily.

Lightly tested, but seems to work here.  No source RPM, since it's
still alpha.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
