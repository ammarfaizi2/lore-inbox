Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWJ3Dde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWJ3Dde (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 22:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWJ3Dde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 22:33:34 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:40845 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030499AbWJ3Ddd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 22:33:33 -0500
Date: Sun, 29 Oct 2006 19:29:07 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] update some docbook comments
Message-Id: <20061029192907.a45fac43.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Correct a few comments in kernel-doc Doc and source files.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/kernel-doc-nano-HOWTO.txt |    1 +
 scripts/basic/docproc.c                 |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2619-rc3g5.orig/Documentation/kernel-doc-nano-HOWTO.txt
+++ linux-2619-rc3g5/Documentation/kernel-doc-nano-HOWTO.txt
@@ -17,7 +17,7 @@ are:
   special place-holders for where the extracted documentation should
   go.
 
-- scripts/docproc.c
+- scripts/basic/docproc.c
 
   This is a program for converting SGML template files into SGML
   files. When a file is referenced it is searched for symbols
--- linux-2619-rc3g5.orig/scripts/basic/docproc.c
+++ linux-2619-rc3g5/scripts/basic/docproc.c
@@ -250,7 +250,7 @@ void intfunc(char * filename) {	docfunct
 void extfunc(char * filename) { docfunctions(filename, FUNCTION);   }
 
 /*
- * Document sp_ecific function(s) in a file.
+ * Document specific function(s) in a file.
  * Call kernel-doc with the following parameters:
  * kernel-doc -docbook -function function1 [-function function2]
  */


---
