Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSLZJqa>; Thu, 26 Dec 2002 04:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSLZJq3>; Thu, 26 Dec 2002 04:46:29 -0500
Received: from dp.samba.org ([66.70.73.150]:65242 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262826AbSLZJq3>;
	Thu, 26 Dec 2002 04:46:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: "Marco d'Itri" <md@Linux.IT>, Roger Luethi <rl@hellgate.ch>
Subject: [RELEASE] module-init-tools 0.9.6
Date: Thu, 26 Dec 2002 20:50:00 +1100
Message-Id: <20021226095444.F2A3B2C06D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not announcing every release, but we're coming up to 1.0 sometime
soon, as the TODO list is shrinking rapidly: top is man pages, which
I'll be working on now.

http://www.[COUNTRY].kernel.org/pub/linux/kernel/people/rusty/modules/module-init-tools-0.9.6.tar.gz
http://www.[COUNTRY].kernel.org/pub/linux/kernel/people/rusty/modules/modutils-2.4.21-10.src.rpm

Significant improvements this release:
o Implemented "remove", "--ignore-install" and "--ignore-remove", and
  use them in modprobe.conf2modules.conf.
o Loop reporting improved.
o Warn about lines in config file which aren't understood.
o Workaround for devfsd (which calls modprobe -C /etc/modules.conf).
o Testsuite implemented (also available above)
o Lotsa little bugfixes.

Special thanks to Roger Luethi for all his hard bugreporting!

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
