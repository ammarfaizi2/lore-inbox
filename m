Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVGJUSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVGJUSo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVGJTlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:25052 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261210AbVGJTfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:23 -0400
Date: Sun, 10 Jul 2005 19:35:22 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: R.E.Wolff@BitWizard.nl
Subject: [PATCH 14/82] remove linux/version.h from drivers/char/specialix.c
Message-ID: <20050710193522.14.xbpQRz2647.2247.olh@nectarine.suse.de>
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

drivers/char/specialix.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/char/specialix.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/specialix.c
+++ linux-2.6.13-rc2-mm1/drivers/char/specialix.c
@@ -90,7 +90,6 @@
#include <linux/fcntl.h>
#include <linux/major.h>
#include <linux/delay.h>
-#include <linux/version.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <asm/uaccess.h>
