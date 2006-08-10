Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWHJUY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWHJUY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWHJUP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:27 -0400
Received: from mx1.suse.de ([195.135.220.2]:30864 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932375AbWHJTgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:00 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [44/145] x86_64: Remove leftover CVS Id in thunk.S
Message-Id: <20060810193558.8CC8B13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:58 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

And move the comment to a proper place.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/lib/thunk.S |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

Index: linux/arch/x86_64/lib/thunk.S
===================================================================
--- linux.orig/arch/x86_64/lib/thunk.S
+++ linux/arch/x86_64/lib/thunk.S
@@ -1,10 +1,9 @@
-	/*
-	 * Save registers before calling assembly functions. This avoids
-	 * disturbance of register allocation in some inline assembly constructs.
-	 * Copyright 2001,2002 by Andi Kleen, SuSE Labs.
-	 * Subject to the GNU public license, v.2. No warranty of any kind.
-	 * $Id: thunk.S,v 1.2 2002/03/13 20:06:58 ak Exp $
-	 */
+/*
+ * Save registers before calling assembly functions. This avoids
+ * disturbance of register allocation in some inline assembly constructs.
+ * Copyright 2001,2002 by Andi Kleen, SuSE Labs.
+ * Subject to the GNU public license, v.2. No warranty of any kind.
+ */
 
 	#include <linux/config.h>
 	#include <linux/linkage.h>
