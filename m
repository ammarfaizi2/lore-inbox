Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWA2VnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWA2VnX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWA2VnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:43:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50151 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751176AbWA2VnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:43:23 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] edac_mc: Remove include of version.h
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 14:42:55 -0700
Message-ID: <m1zmle7lsw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


By including version.h edac_mc was rebuilding on every incremental
build. Which defeats the point of incremental builds.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 drivers/edac/edac_mc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

c78e7d0ede7cb18a1801bc0a937e2da1e6293acd
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 4be9bd0..b10ee46 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -14,7 +14,6 @@
 
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/kernel.h>
-- 
1.1.5.g3480

