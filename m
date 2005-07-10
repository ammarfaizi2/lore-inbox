Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVGJTn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVGJTn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVGJTmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:42:07 -0400
Received: from mx1.suse.de ([195.135.220.2]:13459 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261919AbVGJTgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:02 -0400
Date: Sun, 10 Jul 2005 19:36:01 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk
Subject: [PATCH 53/82] remove linux/version.h from drivers/serial/crisv10.c
Message-ID: <20050710193601.53.fmwjfG3682.2247.olh@nectarine.suse.de>
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

drivers/serial/crisv10.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/serial/crisv10.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/serial/crisv10.c
+++ linux-2.6.13-rc2-mm1/drivers/serial/crisv10.c
@@ -426,7 +426,6 @@
static char *serial_version = "$Revision: 1.25 $";

#include <linux/config.h>
-#include <linux/version.h>

#include <linux/types.h>
#include <linux/errno.h>
