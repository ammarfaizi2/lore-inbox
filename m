Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWJEEVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWJEEVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWJEEVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:21:09 -0400
Received: from qb-out-0506.google.com ([72.14.204.232]:34917 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750784AbWJEEVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:21:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=SQEIryT4VWAP0yB9gJuAUNvETfkdebLSn0ReUAln/Izt6lgXG51gwFIOfpyPEokoxgVNEQ/ZEYi/3CT7HYZd7m2MI4KU9iZ+F/x2M0HoT9cRVEo+6sMLx3Xq+XO+eFndU276ge+2pnFQ6rzaOuzJ499FDwoCKKhEx3MgHz2AhWQ=
Message-ID: <45248867.40903@gmail.com>
Date: Wed, 04 Oct 2006 22:21:59 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Christer Weinigel <christer@weinigel.se>
Subject: [patch 2.6.18+] MAINTAINERS - take over scx200-* and pc8736* drivers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add MAINTAINERS entries for new scx200_hrt and pc8736x_gpio drivers, and 
take over maintenance
of scx200_gpio, authored by Christer Weinigel (which Ive hacked at), who 
no longer has the hardware.
Also take over hwmon/pc87360, authored by Jean Delvare, who's dropped 
maintenance to dedicate
more time to hwmon subsystem.

Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
---

Christer acked this off-list already, in case he's too busy and misses 
this one.

 MAINTAINERS                         |   41 
++++++++++++++++++++++++++++--------



diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.18-rc6-mm2-sk/MAINTAINERS doc-touches/MAINTAINERS
--- linux-2.6.18-rc6-mm2-sk/MAINTAINERS	2006-09-12 09:39:29.000000000 -0600
+++ doc-touches/MAINTAINERS	2006-10-04 22:03:09.000000000 -0600
@@ -2151,6 +2151,11 @@ M:	emoenke@gwdg.de
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+NSC_GPIO Common Methods Module (supports PC8736x_GPIO and SCX200_GPIO Drivers)
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+S:	Maintained
+
 NTFS FILESYSTEM
 P:	Anton Altaparmakov
 M:	aia21@cantab.net
@@ -2262,6 +2267,17 @@ T:	git kernel.org:/pub/scm/linux/kernel/
 T:	cvs cvs.parisc-linux.org:/var/cvs/linux-2.6
 S:	Maintained
 
+PC87360 LM-SENSORS DRIVER
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+
+PC8736x GPIO Driver
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+S:	Maintained
+
 PCI ERROR RECOVERY
 P:	Linas Vepstas
 M:	linas@austin.ibm.com
@@ -2574,16 +2590,25 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
 SCTP PROTOCOL
-P: Sridhar Samudrala
-M: sri@us.ibm.com
-L: lksctp-developers@lists.sourceforge.net
-S: Supported
+P:	Sridhar Samudrala
+M:	sri@us.ibm.com
+L:	lksctp-developers@lists.sourceforge.net
+S:	Supported
 
 SCx200 CPU SUPPORT
-P:	Christer Weinigel
-M:	christer@weinigel.se
-W:	http://www.weinigel.se
-S:	Supported
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+S:	Odd Fixes
+
+SCx200 GPIO DRIVER
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+S:	Maintained
+
+SCx200 HRT CLOCKSOURCE DRIVER
+P:	Jim Cromie
+M:	jim.cromie@gmail.com
+S:	Maintained
 
 SECURITY CONTACT
 P:	Security Officers


