Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbTGHHRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 03:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbTGHHRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 03:17:09 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:3663 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S265287AbTGHHRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 03:17:06 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Trivial Typo fixes in ipc
From: <ffrederick@prov-liege.be>
Cc: <ffrederick@users.sourceforge.net>
Date: Tue, 8 Jul 2003 09:59:29 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S265287AbTGHHRG/20030708071706Z+20939@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabian Frederick:
	-<ipc> typo fixes

--- util.orig	2003-07-08 08:59:03.000000000 +0200
+++ util.c	2003-07-08 08:59:15.000000000 +0200
@@ -432,12 +432,12 @@ void ipc64_perm_to_ipc_perm (struct ipc6
  * So far only shm_get_stat() calls ipc_get() via shm_get(), so ipc_get()
  * is called with shm_ids.sem locked.  Since grow_ary() is also called with
  * shm_ids.sem down(for Shared Memory), there is no need to add read 
- * barriers here to gurantee the writes in grow_ary() are seen in order 
+ * barriers here to guarantee the writes in grow_ary() are seen in order 
  * here (for Alpha).
  *
- * However ipc_get() itself does not necessary require ipc_ids.sem down. So
+ * However ipc_get() itself does not necessarily require ipc_ids.sem down. So
  * if in the future ipc_get() is used by other places without ipc_ids.sem
- * down, then ipc_get() needs read memery barriers as ipc_lock() does.
+ * down, then ipc_get() needs read memory barriers as ipc_lock() does.
  */
 struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
 {


___________________________________



