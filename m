Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUD1Hnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUD1Hnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 03:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUD1Hnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 03:43:33 -0400
Received: from math.ut.ee ([193.40.5.125]:59377 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264656AbUD1Hnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 03:43:32 -0400
Date: Wed, 28 Apr 2004 10:43:30 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [2.6 PATCH] PPC32: more Carolina IDE
Message-ID: <Pine.GSO.4.44.0404281042150.7699-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PREP_IBM_CAROLINA_IDE_3 was added to C code but not to the headers. The
following patch makes it compile but pease check the constant value - I
only interpolated it :)

===== arch/ppc/platforms/prep_setup.c 1.44 vs edited =====
--- 1.44/arch/ppc/platforms/prep_setup.c	Thu Apr  8 02:02:57 2004
+++ edited/arch/ppc/platforms/prep_setup.c	Wed Apr 28 10:40:33 2004
@@ -134,6 +134,7 @@
 #define PREP_IBM_CAROLINA_IDE_0	0xf0
 #define PREP_IBM_CAROLINA_IDE_1	0xf1
 #define PREP_IBM_CAROLINA_IDE_2	0xf2
+#define PREP_IBM_CAROLINA_IDE_3	0xf3
 /* 7248-43P */
 #define PREP_IBM_CAROLINA_SCSI_0	0xf4
 #define PREP_IBM_CAROLINA_SCSI_1	0xf5

-- 
Meelis Roos (mroos@linux.ee)

