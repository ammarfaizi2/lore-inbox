Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbUKTFOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbUKTFOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbUKTCjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:39:10 -0500
Received: from baikonur.stro.at ([213.239.196.228]:63619 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263013AbUKTC3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:29:31 -0500
Subject: [patch 2/8]  kernel/sysctl.c: docbook comments update
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:29:29 +0100
Message-ID: <E1CVL0E-0000Q1-A5@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Add comments about ppos, which was added some months ago.

Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc2-bk4-max/kernel/sysctl.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN kernel/sysctl.c~docs-kernel_sysctl kernel/sysctl.c
--- linux-2.6.10-rc2-bk4/kernel/sysctl.c~docs-kernel_sysctl	2004-11-20 03:04:44.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/kernel/sysctl.c	2004-11-20 03:04:44.000000000 +0100
@@ -1355,6 +1355,7 @@ static ssize_t proc_writesys(struct file
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes a string from/to the user buffer. If the kernel
  * buffer provided is not large enough to hold the string, the
@@ -1571,6 +1572,7 @@ static int do_proc_dointvec(ctl_table *t
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
@@ -1675,6 +1677,7 @@ static int do_proc_dointvec_minmax_conv(
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string.
@@ -1807,6 +1810,7 @@ static int do_proc_doulongvec_minmax(ctl
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
  * values from/to the user buffer, treated as an ASCII string.
@@ -1829,6 +1833,7 @@ int proc_doulongvec_minmax(ctl_table *ta
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
  * values from/to the user buffer, treated as an ASCII string. The values
@@ -1898,6 +1903,7 @@ static int do_proc_dointvec_userhz_jiffi
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
@@ -1920,6 +1926,7 @@ int proc_dointvec_jiffies(ctl_table *tab
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
_
