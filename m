Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVGJTyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVGJTyF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVGJTmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:42:05 -0400
Received: from ns1.suse.de ([195.135.220.2]:14995 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261921AbVGJTgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:03 -0400
Date: Sun, 10 Jul 2005 19:36:02 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk
Subject: [PATCH 54/82] remove linux/version.h from drivers/serial/crisv32.c
Message-ID: <20050710193602.54.aYgCdW3708.2247.olh@nectarine.suse.de>
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

drivers/serial/crisv32.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/serial/crisv32.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/serial/crisv32.c
+++ linux-2.6.13-rc2-mm1/drivers/serial/crisv32.c
@@ -198,7 +198,6 @@
static char *serial_version = "$Revision: 1.50 $";

#include <linux/config.h>
-#include <linux/version.h>

#include <linux/types.h>
#include <linux/errno.h>
