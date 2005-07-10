Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVGJWyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVGJWyR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVGJTir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:38:47 -0400
Received: from mail.suse.de ([195.135.220.2]:16275 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261973AbVGJTgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:09 -0400
Date: Sun, 10 Jul 2005 19:36:04 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk, Scott_Kilau@digi.com
Subject: [PATCH 56/82] remove linux/version.h from drivers/serial/jsm/jsm.h
Message-ID: <20050710193604.56.WPDgOr3762.2247.olh@nectarine.suse.de>
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

drivers/serial/jsm/jsm.h |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/serial/jsm/jsm.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/serial/jsm/jsm.h
+++ linux-2.6.13-rc2-mm1/drivers/serial/jsm/jsm.h
@@ -28,7 +28,6 @@
#define __JSM_DRIVER_H

#include <linux/kernel.h>
-#include <linux/version.h>
#include <linux/types.h>	/* To pick up the varions Linux types */
#include <linux/tty.h>
#include <linux/serial_core.h>
