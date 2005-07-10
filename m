Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVGJX7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVGJX7r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 19:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVGJThL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:37:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:54748 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262038AbVGJTg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:27 -0400
Date: Sun, 10 Jul 2005 19:36:26 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com
Subject: [PATCH 78/82] remove linux/version.h from net/ieee80211/
Message-ID: <20050710193626.78.eBhnWL4343.2247.olh@nectarine.suse.de>
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

net/ieee80211/ieee80211_crypt.c      |    1 -
net/ieee80211/ieee80211_crypt_ccmp.c |    1 -
net/ieee80211/ieee80211_crypt_tkip.c |    1 -
net/ieee80211/ieee80211_crypt_wep.c  |    1 -
net/ieee80211/ieee80211_module.c     |    1 -
net/ieee80211/ieee80211_rx.c         |    1 -
net/ieee80211/ieee80211_tx.c         |    1 -
net/ieee80211/ieee80211_wx.c         |    1 -
8 files changed, 8 deletions(-)

Index: linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_crypt.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/net/ieee80211/ieee80211_crypt.c
+++ linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_crypt.c
@@ -12,7 +12,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_crypt_ccmp.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/net/ieee80211/ieee80211_crypt_ccmp.c
+++ linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_crypt_ccmp.c
@@ -10,7 +10,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_crypt_tkip.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/net/ieee80211/ieee80211_crypt_tkip.c
+++ linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_crypt_tkip.c
@@ -10,7 +10,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_crypt_wep.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/net/ieee80211/ieee80211_crypt_wep.c
+++ linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_crypt_wep.c
@@ -10,7 +10,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_module.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/net/ieee80211/ieee80211_module.c
+++ linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_module.c
@@ -46,7 +46,6 @@
#include <linux/slab.h>
#include <linux/tcp.h>
#include <linux/types.h>
-#include <linux/version.h>
#include <linux/wireless.h>
#include <linux/etherdevice.h>
#include <asm/uaccess.h>
Index: linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_rx.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/net/ieee80211/ieee80211_rx.c
+++ linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_rx.c
@@ -29,7 +29,6 @@
#include <linux/slab.h>
#include <linux/tcp.h>
#include <linux/types.h>
-#include <linux/version.h>
#include <linux/wireless.h>
#include <linux/etherdevice.h>
#include <asm/uaccess.h>
Index: linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_tx.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/net/ieee80211/ieee80211_tx.c
+++ linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_tx.c
@@ -39,7 +39,6 @@
#include <linux/slab.h>
#include <linux/tcp.h>
#include <linux/types.h>
-#include <linux/version.h>
#include <linux/wireless.h>
#include <linux/etherdevice.h>
#include <asm/uaccess.h>
Index: linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_wx.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/net/ieee80211/ieee80211_wx.c
+++ linux-2.6.13-rc2-mm1/net/ieee80211/ieee80211_wx.c
@@ -30,7 +30,6 @@

******************************************************************************/
#include <linux/wireless.h>
-#include <linux/version.h>
#include <linux/kmod.h>
#include <linux/module.h>

