Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUJVUhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUJVUhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUJVUec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:34:32 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:43476 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267588AbUJVUVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:21:03 -0400
Date: Fri, 22 Oct 2004 13:20:42 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] UML IO sched support
Message-ID: <20041022202042.GA19790@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: cw@f00f.org

===== arch/um/Kconfig_block 1.5 vs edited =====
--- 1.5/arch/um/Kconfig_block	2004-10-13 21:08:32 -07:00
+++ edited/arch/um/Kconfig_block	2004-10-22 13:19:16 -07:00
@@ -69,5 +69,6 @@ config MMAPPER
         If you'd like to be able to provide a simulated IO port space for
         User-Mode Linux processes, say Y.  If unsure, say N.
 
-endmenu
+source "drivers/block/Kconfig.iosched"
 
+endmenu
