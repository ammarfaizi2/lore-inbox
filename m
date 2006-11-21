Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031343AbWKUTl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031343AbWKUTl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031346AbWKUTl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:41:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3593 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031343AbWKUTlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:41:55 -0500
Date: Tue, 21 Nov 2006 20:41:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/pid.c: remove two unused exports
Message-ID: <20061121194155.GH5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes two unused exports.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/kernel/pid.c.old	2006-11-21 19:55:17.000000000 +0100
+++ linux-2.6.19-rc5-mm2/kernel/pid.c	2006-11-21 20:28:36.000000000 +0100
@@ -246,7 +246,6 @@
 	}
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(find_pid);
 
 int fastcall attach_pid(struct task_struct *task, enum pid_type type, int nr)
 {
@@ -359,7 +358,6 @@
 
 	return pid;
 }
-EXPORT_SYMBOL_GPL(find_get_pid);
 
 int copy_pid_ns(int flags, struct task_struct *tsk)
 {
