Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUIGPNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUIGPNU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268352AbUIGPKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:10:02 -0400
Received: from verein.lst.de ([213.95.11.210]:43162 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268312AbUIGPIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:08:44 -0400
Date: Tue, 7 Sep 2004 17:08:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove exports from audit code
Message-ID: <20040907150840.GA9432@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tons of ezports in the neew audit code, but not a single module that
actually uses one of them.


--- 1.2/kernel/audit.c	2004-08-24 11:08:41 +02:00
+++ edited/kernel/audit.c	2004-09-07 14:22:57 +02:00
@@ -810,16 +810,3 @@
 		audit_log_end(ab);
 	}
 }
-
-EXPORT_SYMBOL_GPL(audit_set_rate_limit);
-EXPORT_SYMBOL_GPL(audit_set_backlog_limit);
-EXPORT_SYMBOL_GPL(audit_set_enabled);
-EXPORT_SYMBOL_GPL(audit_set_failure);
-
-EXPORT_SYMBOL_GPL(audit_log_start);
-EXPORT_SYMBOL_GPL(audit_log_format);
-EXPORT_SYMBOL_GPL(audit_log_end_irq);
-EXPORT_SYMBOL_GPL(audit_log_end_fast);
-EXPORT_SYMBOL_GPL(audit_log_end);
-EXPORT_SYMBOL_GPL(audit_log);
-EXPORT_SYMBOL_GPL(audit_log_d_path);
--- 1.2/kernel/auditsc.c	2004-06-24 10:55:48 +02:00
+++ edited/kernel/auditsc.c	2004-09-07 14:22:50 +02:00
@@ -913,11 +913,3 @@
 	}
 	return 0;
 }
-
-EXPORT_SYMBOL_GPL(audit_alloc);
-EXPORT_SYMBOL_GPL(audit_free);
-EXPORT_SYMBOL_GPL(audit_syscall_entry);
-EXPORT_SYMBOL_GPL(audit_syscall_exit);
-EXPORT_SYMBOL_GPL(audit_getname);
-EXPORT_SYMBOL_GPL(audit_putname);
-EXPORT_SYMBOL_GPL(audit_inode);
