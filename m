Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272566AbTG1BC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272563AbTG1AEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:01 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272721AbTG0W6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Henrik Storner <henrik-kernel@hswn.dk>
Newsgroups: linux.kernel
Subject: 2.6.0-test2 - VFS: Cannot open root device "NULL" or sda1
Date: Sun, 27 Jul 2003 20:42:13 +0000 (UTC)
Organization: Linux Users Inc.
Message-ID: <bg1df5$1c2$1@ask.hswn.dk>
NNTP-Posting-Host: osiris.hswn.dk
X-Trace: ask.hswn.dk 1059338533 1410 172.16.10.100 (27 Jul 2003 20:42:13 GMT)
X-Complaints-To: news@ask.hswn.dk
NNTP-Posting-Date: Sun, 27 Jul 2003 20:42:13 +0000 (UTC)
User-Agent: nn/6.6.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed 2.6.0-test1 this afternoon, and was quite pleased that it
could burn some cd's without the trouble I'd had with ide-scsi.

So I know 2.6.0-test1 works for me. But 2.6.0-test2 with the same
configuration (just a "make oldconfig" in between) stops during boot
with:

VFS: Cannot open root device "NULL" or sda1
Please append a correct "root=" boot option
Kernel panic: Unable to mount root fs on sda1

I have LILO on /dev/hda, and the root fs on /dev/sda1.  Adding a
"root=/dev/sda1" at the LILO: prompt doesn't change anything.


Henrik
-- 
Henrik Storner <henrik@hswn.dk> 
