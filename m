Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbTH1Fq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 01:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263744AbTH1Fok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 01:44:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:17320 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263751AbTH1FL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 01:11:59 -0400
Date: Wed, 27 Aug 2003 22:10:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, thomas@winischhofer.net
Subject: [PATCH] sis_fb needs vmalloc.h
Message-Id: <20030827221004.08a1f16a.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Please apply.

patch_name:	sis_vmal.patch
patch_version:	2003-08-27.18:20:54
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	sis_fb: needs vmalloc.h;
product:	Linux
product_versions: 260-test4
maintainer:	thomas@winischhofer.net

diff -Naur ./drivers/video/sis/sis_main.c~sisvmal ./drivers/video/sis/sis_main.c
--- ./drivers/video/sis/sis_main.c~sisvmal	Fri Aug 22 16:57:49 2003
+++ ./drivers/video/sis/sis_main.c	Wed Aug 27 14:13:22 2003
@@ -38,6 +38,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/vmalloc.h>
 #include <linux/vt_kern.h>
 #include <linux/capability.h>
 #include <linux/fs.h>


--
~Randy
