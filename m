Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbSLJG5L>; Tue, 10 Dec 2002 01:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSLJG5L>; Tue, 10 Dec 2002 01:57:11 -0500
Received: from dp.samba.org ([66.70.73.150]:37586 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266637AbSLJG5K>;
	Tue, 10 Dec 2002 01:57:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: Roger Luethi <rl@hellgate.ch>, David Brownell <david-b@pacbell.net>,
       Jim Radford <radford@blackbean.org>, Chris Cheney <ccheney@cheney.cx>,
       SL Baur <steve@kbuxd.necst.nec.co.jp>,
       Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: [RELEASE] module-init-tools 0.9.3
Date: Tue, 10 Dec 2002 18:04:27 +1100
Message-Id: <20021210070454.9DDB32C050@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	module-init-tools 0.9.3 and the associated RPM
modutils-2.4.21-7.src.rpm are out.

	http://www.[CC].kernel.org/pub/linux/kernel/people/rusty/modules/

This includes Roger Luethi's fix to the RPM which avoids screwing up
the old symlinks.

0.9.3 Version
	Fixes modprobe -r ordering (Thanks to Jim Radford's report)
	Extra rmmod options implemented (Thanks to David Brownell)

0.9.2 Version
	insmod now correctly ignores old options (Petr Vandrovec's bug report)
	depmod now generates modules.ccwmap (Arnd Bergmann's implementation)
	modprobe -r implemented (Jim Radford's implementation)

Please continue to send reports and patches!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
