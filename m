Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbTIDGry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbTIDGq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:46:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:17539 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264741AbTIDGqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:46:18 -0400
Date: Wed, 3 Sep 2003 23:44:13 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] remove duplicate includes in kernel/
Message-Id: <20030903234413.23709211.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Please apply to 2.6.0-current.

--
~Randy


patch_name:	kernel_incdups.patch
patch_version:	2003-09-03.22:36:47
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	remove duplicate #includes in kernel/
product:	Linux
product_versions: 2.6.0-test4
diffstat:	=
 kernel/softirq.c |    2 --
 1 files changed, 2 deletions(-)

diff -Naurp ./kernel/softirq.c~incdups ./kernel/softirq.c
--- ./kernel/softirq.c~incdups	2003-09-03 16:33:33.000000000 -0700
+++ ./kernel/softirq.c	2003-09-03 17:26:54.000000000 -0700
@@ -9,8 +9,6 @@
 #include <linux/module.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
-#include <linux/notifier.h>
-#include <linux/percpu.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
