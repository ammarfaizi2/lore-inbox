Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUF3T4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUF3T4t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUF3T4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:56:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:53172 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261724AbUF3T4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:56:40 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 1/4: DM: kcopyd.c: Remove unused include
Date: Wed, 30 Jun 2004 14:57:29 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200406301452.16886.kevcorry@us.ibm.com>
In-Reply-To: <200406301452.16886.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406301457.29695.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kcopyd.c: Remove unused #include.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/kcopyd.c	2004-06-30 08:45:34.513303448 -0500
+++ source/drivers/md/kcopyd.c	2004-06-30 08:48:15.384847256 -0500
@@ -24,9 +24,6 @@
 
 #include "kcopyd.h"
 
-/* FIXME: this is only needed for the DMERR macros */
-#include "dm.h"
-
 static struct workqueue_struct *_kcopyd_wq;
 static struct work_struct _kcopyd_work;
 
