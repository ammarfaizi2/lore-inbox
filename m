Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbTBQUOa>; Mon, 17 Feb 2003 15:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267445AbTBQUOa>; Mon, 17 Feb 2003 15:14:30 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:3464 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267444AbTBQUOa>; Mon, 17 Feb 2003 15:14:30 -0500
Date: Mon, 17 Feb 2003 15:23:28 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: kai@tp1.ruhr-uni-bochum.de
Cc: linux-kernel@vger.kernel.org, rob@osinvestor.com
Subject: Build problem in 2.5.61/sparc
Message-ID: <20030217152328.A7540@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai, would you mind to glance at this:

[zaitcev@lebethron ksrc]$ cp linux-2.5.59-sparc.config linux-2.5.61-sparc/.config
[zaitcev@lebethron ksrc]$ cd linux-2.5.61-sparc
[zaitcev@lebethron linux-2.5.61-sparc]$ make oldconfig
make -f scripts/Makefile.build obj=scripts
make[1]: *** No rule to make target `scripts/fixdep', needed by `__build'.  Stop.
make: *** [scripts] Error 2
[zaitcev@lebethron linux-2.5.61-sparc]$

The last version I tried was 2.5.59. Also, 2.5.61 appears to work
for Rob, so, what am I doing wrong?

Yours,
-- Pete
