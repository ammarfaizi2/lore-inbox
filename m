Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWAFQfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWAFQfK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWAFQe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:34:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55051 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752459AbWAFQdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:33:12 -0500
Date: Fri, 6 Jan 2006 17:33:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] spelling: s/usefull/useful/
Message-ID: <20060106163306.GL12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/networking/sk98lin.txt |    2 +-
 Documentation/power/swsusp.txt       |    4 ++--
 Makefile                             |    2 +-
 arch/xtensa/kernel/time.c            |    2 +-
 drivers/media/radio/radio-sf16fmr2.c |    2 +-
 drivers/net/sk98lin/skdim.c          |    2 +-
 drivers/net/sk98lin/skge.c           |    2 +-
 drivers/net/sk98lin/skgepnmi.c       |    8 ++++----
 drivers/w1/Kconfig                   |    2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

--- linux-2.6.15-mm1-full/arch/xtensa/kernel/time.c.old	2006-01-06 16:53:58.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/xtensa/kernel/time.c	2006-01-06 16:54:10.000000000 +0100
@@ -201,7 +201,7 @@
 	if ((signed long)(get_ccount() - next) > 0)
 		goto again;
 
-	/* Allow platform to do something usefull (Wdog). */
+	/* Allow platform to do something useful (Wdog). */
 
 	platform_heartbeat();
 
--- linux-2.6.15-mm1-full/Documentation/networking/sk98lin.txt.old	2006-01-06 16:54:56.000000000 +0100
+++ linux-2.6.15-mm1-full/Documentation/networking/sk98lin.txt	2006-01-06 16:54:59.000000000 +0100
@@ -245,7 +245,7 @@
 This parameters is only relevant if auto-negotiation for this port is 
 not set to "Sense". If auto-negotiation is set to "On", all three values
 are possible. If it is set to "Off", only "Full" and "Half" are allowed.
-This parameter is usefull if your link partner does not support all
+This parameter is useful if your link partner does not support all
 possible combinations.
 
 Flow Control
--- linux-2.6.15-mm1-full/Documentation/power/swsusp.txt.old	2006-01-06 16:55:10.000000000 +0100
+++ linux-2.6.15-mm1-full/Documentation/power/swsusp.txt	2006-01-06 16:55:17.000000000 +0100
@@ -212,7 +212,7 @@
 
 cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null
 
-after resume. swapoff -a; swapon -a may also be usefull.
+after resume. swapoff -a; swapon -a may also be useful.
 
 Q: What happens to devices during swsusp? They seem to be resumed
 during system suspend?
@@ -323,7 +323,7 @@
 A: No, it should work okay, as long as your app does not mlock()
 it. Just prepare big enough swap partition.
 
-Q: What information is usefull for debugging suspend-to-disk problems?
+Q: What information is useful for debugging suspend-to-disk problems?
 
 A: Well, last messages on the screen are always useful. If something
 is broken, it is usually some kernel driver, therefore trying with as
--- linux-2.6.15-mm1-full/drivers/media/radio/radio-sf16fmr2.c.old	2006-01-06 16:55:28.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/media/radio/radio-sf16fmr2.c	2006-01-06 16:55:33.000000000 +0100
@@ -48,7 +48,7 @@
 static int radio_nr = -1;
 
 /* hw precision is 12.5 kHz
- * It is only usefull to give freq in intervall of 200 (=0.0125Mhz),
+ * It is only useful to give freq in intervall of 200 (=0.0125Mhz),
  * other bits will be truncated
  */
 #define RSF16_ENCODE(x)	((x)/200+856)
