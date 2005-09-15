Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030533AbVIOQnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbVIOQnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030534AbVIOQns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:43:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:65458 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030533AbVIOQns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:43:48 -0400
Subject: [PATCH 1/2] fix mm/Kconfig spelling
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 15 Sep 2005 09:42:18 -0700
Message-Id: <20050915164218.AD02EDC0@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I might let this slide in a comment, but it's in a top-level
Kconfig option.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN mm/Kconfig~A1-icantspell mm/Kconfig
--- memhotplug/mm/Kconfig~A1-icantspell	2005-09-14 09:32:36.000000000 -0700
+++ memhotplug-dave/mm/Kconfig	2005-09-14 09:32:36.000000000 -0700
@@ -29,7 +29,7 @@ config FLATMEM_MANUAL
 	  If unsure, choose this option (Flat Memory) over any other.
 
 config DISCONTIGMEM_MANUAL
-	bool "Discontigious Memory"
+	bool "Discontiguous Memory"
 	depends on ARCH_DISCONTIGMEM_ENABLE
 	help
 	  This option provides enhanced support for discontiguous
@@ -52,7 +52,7 @@ config SPARSEMEM_MANUAL
 	  memory hotplug systems.  This is normal.
 
 	  For many other systems, this will be an alternative to
-	  "Discontigious Memory".  This option provides some potential
+	  "Discontiguous Memory".  This option provides some potential
 	  performance benefits, along with decreased code complexity,
 	  but it is newer, and more experimental.
 
_
