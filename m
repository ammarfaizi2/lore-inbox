Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVGJUoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVGJUoC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVGJTlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:26844 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261232AbVGJTfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:25 -0400
Date: Sun, 10 Jul 2005 19:35:24 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: sfr@canb.auug.org.au
Subject: [PATCH 16/82] remove linux/version.h from drivers/char/viocons.c
Message-ID: <20050710193524.16.ozXVmL2702.2247.olh@nectarine.suse.de>
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

drivers/char/viocons.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/char/viocons.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/viocons.c
+++ linux-2.6.13-rc2-mm1/drivers/char/viocons.c
@@ -26,7 +26,6 @@
* Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/
#include <linux/config.h>
-#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
#include <linux/errno.h>
