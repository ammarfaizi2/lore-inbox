Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWDDAAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWDDAAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWDDAAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 20:00:11 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:26807 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964894AbWDCX7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:38 -0400
Date: Tue, 4 Apr 2006 02:00:25 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/13] isdn4linux: Siemens Gigaset drivers - Kconfig correction
Message-ID: <gigaset307x.2006.04.04.001.2@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch removes the restriction to build the Gigaset drivers as
modules only. Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/Kconfig |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/Kconfig	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-kconfig/drivers/isdn/gigaset/Kconfig	2006-04-02 18:37:42.000000000 +0200
@@ -3,8 +3,7 @@ menu "Siemens Gigaset"
 
 config ISDN_DRV_GIGASET
 	tristate "Siemens Gigaset support (isdn)"
-	depends on ISDN_I4L && m
-#	depends on ISDN_I4L && MODULES
+	depends on ISDN_I4L && CRC_CCITT
 	help
 	  Say m here if you have a Gigaset or Sinus isdn device.
 
