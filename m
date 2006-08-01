Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751684AbWHARYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWHARYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWHARYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:24:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40609 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751644AbWHARYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:24:14 -0400
Date: Tue, 1 Aug 2006 14:04:17 -0500
From: Brandon Philips <brandon@ifup.org>
To: gregkh@suse.de
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.18-rc3 genhd.c reference in Documentation/kobjects.txt
Message-ID: <20060801190417.GB23303@vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

block/genhd.c no longer in drivers/.  Update Documentation/kobjects.txt

Thanks,
Brandon

Signed-off-by: Brandon Philips <brandon@ifup.org>

Index: linux-rc/Documentation/kobject.txt
===================================================================
--- linux-rc.orig/Documentation/kobject.txt	2006-08-01 13:35:18.000000000 -0500
+++ linux-rc/Documentation/kobject.txt	2006-08-01 13:35:23.000000000 -0500
@@ -247,7 +247,7 @@
 - default_attrs: Default attributes to be exported via sysfs when the
   object is registered.Note that the last attribute has to be
   initialized to NULL ! You can find a complete implementation
-  in drivers/block/genhd.c
+  in block/genhd.c
 
 
 Instances of struct kobj_type are not registered; only referenced by
