Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWJFSGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWJFSGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWJFSGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:06:44 -0400
Received: from sccrmhc12.comcast.net ([204.127.200.82]:53756 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932142AbWJFSGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:06:43 -0400
Date: Fri, 6 Oct 2006 11:07:55 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-git] Fix ARM breakage due to no irq_regs.h
Message-ID: <20061006180755.GA31679@plexity.net>
Reply-To: dsaxena@plexity.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


diff --git a/include/asm-arm/irq_regs.h b/include/asm-arm/irq_regs.h
new file mode 100644
index 0000000..3dd9c0b
--- /dev/null
+++ b/include/asm-arm/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

"An open heart has no possessions, only experiences" - Matt Bibbeau
