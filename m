Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVGJVBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVGJVBq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVGJTko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:40:44 -0400
Received: from ns2.suse.de ([195.135.220.15]:30428 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261272AbVGJTfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:31 -0400
Date: Sun, 10 Jul 2005 19:35:26 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: openib-general@openib.org, rolandd@cisco.com
Subject: [PATCH 18/82] remove linux/version.h from drivers/infiniband/
Message-ID: <20050710193526.18.UYMiOz2756.2247.olh@nectarine.suse.de>
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

drivers/infiniband/core/cache.c           |    1 -
drivers/infiniband/hw/mthca/mthca_main.c  |    1 -
drivers/infiniband/ulp/ipoib/ipoib_main.c |    1 -
drivers/infiniband/ulp/ipoib/ipoib_vlan.c |    1 -
4 files changed, 4 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/infiniband/core/cache.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/infiniband/core/cache.c
+++ linux-2.6.13-rc2-mm1/drivers/infiniband/core/cache.c
@@ -32,7 +32,6 @@
* $Id: cache.c 1349 2004-12-16 21:09:43Z roland $
*/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/drivers/infiniband/hw/mthca/mthca_main.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/infiniband/hw/mthca/mthca_main.c
+++ linux-2.6.13-rc2-mm1/drivers/infiniband/hw/mthca/mthca_main.c
@@ -34,7 +34,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/errno.h>
Index: linux-2.6.13-rc2-mm1/drivers/infiniband/ulp/ipoib/ipoib_main.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ linux-2.6.13-rc2-mm1/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -34,7 +34,6 @@

#include "ipoib.h"

-#include <linux/version.h>
#include <linux/module.h>

#include <linux/init.h>
Index: linux-2.6.13-rc2-mm1/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ linux-2.6.13-rc2-mm1/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -32,7 +32,6 @@
* $Id: ipoib_vlan.c 1349 2004-12-16 21:09:43Z roland $
*/

-#include <linux/version.h>
#include <linux/module.h>

#include <linux/init.h>