--- linux-2.6.15-mm1-full/drivers/net/sk98lin/skdim.c.old	2006-01-06 16:55:41.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/net/sk98lin/skdim.c	2006-01-06 16:55:45.000000000 +0100
@@ -180,7 +180,7 @@
                 /*
                 ** The number of interrupts per sec is the same as expected.
                 ** Evalulate the descriptor-ratio. If it has changed, a resize 
-                ** in the moderation timer might be usefull
+                ** in the moderation timer might be useful
                 */
                 if (M_DIMINFO.AutoSizing) {
                     ResizeDimTimerDuration(pAC);
--- linux-2.6.15-mm1-full/drivers/net/sk98lin/skge.c.old	2006-01-06 16:55:53.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/net/sk98lin/skge.c	2006-01-06 16:55:57.000000000 +0100
@@ -2859,7 +2859,7 @@
  * Description:
  *	This function is called if an ioctl is issued on the device.
  *	There are three subfunction for reading, writing and test-writing
- *	the private MIB data structure (usefull for SysKonnect-internal tools).
+ *	the private MIB data structure (useful for SysKonnect-internal tools).
  *
  * Returns:
  *	0, if everything is ok
--- linux-2.6.15-mm1-full/drivers/net/sk98lin/skgepnmi.c.old	2006-01-06 16:56:08.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/net/sk98lin/skgepnmi.c	2006-01-06 16:56:18.000000000 +0100
@@ -607,7 +607,7 @@
  * Description:
  *	Calls a general sub-function for all this stuff. The preset does
  *	the same as a set, but returns just before finally setting the
- *	new value. This is usefull to check if a set might be successfull.
+ *	new value. This is useful to check if a set might be successfull.
  *	If the instance -1 is passed, an array of values is supposed and
  *	all instances of the OID will be set.
  *
@@ -650,7 +650,7 @@
  * Description:
  *	Calls a general sub-function for all this stuff. The preset does
  *	the same as a set, but returns just before finally setting the
- *	new value. This is usefull to check if a set might be successfull.
+ *	new value. This is useful to check if a set might be successfull.
  *	If the instance -1 is passed, an array of values is supposed and
  *	all instances of the OID will be set.
  *
@@ -866,7 +866,7 @@
  * Description:
  *	Calls a general sub-function for all this set stuff. The preset does
  *	the same as a set, but returns just before finally setting the
- *	new value. This is usefull to check if a set might be successfull.
+ *	new value. This is useful to check if a set might be successfull.
  *	The sub-function runs through the IdTable, checks which OIDs are able
  *	to set, and calls the handler function of the OID to perform the
  *	preset. The return value of the function will also be stored in
@@ -6324,7 +6324,7 @@
  *
  * Description:
  *	The COMMON module only tells us if the mode is half or full duplex.
- *	But in the decade of auto sensing it is usefull for the user to
+ *	But in the decade of auto sensing it is useful for the user to
  *	know if the mode was negotiated or forced. Therefore we have a
  *	look to the mode, which was last used by the negotiation process.
  *
--- linux-2.6.15-mm1-full/drivers/w1/Kconfig.old	2006-01-06 16:56:27.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/w1/Kconfig	2006-01-06 16:56:30.000000000 +0100
@@ -3,7 +3,7 @@
 config W1
 	tristate "Dallas's 1-wire support"
 	---help---
-	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices
+	  Dallas's 1-wire bus is useful to connect slow 1-pin devices
 	  such as iButtons and thermal sensors.
 
 	  If you want W1 support, you should say Y here.
--- linux-2.6.15-mm1-full/Makefile.old	2006-01-06 16:56:45.000000000 +0100
+++ linux-2.6.15-mm1-full/Makefile	2006-01-06 16:56:49.000000000 +0100
@@ -251,7 +251,7 @@
 # If it is set to "silent_", nothing wil be printed at all, since
 # the variable $(silent_cmd_cc_o_c) doesn't exist.
 #
-# A simple variant is to prefix commands with $(Q) - that's usefull
+# A simple variant is to prefix commands with $(Q) - that's useful
 # for commands that shall be hidden in non-verbose mode.
 #
 #	$(Q)ln $@ :<

