Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUCPOrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbUCPOpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:45:39 -0500
Received: from styx.suse.cz ([82.208.2.94]:31617 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261905AbUCPOT3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:29 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446776531@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 5/44] .ko module names for acm.txt
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <1079446776461@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.5, 2004-01-26 13:23:40+01:00, jochen@jochen.org
  usb: Minor documentation fix reflecting new USB module names in acm.txt


 acm.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

===================================================================

diff -Nru a/Documentation/usb/acm.txt b/Documentation/usb/acm.txt
--- a/Documentation/usb/acm.txt	Tue Mar 16 13:20:01 2004
+++ b/Documentation/usb/acm.txt	Tue Mar 16 13:20:01 2004
@@ -28,7 +28,7 @@
 
 1. Usage
 ~~~~~~~~
-  The drivers/usb/acm.c drivers works with USB modems and USB ISDN terminal
+  The drivers/usb/class/cdc-acm.c drivers works with USB modems and USB ISDN terminal
 adapters that conform to the Universal Serial Bus Communication Device Class
 Abstract Control Model (USB CDC ACM) specification.
 
@@ -65,9 +65,9 @@
 
   To use the modems you need these modules loaded:
 
-	usbcore.o
-	usb-[uo]hci.o or uhci.o
-	acm.o
+	usbcore.ko
+	uhci-hcd.ko ohci-hcd.ko or ehci-hcd.ko
+	cdc-acm.ko
 
   After that, the modem[s] should be accessible. You should be able to use
 minicom, ppp and mgetty with them.

