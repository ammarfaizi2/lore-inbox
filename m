Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTKWXaL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 18:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTKWXaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 18:30:11 -0500
Received: from holomorphy.com ([199.26.172.102]:44471 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263527AbTKWXaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 18:30:08 -0500
Date: Sun, 23 Nov 2003 15:30:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: remove mm->swap_address
Message-ID: <20031123233003.GV22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This field is 100% unused. This patch removes it.

diff -urpN linux-2.6.0-test9/include/linux/sched.h swpadr-2.6.0-test9/include/linux/sched.h
--- linux-2.6.0-test9/include/linux/sched.h	2003-10-25 11:42:56.000000000 -0700
+++ swpadr-2.6.0-test9/include/linux/sched.h	2003-11-23 15:16:42.000000000 -0800
@@ -205,7 +205,6 @@ struct mm_struct {
 	unsigned long rss, total_vm, locked_vm;
 	unsigned long def_flags;
 	cpumask_t cpu_vm_mask;
-	unsigned long swap_address;
 
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
 
