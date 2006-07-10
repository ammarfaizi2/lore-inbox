Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965300AbWGJWkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300AbWGJWkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965299AbWGJWke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:40:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39654 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965301AbWGJWkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:40:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] sysctl: Document that sys_sysctl will be removed.
Date: Mon, 10 Jul 2006 16:39:47 -0600
Message-ID: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 Documentation/feature-removal-schedule.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index e978943..bef1bf0 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -250,3 +250,14 @@ Why:	These drivers never compiled since 
 Who:	Jean Delvare <khali@linux-fr.org>
 
 ---------------------------
+
+What:	sys_sysctl
+When:	January 2007
+Why:	The same information is available through /proc/sys and that is the
+	interface user space prefers to use. And there do not appear to be
+	any existing user in user space of sys_sysctl.  The additional
+	maintenance overhead of keeping a set of binary names gets
+	in the way of doing a good job of maintaining this interface.
+
+Who:	Eric Biederman <ebiederm@xmission.com>
+
-- 
1.4.1.gac83a

