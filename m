Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVGJUSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVGJUSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVGJTll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:58002 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261203AbVGJTfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:19 -0400
Date: Sun, 10 Jul 2005 19:35:19 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/82] remove linux/version.h from drivers/char/mwave/tp3780i.c
Message-ID: <20050710193519.11.qtXEsi2567.2247.olh@nectarine.suse.de>
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

drivers/char/mwave/tp3780i.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/char/mwave/tp3780i.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/mwave/tp3780i.c
+++ linux-2.6.13-rc2-mm1/drivers/char/mwave/tp3780i.c
@@ -46,7 +46,6 @@
*	First release to the public
*/

-#include <linux/version.h>
#include <linux/interrupt.h>
#include <linux/kernel.h>
#include <linux/ptrace.h>
