Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030533AbWJJVta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbWJJVta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030531AbWJJVtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:49:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35003 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030513AbWJJVs6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:48:58 -0400
To: torvalds@osdl.org
Subject: [PATCH] cpuset ANSI prototype
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPT7-0007RR-FY@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:48:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/cpuset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index 9d850ae..6313c38 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -2137,7 +2137,7 @@ #ifdef CONFIG_MEMORY_HOTPLUG
  * See also the previous routine cpuset_handle_cpuhp().
  */
 
-void cpuset_track_online_nodes()
+void cpuset_track_online_nodes(void)
 {
 	common_cpu_mem_hotplug_unplug();
 }
-- 
1.4.2.GIT


