Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVGJTkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVGJTkd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVGJTj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34012 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261652AbVGJTfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:36 -0400
Date: Sun, 10 Jul 2005 19:35:35 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 27/82] remove linux/version.h from drivers/pcmcia/
Message-ID: <20050710193535.27.GrUbuI2992.2247.olh@nectarine.suse.de>
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

drivers/pcmcia/au1000_pb1x00.c  |    1 -
drivers/pcmcia/au1000_xxs1500.c |    1 -
2 files changed, 2 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/pcmcia/au1000_pb1x00.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/pcmcia/au1000_pb1x00.c
+++ linux-2.6.13-rc2-mm1/drivers/pcmcia/au1000_pb1x00.c
@@ -30,7 +30,6 @@
#include <linux/timer.h>
#include <linux/mm.h>
#include <linux/proc_fs.h>
-#include <linux/version.h>
#include <linux/types.h>

#include <pcmcia/cs_types.h>
Index: linux-2.6.13-rc2-mm1/drivers/pcmcia/au1000_xxs1500.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/pcmcia/au1000_xxs1500.c
+++ linux-2.6.13-rc2-mm1/drivers/pcmcia/au1000_xxs1500.c
@@ -35,7 +35,6 @@
#include <linux/timer.h>
#include <linux/mm.h>
#include <linux/proc_fs.h>
-#include <linux/version.h>
#include <linux/types.h>

#include <pcmcia/cs_types.h>
