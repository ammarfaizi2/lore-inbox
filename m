Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVKCQSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVKCQSf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbVKCQSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:18:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51981 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030339AbVKCQSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:18:34 -0500
Date: Thu, 3 Nov 2005 17:18:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/ftape/lowlevel/ftape-buffer.c should #include "../lowlevel/ftape-buffer.h"
Message-ID: <20051103161824.GA23366@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for
it's global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/drivers/char/ftape/lowlevel/ftape-buffer.c.old	2005-11-03 16:40:29.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/char/ftape/lowlevel/ftape-buffer.c	2005-11-03 16:40:59.000000000 +0100
@@ -33,6 +33,7 @@
 #include "../lowlevel/ftape-rw.h"
 #include "../lowlevel/ftape-read.h"
 #include "../lowlevel/ftape-tracing.h"
+#include "../lowlevel/ftape-buffer.h"
 
 /*  DMA'able memory allocation stuff.
  */
