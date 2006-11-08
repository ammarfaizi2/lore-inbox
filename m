Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422770AbWKHUGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWKHUGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422778AbWKHUGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:06:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:56811 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422770AbWKHUGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:06:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=un1e0ydl2o15Gv15W48TSRFcZIi5kVs+Lw99t/r/jcXGlOpSEqZDbhmKe4eRRULry0CfHE6VolKOdPIMxaja7fphFGHqtzu04gnZ7or1PPh6JSLkvCM3b1pKAA/OdfXWm5mmyyWHrh+fF/5o/Q/9ga5WQh3gYxL5wW46vxPDOQA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: trivial@kernel.org
Subject: [PATCH][trivial] Kconfig: fix spelling error in config KALLSYMS help text
Date: Wed, 8 Nov 2006 21:08:02 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611082108.02288.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a small spelling mistake in the help text for the KALLSYMS config option.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 init/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index c8b2624..404e891 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -320,7 +320,7 @@ config SYSCTL_SYSCALL
  	  you should probably say N here.
 
 config KALLSYMS
-	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
+	 bool "Load all symbols for debugging/ksymoops" if EMBEDDED
 	 default y
 	 help
 	   Say Y here to let the kernel print out symbolic crash information and


