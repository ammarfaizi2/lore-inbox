Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbVAKXnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVAKXnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVAKXm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:42:59 -0500
Received: from coderock.org ([193.77.147.115]:12486 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262953AbVAKXfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:35:30 -0500
Subject: [patch 09/11] kernel/sysctl.c: docbook comments update
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:35:17 +0100
Message-Id: <20050111233518.20C771F225@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Add comments about ppos, which was added some months ago.

Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/kernel/sysctl.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN kernel/sysctl.c~docs-kernel_sysctl kernel/sysctl.c
--- kj/kernel/sysctl.c~docs-kernel_sysctl	2005-01-10 18:00:27.000000000 +0100
+++ kj-domen/kernel/sysctl.c	2005-01-10 18:00:27.000000000 +0100
@@ -1368,6 +1368,7 @@ static ssize_t proc_writesys(struct file
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes a string from/to the user buffer. If the kernel
  * buffer provided is not large enough to hold the string, the
@@ -1584,6 +1585,7 @@ static int do_proc_dointvec(ctl_table *t
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
@@ -1688,6 +1690,7 @@ static int do_proc_dointvec_minmax_conv(
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string.
@@ -1820,6 +1823,7 @@ static int do_proc_doulongvec_minmax(ctl
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
  * values from/to the user buffer, treated as an ASCII string.
@@ -1842,6 +1846,7 @@ int proc_doulongvec_minmax(ctl_table *ta
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
  * values from/to the user buffer, treated as an ASCII string. The values
@@ -1911,6 +1916,8 @@ static int do_proc_dointvec_userhz_jiffi
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
_
