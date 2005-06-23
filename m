Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVFWH6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVFWH6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbVFWH4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:56:41 -0400
Received: from [24.22.56.4] ([24.22.56.4]:12774 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262257AbVFWGSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:41 -0400
Message-Id: <20050623061800.660072000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:24 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 32/38] CKRM e18: Include taskdelays.h in crbce.h
Content-Disposition: inline; filename=ckrm-inc-taskdelay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include taskdelays.h in crbce.h

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

---------------------------------------------------------------------

Index: linux-2.6.12-ckrm1/include/linux/crbce.h
===================================================================
--- linux-2.6.12-ckrm1.orig/include/linux/crbce.h	2005-06-20 13:08:48.000000000 -0700
+++ linux-2.6.12-ckrm1/include/linux/crbce.h	2005-06-20 15:37:54.000000000 -0700
@@ -35,6 +35,7 @@
 #include <linux/types.h>
 #include <linux/ckrm_events.h>
 #include <linux/ckrm_ce.h>
+#include <linux/taskdelays.h>
 
 #define CRBCE_MAX_CLASS_NAME_LEN  256
 

--
