Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268834AbUJPUFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268834AbUJPUFs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUJPUDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:03:42 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:665 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268831AbUJPUDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:03:23 -0400
Subject: gcc 3.4 "makes pointer from integer without a cast" warnings in
	via-rhine-c
From: Lee Revell <rlrevell@joe-job.com>
To: rluethi@hellgate.ch
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097955967.2148.12.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 15:46:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get these warnings compiling via-rhine with gcc 3.4.  What is the
correct way to fix this?  This came up in another thread and someone
mentioned that just adding a cast is not a "real fix" but just hides the
problem.

drivers/net/via-rhine.c: In function `get_intr_status':
drivers/net/via-rhine.c:536: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/net/via-rhine.c:539: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/net/via-rhine.c: In function `rhine_power_init':
drivers/net/via-rhine.c:555: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/net/via-rhine.c:555: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/via-rhine.c:558: warning: passing arg 2 of `writeb' makes pointer from integer without a cast

etc

Lee

