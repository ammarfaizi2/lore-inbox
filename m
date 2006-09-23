Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWIWUme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWIWUme (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWIWUme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:42:34 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:64974 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1751516AbWIWUmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:42:33 -0400
From: CIJOML <cijoml@volny.cz>
To: linville@tuxdriver.com, linux-kernel@vger.kernel.org
Subject: patch remove hostap debug code from standard compile mode
Date: Sat, 23 Sep 2006 22:42:31 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609232242.31465.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think we don't want have debug messages running hostap drivers in normal 
operations until we have option in menu to select debug mode.

Michal

Please include:

--- linux-2.6.18/drivers/net/wireless/hostap/hostap_config.h.orig       
2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/drivers/net/wireless/hostap/hostap_config.h    2006-09-23 
22:30:50.000000000 +0200
@@ -38,10 +38,10 @@
  */

 /* Do not include debug messages into the driver */
-/* #define PRISM2_NO_DEBUG */
+#define PRISM2_NO_DEBUG

 /* Do not include /proc/net/prism2/wlan#/{registers,debug} */
-/* #define PRISM2_NO_PROCFS_DEBUG */
+#define PRISM2_NO_PROCFS_DEBUG

 /* Do not include station functionality (i.e., allow only Master (Host AP) 
mode
  */
