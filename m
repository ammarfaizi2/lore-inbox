Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVAJFvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVAJFvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVAJFr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:47:28 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:29956
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262108AbVAJFOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:40 -0500
Message-Id: <200501100736.j0A7a5PW005845@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 23/28] UML - Add a missing include
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:36:05 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/drivers/mmapper_kern.c
===================================================================
--- 2.6.10.orig/arch/um/drivers/mmapper_kern.c	2005-01-04 11:12:17.000000000 -0500
+++ 2.6.10/arch/um/drivers/mmapper_kern.c	2005-01-09 15:19:34.000000000 -0500
@@ -8,6 +8,8 @@
  *         Greg Lonnon glonnon@ridgerun.com or info@ridgerun.com
  *
  */
+
+#include <linux/types.h>
 #include <linux/kdev_t.h>
 #include <linux/time.h>
 #include <linux/devfs_fs_kernel.h>

