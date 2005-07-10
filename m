Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVGJWyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVGJWyW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVGJTiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:38:14 -0400
Received: from ns.suse.de ([195.135.220.2]:19347 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262015AbVGJTgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:12 -0400
Date: Sun, 10 Jul 2005 19:36:08 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH 60/82] remove linux/version.h from drivers/video/backlight/lcd.c
Message-ID: <20050710193608.60.qjHodm3869.2247.olh@nectarine.suse.de>
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

drivers/video/backlight/lcd.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/video/backlight/lcd.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/backlight/lcd.c
+++ linux-2.6.13-rc2-mm1/drivers/video/backlight/lcd.c
@@ -5,7 +5,6 @@
*
*/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/device.h>
