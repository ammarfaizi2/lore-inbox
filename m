Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWCTPsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWCTPsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965505AbWCTPsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:48:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37858 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966745AbWCTPUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:20:35 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Uwe Bugla <uwe.bugla@gmx.de>,
       Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 118/141] V4L/DVB (3391): Documentation update
Date: Mon, 20 Mar 2006 12:08:56 -0300
Message-id: <20060320150856.PS764649000118@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Bugla <uwe.bugla@gmx.de>
Date: 1141009774 -0300

Signed-off-by: Uwe Bugla <uwe.bugla@gmx.de>
Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/dvb/avermedia.txt b/Documentation/dvb/avermedia.txt
diff --git a/Documentation/dvb/avermedia.txt b/Documentation/dvb/avermedia.txt
index 068070f..8bab846 100644
--- a/Documentation/dvb/avermedia.txt
+++ b/Documentation/dvb/avermedia.txt
@@ -1,4 +1,3 @@
-
 HOWTO: Get An Avermedia DVB-T working under Linux
 	   ______________________________________________
 
@@ -137,11 +136,8 @@ Getting the card going
    To  power  up  the  card,  load  the  following modules in the
    following order:
 
-     * insmod dvb-core.o
-     * modprobe bttv.o
-     * insmod bt878.o
-     * insmod dvb-bt8xx.o
-     * insmod sp887x.o
+     * modprobe bttv (normally loaded automatically)
+     * modprobe dvb-bt8xx (or place dvb-bt8xx in /etc/modules)
 
    Insertion  of  these  modules  into  the  running  kernel will
    activate the appropriate DVB device nodes. It is then possible
@@ -302,4 +298,4 @@ Further Update
    Many  thanks to Nigel Pearson for the updates to this document
    since the recent revision of the driver.
 
-   January 29th 2004
+   February 14th 2006
diff --git a/Documentation/dvb/readme.txt b/Documentation/dvb/readme.txt
diff --git a/Documentation/dvb/readme.txt b/Documentation/dvb/readme.txt
index f5c50b2..0b0380c 100644
--- a/Documentation/dvb/readme.txt
+++ b/Documentation/dvb/readme.txt
@@ -20,11 +20,23 @@ http://linuxtv.org/downloads/
 
 What's inside this directory:
 
+"avermedia.txt"
+contains detailed information about the
+Avermedia DVB-T cards. See also "bt8xx.txt".
+
+"bt8xx.txt"
+contains detailed information about the
+various bt8xx based "budget" DVB cards.
+
 "cards.txt"
 contains a list of supported hardware.
 
+"ci.txt"
+contains detailed information about the
+CI module as part from TwinHan cards and Clones.
+
 "contributors.txt"
-is the who-is-who of DVB development
+is the who-is-who of DVB development.
 
 "faq.txt"
 contains frequently asked questions and their answers.
@@ -34,19 +46,17 @@ script to download and extract firmware 
 that require it.
 
 "ttusb-dec.txt"
-contains detailed informations about the
+contains detailed information about the
 TT DEC2000/DEC3000 USB DVB hardware.
 
-"bt8xx.txt"
-contains detailed installation instructions for the
-various bt8xx based "budget" DVB cards
-(Nebula, Pinnacle PCTV, Twinhan DST)
-
-"README.dibusb"
-contains detailed information about adapters
-based on DiBcom reference design.
-
 "udev.txt"
 how to get DVB and udev up and running.
 
+"README.dvb-usb"
+contains detailed information about the DVB USB cards.
+
+"README.flexcop"
+contains detailed information about the
+Technisat- and Flexcop B2C2 drivers.
+
 Good luck and have fun!

