Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVBRXzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVBRXzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVBRXzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:55:16 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:22458 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261572AbVBRXyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:54:51 -0500
Subject: [PATCH] Remove unused get_resource_list() declaration
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 16:54:47 -0700
Message-Id: <1108770887.25491.56.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused get_resource_list() declaration.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== include/linux/ioport.h 1.15 vs edited =====
--- 1.15/include/linux/ioport.h	2004-10-07 20:11:55 -06:00
+++ edited/include/linux/ioport.h	2005-02-15 15:27:49 -07:00
@@ -91,8 +91,6 @@
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
 
-extern int get_resource_list(struct resource *, char *buf, int size);
-
 extern int request_resource(struct resource *root, struct resource *new);
 extern struct resource * ____request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);


