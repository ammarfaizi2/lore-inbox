Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWG3W33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWG3W33 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 18:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWG3W33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 18:29:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1410 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751418AbWG3W32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 18:29:28 -0400
Date: Sun, 30 Jul 2006 14:01:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc2: make -j 3 problems
Message-ID: <20060730120124.GA2750@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/kconfig/conf -s arch/i386/Kconfig
make: vfork: Interrupted system call
2.15user 1.10system 14.40 (0m14.407s) elapsed 22.62%CPU
pavel@amd:/data/l/linux$  time make -j 3
make: Segmentation fault (core dumped)
1.83user 0.46system 2.29 (0m2.295s) elapsed 100.00%CPU
pavel@amd:/data/l/linux$  time make -j 3
make: Makefile:866: fork: Interrupted system call
make: vfork: Interrupted system call
1.84user 0.45system 2.29 (0m2.297s) elapsed 99.95%CPU
pavel@amd:/data/l/linux$

...what is going on?
																Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
