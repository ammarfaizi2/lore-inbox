Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVGJUoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVGJUoA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVGJTlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:19 -0400
Received: from ns.suse.de ([195.135.220.2]:58514 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261219AbVGJTfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:23 -0400
Date: Sun, 10 Jul 2005 19:35:23 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: tpmdd-devel@lists.sourceforge.net
Subject: [PATCH 15/82] remove linux/version.h from drivers/char/tpm/tpm.h
Message-ID: <20050710193523.15.NIFKfj2675.2247.olh@nectarine.suse.de>
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

drivers/char/tpm/tpm.h |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/char/tpm/tpm.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/tpm/tpm.h
+++ linux-2.6.13-rc2-mm1/drivers/char/tpm/tpm.h
@@ -19,7 +19,6 @@
*
*/
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/pci.h>
#include <linux/delay.h>
#include <linux/fs.h>
