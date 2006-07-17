Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWGQNel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWGQNel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 09:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWGQNel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 09:34:41 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:24797 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750745AbWGQNek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 09:34:40 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix line-wrapping in documentation of vmalloc_32_user()
Date: Mon, 17 Jul 2006 15:34:32 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607171534.33313@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix line-wrapping in documentation of vmalloc_32_user().

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit dc676c9c7abfac7ed26d48777e4be99e110508f3
tree 00cbe652d0ed16b324192e74f8f8765b81940bf0
parent 8352448458ede55c18c98b39823f71ea8e306c70
author Rolf Eike Beer <eike-kernel@sf-tec.de> Mon, 17 Jul 2006 14:26:27 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Mon, 17 Jul 2006 14:26:27 +0200

 mm/vmalloc.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 266162d..af05588 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -595,11 +595,12 @@ void *vmalloc_32(unsigned long size)
 EXPORT_SYMBOL(vmalloc_32);
 
 /**
- *	vmalloc_32_user  -  allocate virtually contiguous memory (32bit
- *			      addressable) which is zeroed so it can be
- *			      mapped to userspace without leaking data.
+ * vmalloc_32_user  -  allocate zeroed virtually contiguous 32bit memory
  *
- *	@size:		allocation size
+ * @size:		allocation size
+ *
+ * The resulting memory area is 32bit addressable and zeroed so it can be
+ * mapped to userspace without leaking data.
  */
 void *vmalloc_32_user(unsigned long size)
 {
