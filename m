Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293053AbSCCFUV>; Sun, 3 Mar 2002 00:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310504AbSCCFUM>; Sun, 3 Mar 2002 00:20:12 -0500
Received: from ip68-13-105-13.om.om.cox.net ([68.13.105.13]:43004 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S293053AbSCCFTz>; Sun, 3 Mar 2002 00:19:55 -0500
Date: Sat, 2 Mar 2002 23:18:21 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: Invalid @home email addresses
Message-ID: <Pine.LNX.4.44.0203022258360.21225-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 March 02 cox@home switched their services from infrastructure hosted 
on hardware by Excite to "native" hardware.  All @home.com addresses are 
now invalid.  Grepping through the source for these invalid addresses 
produced the following:

drivers/net/de4x5.c 	mmporter@home.com
drivers/scsi/megaraid.c 	johnsom@home.com
drivers/scsi/ppa.h	johncavan@home.com 
drivers/scsi/imm.h	johncavan@home.com 
drivers/sound/aci.c	pellicci@home.com
drivers/media/video/bttv-cards.c	daniel.herrington@home.com

Most addresses for home.com users simply switched to cox.net addresses.  
However, email to the above users at cox.net bounced in four out of five 
cases.  I am posting here in hopes that theses users are still on the 
mailing list and will respond.  If no response is received I would like to 
submit a patch adding comments to the source code indicating the addresses 
are no longer valid and no new email addresses are known.  

Note:  The above addresses also exist in the 2.5 tree.  I also intend to 
submit a patch for the comments in the 2.5 tree.  Following is a patch to 
correct my email address in the 2.4 tree.  This patch is against 2.4.18.

diff -urN linux.old/CREDITS linux.new/CREDITS
--- linux.old/CREDITS	Sat Mar  2 21:33:52 2002
+++ linux.new/CREDITS	Sat Mar  2 22:51:09 2002
@@ -2113,7 +2113,7 @@
 S: Germany
 
 N: Thomas Molina
-E: tmolina@home.com
+E: tmolina@cox.net
 D: bug fixes, documentation, minor hackery
 
 N: David Mosberger-Tang
diff -urN linux.old/Documentation/sound/PAS16 linux.new/Documentation/sound/PAS16
--- linux.old/Documentation/sound/PAS16	Wed Apr 11 20:02:27 2001
+++ linux.new/Documentation/sound/PAS16	Sat Mar  2 22:52:11 2002
@@ -1,7 +1,7 @@
 Pro Audio Spectrum 16 for 2.3.99 and later
 =========================================
-by Thomas Molina (tmolina@home.com)
-last modified 3 Mar 2001
+by Thomas Molina (tmolina@cox.net)
+last modified 2 Mar 2002
 Acknowledgement to Axel Boldt (boldt@math.ucsb.edu) for stuff taken
 from Configure.help, Riccardo Facchetti for stuff from README.OSS,
 and others whose names I could not find.

