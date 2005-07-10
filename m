Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVGJWyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVGJWyR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVGJThh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:37:37 -0400
Received: from mx1.suse.de ([195.135.220.2]:28051 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262042AbVGJTge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:34 -0400
Date: Sun, 10 Jul 2005 19:36:30 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: vandrove@vc.cvut.cz
Subject: [PATCH 82/82] remove linux/version.h from drivers/video/matrox/matroxfb_base.c
Message-ID: <20050710193630.82.QRNJQz4450.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

get KERNEL_VERSION from linux/utsname.h

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/video/matrox/matroxfb_base.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/video/matrox/matroxfb_base.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/matrox/matroxfb_base.c
+++ linux-2.6.13-rc2-mm1/drivers/video/matrox/matroxfb_base.c
@@ -101,7 +101,7 @@

/* make checkconfig does not check included files... */
#include <linux/config.h>
-#include <linux/version.h>
+#include <linux/utsname.h>

#include "matroxfb_base.h"
#include "matroxfb_misc.h"
