Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425424AbWLHLwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425424AbWLHLwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425425AbWLHLwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:52:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52357 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425424AbWLHLwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:52:46 -0500
Message-Id: <200612081152.kB8BqWOl019777@shell0.pdx.osdl.net>
Subject: [patch 10/13] cleanup taskstats.h
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Fix weird whitespace mangling in taskstats.h

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/taskstats.h |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff -puN include/linux/taskstats.h~cleanup-taskstatsh include/linux/taskstats.h
--- a/include/linux/taskstats.h~cleanup-taskstatsh
+++ a/include/linux/taskstats.h
@@ -115,31 +115,31 @@ struct taskstats {
 	__u64	ac_majflt;		/* Major Page Fault Count */
 	/* Basic Accounting Fields end */
 
- 	/* Extended accounting fields start */
+	/* Extended accounting fields start */
 	/* Accumulated RSS usage in duration of a task, in MBytes-usecs.
 	 * The current rss usage is added to this counter every time
 	 * a tick is charged to a task's system time. So, at the end we
 	 * will have memory usage multiplied by system time. Thus an
 	 * average usage per system time unit can be calculated.
 	 */
- 	__u64	coremem;		/* accumulated RSS usage in MB-usec */
+	__u64	coremem;		/* accumulated RSS usage in MB-usec */
 	/* Accumulated virtual memory usage in duration of a task.
 	 * Same as acct_rss_mem1 above except that we keep track of VM usage.
 	 */
- 	__u64	virtmem;		/* accumulated VM  usage in MB-usec */
+	__u64	virtmem;		/* accumulated VM  usage in MB-usec */
 
 	/* High watermark of RSS and virtual memory usage in duration of
 	 * a task, in KBytes.
 	 */
- 	__u64	hiwater_rss;		/* High-watermark of RSS usage, in KB */
- 	__u64	hiwater_vm;		/* High-water VM usage, in KB */
+	__u64	hiwater_rss;		/* High-watermark of RSS usage, in KB */
+	__u64	hiwater_vm;		/* High-water VM usage, in KB */
 
 	/* The following four fields are I/O statistics of a task. */
- 	__u64	read_char;		/* bytes read */
- 	__u64	write_char;		/* bytes written */
- 	__u64	read_syscalls;		/* read syscalls */
- 	__u64	write_syscalls;		/* write syscalls */
- 	/* Extended accounting fields end */
+	__u64	read_char;		/* bytes read */
+	__u64	write_char;		/* bytes written */
+	__u64	read_syscalls;		/* read syscalls */
+	__u64	write_syscalls;		/* write syscalls */
+	/* Extended accounting fields end */
 };
 
 
_
