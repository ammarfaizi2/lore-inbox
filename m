Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVGJTyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVGJTyF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVGJTmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:42:02 -0400
Received: from ns2.suse.de ([195.135.220.15]:48092 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261932AbVGJTgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:04 -0400
Date: Sun, 10 Jul 2005 19:36:03 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk, Michael Anderson <mjanders@us.ibm.com>
Subject: [PATCH 55/82] remove linux/version.h from drivers/serial/icom.c
Message-ID: <20050710193603.55.XRHGXL3736.2247.olh@nectarine.suse.de>
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

drivers/serial/icom.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/serial/icom.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/serial/icom.c
+++ linux-2.6.13-rc2-mm1/drivers/serial/icom.c
@@ -25,7 +25,6 @@
#define SERIAL_DO_RESTART
#include <linux/module.h>
#include <linux/config.h>
-#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/signal.h>
