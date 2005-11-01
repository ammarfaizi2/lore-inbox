Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVKAUwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVKAUwf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVKAUwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:52:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20231 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751172AbVKAUwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:52:34 -0500
Date: Tue, 1 Nov 2005 21:52:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: aeb@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/partitions/ultrix.c should #include "ultrix.h"
Message-ID: <20051101205230.GZ8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for
it's global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/fs/partitions/ultrix.c.old	2005-11-01 20:35:29.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/partitions/ultrix.c	2005-11-01 20:35:46.000000000 +0100
@@ -7,6 +7,7 @@
  */
 
 #include "check.h"
+#include "ultrix.h"
 
 int ultrix_partition(struct parsed_partitions *state, struct block_device *bdev)
 {

