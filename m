Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263721AbTH1Fo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 01:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTH1Fo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 01:44:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:22181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263721AbTH1FFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 01:05:25 -0400
Date: Wed, 27 Aug 2003 22:03:29 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Subject: [PATCH] zoran needs vmalloc.h
Message-Id: <20030827220329.345557d1.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Please apply.

patch_name:	zoran_vmal.patch
patch_version:	2003-08-27.18:17:24
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	zoran needs vmalloc.h;
product:	Linux
product_versions: 260-test4
maintainer:	??

diff -Naur ./drivers/media/video/zoran_driver.c~zoranvmal ./drivers/media/video/zoran_driver.c
--- ./drivers/media/video/zoran_driver.c~zoranvmal	Fri Aug 22 16:58:12 2003
+++ ./drivers/media/video/zoran_driver.c	Wed Aug 27 10:12:13 2003
@@ -51,7 +51,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
-
+#include <linux/vmalloc.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>


--
~Randy
