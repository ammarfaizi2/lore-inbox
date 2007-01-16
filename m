Return-Path: <linux-kernel-owner+w=401wt.eu-S1752017AbXAQFCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbXAQFCg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 00:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbXAQFCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 00:02:36 -0500
Received: from fizeau.zen.co.uk ([212.23.8.67]:58117 "EHLO fizeau.zen.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017AbXAQFCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 00:02:35 -0500
X-Greylist: delayed 74882 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 00:02:35 EST
From: Giuliano Procida <giuliano.procida@googlemail.com>
Subject: [PATCH]: MTRR: cosmetic fixes
To: rgooch@atnf.csiro.au
CC: trivial@kernel.org, linux-kernel@vger.kernel.org,
       giuliano.procida@googlemail.com
Message-Id: <E1H6jQe-0003z2-Ry@hilfy.n22.homeunix.net>
Date: Tue, 16 Jan 2007 08:12:24 +0000
X-Originating-Rutherford-IP: [217.155.41.211]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH]: cosmetic fixes

[MTRR 2.6.19.1]: cosmetic fixes

Signed-off-by: Giuliano Procida <giuliano.procida@googlemail.com>

---

Fixed incorrect (though identical) types in struct mtrr_gentry32 and
tided some badly-indented comments.

--- linux-source-2.6.19.1.orig/include/asm-x86_64/mtrr.h	2006-12-11 19:32:53.000000000 +0000
+++ linux-source-2.6.19.1/include/asm-x86_64/mtrr.h	2007-01-16 07:33:19.000000000 +0000
@@ -30,7 +30,7 @@
 struct mtrr_sentry
 {
     unsigned long base;    /*  Base address     */
-    unsigned int size;    /*  Size of region   */
+    unsigned int size;     /*  Size of region   */
     unsigned int type;     /*  Type of region   */
 };
 
@@ -41,7 +41,7 @@ struct mtrr_sentry
 struct mtrr_gentry
 {
     unsigned long base;    /*  Base address     */
-    unsigned int size;    /*  Size of region   */
+    unsigned int size;     /*  Size of region   */
     unsigned int regnum;   /*  Register number  */
     unsigned int type;     /*  Type of region   */
 };
@@ -108,15 +108,15 @@ static __inline__ int mtrr_del_page (int
 struct mtrr_sentry32
 {
     compat_ulong_t base;    /*  Base address     */
-    compat_uint_t size;    /*  Size of region   */
+    compat_uint_t size;     /*  Size of region   */
     compat_uint_t type;     /*  Type of region   */
 };
 
 struct mtrr_gentry32
 {
-    compat_ulong_t regnum;   /*  Register number  */
-    compat_uint_t base;    /*  Base address     */
-    compat_uint_t size;    /*  Size of region   */
+    compat_uint_t regnum;   /*  Register number  */
+    compat_ulong_t base;    /*  Base address     */
+    compat_uint_t size;     /*  Size of region   */
     compat_uint_t type;     /*  Type of region   */
 };
 
