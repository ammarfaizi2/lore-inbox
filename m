Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbTIDGqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264741AbTIDGqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:46:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:15491 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264737AbTIDGqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:46:12 -0400
Date: Wed, 3 Sep 2003 23:44:05 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: jmorris@intercode.com.au, davem@redhat.com
Subject: [PATCH] [crypto] remove duplicate #include
Message-Id: <20030903234405.01b61dad.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Please apply to 2.6.0-current.

--
~Randy


patch_name:	crypto_incdups.patch
patch_version:	2003-09-03.22:37:00
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	remove duplicate #includes in crypto/
product:	Linux
product_versions: 2.6.0-test4
maintainer:	jmorris@intercode.com.au, davem@redhat.com
diffstat:	=
 crypto/tcrypt.c |    1 -
 1 files changed, 1 deletion(-)

diff -Naurp ./crypto/tcrypt.c~incdups ./crypto/tcrypt.c
--- ./crypto/tcrypt.c~incdups	2003-09-03 16:34:34.000000000 -0700
+++ ./crypto/tcrypt.c	2003-09-03 17:29:54.000000000 -0700
@@ -15,7 +15,6 @@
  */
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <asm/scatterlist.h>
