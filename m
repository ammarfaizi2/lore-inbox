Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUGRSpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUGRSpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 14:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUGRSpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 14:45:16 -0400
Received: from web53802.mail.yahoo.com ([206.190.36.197]:52629 "HELO
	web53802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264382AbUGRSpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 14:45:12 -0400
Message-ID: <20040718184511.73905.qmail@web53802.mail.yahoo.com>
Date: Sun, 18 Jul 2004 11:45:11 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of non-existent funcs from security/selinux files
To: linux-kernel@vger.kernel.org
Cc: jmorris@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/security/selinux/include/avc.h
linux-2.6.7-new/security/selinux/include/avc.h
--- linux-2.6.7-orig/security/selinux/include/avc.h     2004-06-15 22:19:01.000000000 -0700
+++ linux-2.6.7-new/security/selinux/include/avc.h      2004-07-18 08:55:29.000000000 -0700
@@ -130,7 +130,6 @@
 struct audit_buffer;
 void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av);
 void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass);
-void avc_dump_cache(struct audit_buffer *ab, char *tag);

 /*
  * AVC operations
diff -ru linux-2.6.7-orig/security/selinux/ss/policydb.h
linux-2.6.7-new/security/selinux/ss/policydb.h
--- linux-2.6.7-orig/security/selinux/ss/policydb.h     2004-06-15 22:19:43.000000000 -0700
+++ linux-2.6.7-new/security/selinux/ss/policydb.h      2004-07-18 08:55:15.000000000 -0700
@@ -251,7 +251,6 @@
 extern int policydb_init(struct policydb *p);
 extern int policydb_index_classes(struct policydb *p);
 extern int policydb_index_others(struct policydb *p);
-extern int constraint_expr_destroy(struct constraint_expr *expr);
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern int policydb_context_isvalid(struct policydb *p, struct context *c);
