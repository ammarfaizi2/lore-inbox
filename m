Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbTHYKQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTHYKQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:16:04 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:65194 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S261557AbTHYKQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:16:01 -0400
To: <akpm@osdl.org>
Subject: [PATCH 2.6.0-test2] Kobject doc precision
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Mon, 25 Aug 2003 12:40:56 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S261557AbTHYKQB/20030825101601Z+189158@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

         Here's an _important_ kobject doc precision patch.

Could you apply ?

Regards,
Fabian

diff -Naur orig/Documentation/kobject.txt edited/Documentation/kobject.txt
--- orig/Documentation/kobject.txt	2003-07-27 16:59:34.000000000 +0000
+++ edited/Documentation/kobject.txt	2003-08-09 21:35:13.000000000 +0000
@@ -245,7 +245,9 @@
   see the sysfs documentation for more information. 
 
 - default_attrs: Default attributes to be exported via sysfs when the
-  object is registered. 
+  object is registered.Note that the last attribute has to be 
+  initialized to NULL ! You can find a complete implementation
+  in drivers/block/genhd.c
 
 
 Instances of struct kobj_type are not registered; only referenced by


___________________________________



