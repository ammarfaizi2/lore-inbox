Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWHXUI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWHXUI1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWHXUI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:08:27 -0400
Received: from xenotime.net ([66.160.160.81]:60313 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422634AbWHXUI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:08:26 -0400
Date: Thu, 24 Aug 2006 13:11:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] doc: fix kernel-parameters 'quiet'
Message-Id: <20060824131137.3074a884.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix "quiet" parameter doc.  No trailing '=' sign, no value after it.
And it disables "most" kernel messages, not all of them.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/kernel-parameters.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2618-rc4g1.orig/Documentation/kernel-parameters.txt
+++ linux-2618-rc4g1/Documentation/kernel-parameters.txt
@@ -1316,7 +1316,7 @@ running once the system is up.
 	pt.		[PARIDE]
 			See Documentation/paride.txt.
 
-	quiet=		[KNL] Disable log messages
+	quiet		[KNL] Disable most log messages
 
 	r128=		[HW,DRM]
 


---
