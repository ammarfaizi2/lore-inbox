Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVIGBse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVIGBse (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 21:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVIGBse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 21:48:34 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:62920
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1751159AbVIGBsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 21:48:33 -0400
Subject: [PATCH Linus Git] README.ipw2200 does not contain firmware
	information.
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: ipw2200-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: jketreno@linux.intel.com, Linus Torvalds <torvalds@osdl.org>
Content-Type: multipart/mixed; boundary="=-8DrBDELEAfZ2VD7VNBsn"
Date: Tue, 06 Sep 2005 19:48:37 -0600
Message-Id: <1126057717.5165.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8DrBDELEAfZ2VD7VNBsn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

	The kconfig from net/wireless says to look at the README.ipw2200 for
further installation of the firmware file. We have that information unde
INSTALL not under README.ipw2200, still I just added a part that talks
about installing the firmware file. This because README.ipw2200 is
already in the Documentation/networking/.

I'm still spamming everyone cause I have not been told where to send
this directly. :-)

Signed-off-by: Alejandro Bonilla <abonilla@linuxwireless.org>

Pasted and attached.

debian:~/linux-2.6# diff -usr Documentation/networking/README.ipw2200~
Documentation/networking/README.ipw2200

--- Documentation/networking/README.ipw2200~    2005-09-06
19:33:24.000000000 -0600
+++ Documentation/networking/README.ipw2200     2005-09-06
19:33:24.000000000 -0600
@@ -27,7 +27,8 @@
 1.4. Sysfs Helper Files
 2.   About the Version Numbers
 3.   Support
-4.   License
+4.   Firmware installation
+5.   License
 
 
 1.   Introduction
@@ -272,7 +273,18 @@
     http://ipw2200.sf.net/
 
 
-4.  License
+4.  Firmware installation
+----------------------------------------------
+
+The driver requires a firmware image, download it and extract the files
+under /lib/firmware
+
+The firmware can be downloaded from the following URL:
+
+    http://ipw2200.sf.net/
+
+
+5.  License
 -----------------------------------------------
 
   Copyright(c) 2003 - 2005 Intel Corporation. All rights reserved.


--=-8DrBDELEAfZ2VD7VNBsn
Content-Disposition: attachment; filename=IPW2200-README-git.patch
Content-Type: text/x-patch; name=IPW2200-README-git.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- Documentation/networking/README.ipw2200~	2005-09-06 19:33:24.000000000 -0600
+++ Documentation/networking/README.ipw2200	2005-09-06 19:33:24.000000000 -0600
@@ -27,7 +27,8 @@
 1.4. Sysfs Helper Files
 2.   About the Version Numbers
 3.   Support
-4.   License
+4.   Firmware installation
+5.   License
 
 
 1.   Introduction
@@ -272,7 +273,18 @@
     http://ipw2200.sf.net/
 
 
-4.  License
+4.  Firmware installation
+----------------------------------------------
+
+The driver requires a firmware image, download it and extract the files
+under /lib/firmware
+
+The firmware can be downloaded from the following URL:
+
+    http://ipw2200.sf.net/
+
+
+5.  License
 -----------------------------------------------
 
   Copyright(c) 2003 - 2005 Intel Corporation. All rights reserved.

--=-8DrBDELEAfZ2VD7VNBsn--

