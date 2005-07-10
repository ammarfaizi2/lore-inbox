Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVGJThN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVGJThN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVGJTgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:36:49 -0400
Received: from ns1.suse.de ([195.135.220.2]:25235 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262033AbVGJTgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:22 -0400
Date: Sun, 10 Jul 2005 19:36:22 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 74/82] remove linux/version.h from include/linux/serialP.h
Message-ID: <20050710193622.74.KyCDdU4235.2247.olh@nectarine.suse.de>
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

include/linux/serialP.h |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/include/linux/serialP.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/linux/serialP.h
+++ linux-2.6.13-rc2-mm1/include/linux/serialP.h
@@ -19,7 +19,6 @@
* For definitions of the flags field, see tty.h
*/

-#include <linux/version.h>
#include <linux/config.h>
#include <linux/termios.h>
#include <linux/workqueue.h>
