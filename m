Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbTGADEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 23:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbTGADEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 23:04:52 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:63263 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S265839AbTGADEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 23:04:51 -0400
Subject: [Patchset] 2.4.22-pre2-dis5 available
From: Disconnect <kernel@gotontheinter.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1057029517.2861.13.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 30 Jun 2003 23:18:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.22-pre2-dis5 is released. Based on the 2.4 Bitkeeper tree as of this
afternoon, it offers quite a few new features compared to dis4. I've
worked with this one a lot over the past week or so, and only had minor
issues (see the Notes section on the site).

As always, its available from http://www.gotontheinter.net/kernel/ ..

No preempt yet, and (unless someone else steps up to do the port) its
not likely to happen anytime soon (the main swsusp developers have more
pressing issues). In theory its not too difficult; just find -all- the
places the kernel might reenable preemption and wrap them in
disable_preempt() calls. Heh. In the meantime, this one includes lots of
other new goodies (patched against 2.4.22-pre2, this patch includes the
latest BK as of this afternoon):

- Low-latency (everyone wants it, now its here)
- Supermount-NG 1.2.7
- Software Suspend 1.0-pre16
- New DSDT (from Adrian Dewhurst) for the Inspiron 8500. Fixes lots of
   vendor bugs and is basically the fix I was hoping to avoid doing. 
   Thanks Adrian!
- New Radeon DRM (so you no longer need the one listed below)
- BootSplash 3.0.7, with a new Configure.help entry and swsusp patches
- O_DIRECT
- Packet mode for 2.4.21
- Newest ACPI from Bitkeeper about 3-5 days ago.
- Everything that was included in -dis4

Patches available against 2.4.21 and 2.4.22-pre2.

