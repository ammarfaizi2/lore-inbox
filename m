Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTKHQ5r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 11:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTKHQ5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 11:57:47 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:26884 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261831AbTKHQ5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 11:57:45 -0500
Date: Sat, 8 Nov 2003 17:08:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: [PATCH 2.4] Update I2C maintainers entry
Message-Id: <20031108170830.4b493a4a.khali@linux-fr.org>
Reply-To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo, hi all,

Below is a patch to MAINTAINERS that updates the I2C DRIVERS entry. I
volunteered to become the main contact for that subsystem in Linux 2.4,
since both Simon Vogl and Frodo Looijaard have left the project by now.
Greg KH will continue to take care of the i2c subsystem in Linux 2.6.
Relevant threads on the LM Sensors mailing list, that show the
legitimacy of the change, are:
  http://archives.andrew.net.au/lm-sensors/msg02456.html
  http://archives.andrew.net.au/lm-sensors/msg04585.html

This also makes the entry more in line with the one in Linux 2.6 (same
entry name, same mailing-list, same web site).

Please apply.

--- linux-2.4.23-pre9/MAINTAINERS.orig	Sat Nov  8 14:46:45 2003
+++ linux-2.4.23-pre9/MAINTAINERS	Sat Nov  8 16:04:30 2003
@@ -808,13 +808,11 @@
 W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
 S:	Maintained
 
-I2C DRIVERS
-P:	Simon Vogl
-M:	simon@tk.uni-linz.ac.at
-P:	Frodo Looijaard
-M:	frodol@dds.nl
-L:	linux-i2c@pelican.tk.uni-linz.ac.at
-W:	http://www.tk.uni-linz.ac.at/~simon/private/i2c
+I2C AND SENSORS DRIVERS
+P:	Jean Delvare
+M:	khali@linux-fr.org
+L:	sensors@stimpy.netroedge.com
+W:	http://www.lm-sensors.nu/
 S:	Maintained
 
 i386 BOOT CODE

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
