Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTDULRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbTDULRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:17:12 -0400
Received: from [12.47.58.203] ([12.47.58.203]:7233 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263776AbTDULRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:17:12 -0400
Date: Mon, 21 Apr 2003 04:29:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: updates for the new IRQ API
Message-Id: <20030421042934.3728740d.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2003 11:29:07.0918 (UTC) FILETIME=[38E356E0:01C307F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A change was made today to the kernel's IRQ handlers.  See

http://sourceforge.net/mailarchive/forum.php?thread_id=1999147&forum_id=2314

for details.


The patch at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-irq-fixes.patch.gz

Is Linus's current bitkeeper tree, plus fixes for 350 files.  I got most of
it, but various scsi drivers and non-x86 architectures will still need work.


