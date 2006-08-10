Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWHJUT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWHJUT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWHJUPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:24043 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932525AbWHJTfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:51 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [36/145] x86_64: Document backtracer selection options
Message-Id: <20060810193550.1A80D13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:50 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r
Signed-off-by: Andi Kleen <ak@suse.de>

---
 Documentation/x86_64/boot-options.txt |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux/Documentation/x86_64/boot-options.txt
===================================================================
--- linux.orig/Documentation/x86_64/boot-options.txt
+++ linux/Documentation/x86_64/boot-options.txt
@@ -245,6 +245,13 @@ Debugging
 		newfallback: use new unwinder but fall back to old if it gets
 			stuck (default)
 
+  call_trace=[old|both|newfallback|new]
+		old: use old inexact backtracer
+		new: use new exact dwarf2 unwinder
+ 		both: print entries from both
+		newfallback: use new unwinder but fall back to old if it gets
+			stuck (default)
+
 Misc
 
   noreplacement  Don't replace instructions with more appropriate ones
