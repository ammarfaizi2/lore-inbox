Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVCEPq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVCEPq4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVCEPhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:37:22 -0500
Received: from coderock.org ([193.77.147.115]:38819 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261990AbVCEPfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:35:32 -0500
Subject: [patch 03/12] kernel/sysctl.c: docbook comments update
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:35:15 +0100
Message-Id: <20050305153515.5670A1EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Add comments about ppos, which was added some months ago.

Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/kernel/sysctl.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN kernel/sysctl.c~docs-kernel_sysctl kernel/sysctl.c
--- kj/kernel/sysctl.c~docs-kernel_sysctl	2005-03-05 16:09:57.000000000 +0100
+++ kj-domen/kernel/sysctl.c	2005-03-05 16:09:57.000000000 +0100
@@ -1366,6 +1366,7 @@ static ssize_t proc_writesys(struct file
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes a string from/to the user buffer. If the kernel
  * buffer provided is not large enough to hold the string, the
@@ -1582,6 +1583,7 @@ static int do_proc_dointvec(ctl_table *t
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
@@ -1686,6 +1688,7 @@ static int do_proc_dointvec_minmax_conv(
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string.
@@ -1818,6 +1821,7 @@ static int do_proc_doulongvec_minmax(ctl
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
  * values from/to the user buffer, treated as an ASCII string.
@@ -1840,6 +1844,7 @@ int proc_doulongvec_minmax(ctl_table *ta
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
  * values from/to the user buffer, treated as an ASCII string. The values
@@ -1930,6 +1935,8 @@ static int do_proc_dointvec_ms_jiffies_c
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
_
