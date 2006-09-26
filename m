Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWIZPSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWIZPSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWIZPSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:18:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:53725 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932111AbWIZPSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:18:12 -0400
Subject: [PATCH] remove extra extern in 2.6.18-rt3
From: John Kacur <jkacur@ca.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 26 Sep 2006 11:14:53 -0400
Message-Id: <1159283693.21437.5.camel@tycho.torolab.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies if you are receiving this more than once - I was having
trouble with my mailer.

Remove a duplicate line.
Signed-off-by: "John Kacur" <jkacur@rogers.com>

Index: linux-2.6.18-rt3/include/linux/profile.h
===================================================================
--- linux-2.6.18-rt3.orig/include/linux/profile.h       2006-09-22 10:36:18.000000000 -0400
+++ linux-2.6.18-rt3/include/linux/profile.h    2006-09-22 14:48:49.000000000 -0400
@@ -34,8 +34,6 @@

 extern int prof_pid;

-extern int prof_pid;
-
 #ifdef CONFIG_PROFILING

 struct task_struct;


