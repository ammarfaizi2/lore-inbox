Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVKSUe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVKSUe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVKSUeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:34:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41989 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750808AbVKSUct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:32:49 -0500
Date: Sat, 19 Nov 2005 08:54:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: bcollins@debian.org, scjody@steamballoon.com
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/ieee1394/ieee1394_transactions.c should #include "ieee1394_transactions.h"
Message-ID: <20051119075420.GB16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for 
it's global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/ieee1394_transactions.c.old	2005-11-19 02:29:46.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/ieee1394_transactions.c	2005-11-19 02:30:09.000000000 +0100
@@ -22,6 +22,7 @@
 #include "ieee1394_core.h"
 #include "highlevel.h"
 #include "nodemgr.h"
+#include "ieee1394_transactions.h"
 
 
 #define PREP_ASYNC_HEAD_ADDRESS(tc) \

