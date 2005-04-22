Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVDVPHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVDVPHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVDVPGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:06:21 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:65274 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261966AbVDVPBJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:01:09 -0400
Date: Fri, 22 Apr 2005 17:00:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 6/12] s390: allow longer debug feature names.
Message-ID: <20050422150037.GF17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 6/12] s390: allow longer debug feature names.

From: Michael Holzheu <holzheu@de.ibm.com>

The current limitation of 16 characters of the debug feature names
turned out to be insufficient. Increase it to 64 characters.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 include/asm-s390/debug.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/include/asm-s390/debug.h linux-2.6-patched/include/asm-s390/debug.h
--- linux-2.6/include/asm-s390/debug.h	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/debug.h	2005-04-22 15:45:03.000000000 +0200
@@ -43,7 +43,7 @@ struct __debug_entry{
 #define DEBUG_OFF_LEVEL            -1 /* level where debug is switched off */
 #define DEBUG_FLUSH_ALL            -1 /* parameter to flush all areas */
 #define DEBUG_MAX_VIEWS            10 /* max number of views in proc fs */
-#define DEBUG_MAX_PROCF_LEN        16 /* max length for a proc file name */
+#define DEBUG_MAX_PROCF_LEN        64 /* max length for a proc file name */
 #define DEBUG_DEFAULT_LEVEL        3  /* initial debug level */
 
 #define DEBUG_DIR_ROOT "s390dbf" /* name of debug root directory in proc fs */
