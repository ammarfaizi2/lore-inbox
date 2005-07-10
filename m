Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVGJVSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVGJVSY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVGJTjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:53 -0400
Received: from mail.suse.de ([195.135.220.2]:403 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261671AbVGJTfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:36 -0400
Date: Sun, 10 Jul 2005 19:35:36 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com
Subject: [PATCH 28/82] remove linux/version.h from drivers/s390/net/claw.c
Message-ID: <20050710193536.28.UysRgL3018.2247.olh@nectarine.suse.de>
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

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/s390/net/claw.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/s390/net/claw.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/s390/net/claw.c
+++ linux-2.6.13-rc2-mm1/drivers/s390/net/claw.c
@@ -88,7 +88,6 @@
#include <linux/tcp.h>
#include <linux/timer.h>
#include <linux/types.h>
-#include <linux/version.h>

#include "cu3088.h"
#include "claw.h"
