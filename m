Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVGJTyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVGJTyG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVGJTmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:42:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:48860 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261944AbVGJTgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:06 -0400
Date: Sun, 10 Jul 2005 19:36:05 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 57/82] remove linux/version.h from drivers/telephony/ixj.h
Message-ID: <20050710193605.57.jawCNc3788.2247.olh@nectarine.suse.de>
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

drivers/telephony/ixj.h |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/telephony/ixj.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/telephony/ixj.h
+++ linux-2.6.13-rc2-mm1/drivers/telephony/ixj.h
@@ -40,7 +40,6 @@
*****************************************************************************/
#define IXJ_VERSION 3031

-#include <linux/version.h>
#include <linux/types.h>

#include <linux/ixjuser.h>
