Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWIVPE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWIVPE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWIVPE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:04:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49280 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932548AbWIVPE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:04:27 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] AFS: Amend the AFS configuration options
Date: Fri, 22 Sep 2006 16:04:12 +0100
To: akpm@osdl.org, joern@wohnheim.fh-wedel.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060922150412.21852.75144.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amend the text of AFS configuration options.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/Kconfig |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 25d2019..fe904cb 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1938,8 +1938,7 @@ config CODA_FS_OLD_API
 	  For most cases you probably want to say N.
 
 config AFS_FS
-# for fs/nls/Config.in
-	tristate "Andrew File System support (AFS) (Experimental)"
+	tristate "Andrew File System support (AFS) (EXPERIMENTAL)"
 	depends on INET && EXPERIMENTAL
 	select RXRPC
 	help
@@ -1951,12 +1950,12 @@ # for fs/nls/Config.in
 	  If unsure, say N.
 
 config AFS_FSCACHE
-	bool "Provide AFS client caching support"
+	bool "Provide AFS client caching support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	depends on AFS_FS=m && FSCACHE || AFS_FS=y && FSCACHE=y
 	help
-	  Say Y here if you want AFS data to be cached locally on through the
-	  generic filesystem cache manager
+	  Say Y here if you want AFS data to be cached locally on disk through
+	  the generic filesystem cache manager
 
 config RXRPC
 	tristate
