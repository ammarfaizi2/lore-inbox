Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbULAASX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbULAASX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbULAARU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:17:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:41700 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261228AbULAAOU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:20 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
In-Reply-To: <11018600183171@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Nov 2004 16:13:39 -0800
Message-Id: <11018600193699@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.3, 2004/11/24 14:24:57-08:00, johnpol@2ka.mipt.ru

[PATCH] w1: make W1_DS9490_BRIDGE available

W1_DS9490R_BRIDGE kconfig typo.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/w1/Kconfig b/drivers/w1/Kconfig
--- a/drivers/w1/Kconfig	2004-11-30 16:01:16 -08:00
+++ b/drivers/w1/Kconfig	2004-11-30 16:01:16 -08:00
@@ -30,7 +30,7 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called ds9490r.ko.
 
-config W1_DS9490R_BRIDGE
+config W1_DS9490_BRIDGE
 	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
 	depends on W1_DS9490
 	help

