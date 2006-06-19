Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWFSUT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWFSUT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWFSUT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:19:58 -0400
Received: from xenotime.net ([66.160.160.81]:30659 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750727AbWFSUT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:19:57 -0400
Date: Mon, 19 Jun 2006 12:58:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tali@admingilde.org, akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: use Members for struct fields consistently
Message-Id: <20060619125806.8fe3eb53.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

kernel-doc struct fields should be consistently called "Members",
not "Arguments", so switch man-mode output to use "Members" like
all of the other formats do.


Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kernel-doc |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-pv.orig/scripts/kernel-doc
+++ linux-2617-pv/scripts/kernel-doc
@@ -1064,7 +1064,7 @@ sub output_struct_man(%) {
     }
     print "};\n.br\n";
 
-    print ".SH Arguments\n";
+    print ".SH Members\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
 	($parameter =~ /^#/) && next;
 


---
