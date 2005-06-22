Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVFVHWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVFVHWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbVFVHVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:21:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:61595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262773AbVFVFVv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:51 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Sensors mailing list has moved
In-Reply-To: <11194174662120@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:46 -0700
Message-Id: <11194174662573@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Sensors mailing list has moved

The following patch updates all references to the sensors mailing list,
so as to reflect the fact that the list recently moved to a new home and
changed addresses. I'll work out a similar patch for Linux 2.4 soon.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit cc0b07ed479fd92806aef7d6dbc58b6dc6da3796
tree d704525bd37b168e9cf61b7464fe4423b6c46b48
parent 7f02d56e54f2a8afaa01974df650ace9dc15d0cd
author Jean Delvare <khali@linux-fr.org> Sun, 22 May 2005 09:39:11 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:01 -0700

 Documentation/i2c/busses/i2c-sis69x |    2 +-
 Documentation/i2c/porting-clients   |    2 +-
 MAINTAINERS                         |   16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-sis69x b/Documentation/i2c/busses/i2c-sis69x
--- a/Documentation/i2c/busses/i2c-sis69x
+++ b/Documentation/i2c/busses/i2c-sis69x
@@ -42,7 +42,7 @@ I suspect that this driver could be made
 chipsets as well: 635, and 635T. If anyone owns a board with those chips
 AND is willing to risk crashing & burning an otherwise well-behaved kernel
 in the name of progress... please contact me at <mhoffman@lightlink.com> or
-via the project's mailing list: <sensors@stimpy.netroedge.com>.  Please
+via the project's mailing list: <lm-sensors@lm-sensors.org>.  Please
 send bug reports and/or success stories as well.
 
 
diff --git a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients
+++ b/Documentation/i2c/porting-clients
@@ -57,7 +57,7 @@ Technical changes:
   Documentation/i2c/sysfs-interface for the individual files. Also
   convert the units these files read and write to the specified ones.
   If you need to add a new type of file, please discuss it on the
-  sensors mailing list <sensors@stimpy.netroedge.com> by providing a
+  sensors mailing list <lm-sensors@lm-sensors.org> by providing a
   patch to the Documentation/i2c/sysfs-interface file.
 
 * [Attach] For I2C drivers, the attach function should make sure
diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -194,7 +194,7 @@ S:	Maintained
 ADM1025 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 ADT746X FAN DRIVER
@@ -242,7 +242,7 @@ S:	Maintained
 ALI1563 I2C DRIVER
 P:	Rudolf Marek
 M:	r.marek@sh.cvut.cz
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 ALPHA PORT
@@ -1002,7 +1002,7 @@ P:	Greg Kroah-Hartman
 M:	greg@kroah.com
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.nu/
 S:	Maintained
 
@@ -1430,13 +1430,13 @@ S:	Supported
 LM83 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 LM90 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP Dynamic Disks)
@@ -2075,7 +2075,7 @@ S:	Maintained
 SMSC47M1 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Odd Fixes
 
 SMB FILESYSTEM
@@ -2614,7 +2614,7 @@ S:	Orphan
 W1 DALLAS'S 1-WIRE BUS
 P:	Evgeniy Polyakov
 M:	johnpol@2ka.mipt.ru
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 W83L51xD SD/MMC CARD INTERFACE DRIVER
@@ -2627,7 +2627,7 @@ S:	Maintained
 W83L785TS HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Odd Fixes
 
 WAN ROUTER & SANGOMA WANPIPE DRIVERS & API (X.25, FRAME RELAY, PPP, CISCO HDLC)

