Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWJNPuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWJNPuk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 11:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWJNPuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 11:50:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:1231 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422689AbWJNPuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 11:50:39 -0400
Date: Sat, 14 Oct 2006 16:50:38 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] gfp_t in netlabel
Message-ID: <20061014155038.GM29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/net/netlabel.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 113337c..12c214b 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -136,7 +136,7 @@ struct netlbl_lsm_secattr {
  * on success, NULL on failure.
  *
  */
-static inline struct netlbl_lsm_cache *netlbl_secattr_cache_alloc(int flags)
+static inline struct netlbl_lsm_cache *netlbl_secattr_cache_alloc(gfp_t flags)
 {
 	struct netlbl_lsm_cache *cache;
 
-- 
1.4.2.GIT
