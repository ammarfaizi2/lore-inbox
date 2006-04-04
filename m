Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWDDQ3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWDDQ3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWDDQ3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:29:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62733 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750714AbWDDQ3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:29:08 -0400
Date: Tue, 4 Apr 2006 18:29:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove the bouncing email address of David Campbell
Message-ID: <20060404162906.GI6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a bouncing email address from the kernel sources.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/scsi/ppa.txt    |    2 --
 drivers/parport/parport_gsc.c |    2 +-
 drivers/parport/parport_gsc.h |    2 +-
 drivers/parport/parport_pc.c  |    2 +-
 drivers/parport/procfs.c      |    2 +-
 drivers/scsi/imm.c            |    3 ---
 drivers/scsi/imm.h            |    2 +-
 drivers/scsi/ppa.c            |    2 --
 drivers/scsi/ppa.h            |    2 +-
 9 files changed, 6 insertions(+), 13 deletions(-)

--- linux-2.6.16-mm2-full/Documentation/scsi/ppa.txt.old	2006-04-04 11:58:38.000000000 +0200
+++ linux-2.6.16-mm2-full/Documentation/scsi/ppa.txt	2006-04-04 11:59:10.000000000 +0200
@@ -12,5 +12,3 @@
 Email list for Linux Parport
 linux-parport@torque.net
 
-Email for problems with ZIP or ZIP Plus drivers
-campbell@torque.net
--- linux-2.6.16-mm2-full/drivers/parport/parport_gsc.c.old	2006-04-04 11:59:19.000000000 +0200
+++ linux-2.6.16-mm2-full/drivers/parport/parport_gsc.c	2006-04-04 11:59:25.000000000 +0200
@@ -15,7 +15,7 @@
  * 	    Phil Blundell <philb@gnu.org>
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *	    Jose Renau <renau@acm.org>
- *          David Campbell <campbell@torque.net>
+ *          David Campbell
  *          Andrea Arcangeli
  */
 
--- linux-2.6.16-mm2-full/drivers/parport/parport_gsc.h.old	2006-04-04 11:59:33.000000000 +0200
+++ linux-2.6.16-mm2-full/drivers/parport/parport_gsc.h	2006-04-04 11:59:38.000000000 +0200
@@ -24,7 +24,7 @@
  * 	    Phil Blundell <Philip.Blundell@pobox.com>
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *	    Jose Renau <renau@acm.org>
- *          David Campbell <campbell@torque.net>
+ *          David Campbell
  *          Andrea Arcangeli
  */
 
--- linux-2.6.16-mm2-full/drivers/parport/parport_pc.c.old	2006-04-04 11:59:46.000000000 +0200
+++ linux-2.6.16-mm2-full/drivers/parport/parport_pc.c	2006-04-04 11:59:55.000000000 +0200
@@ -3,7 +3,7 @@
  * Authors: Phil Blundell <philb@gnu.org>
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *	    Jose Renau <renau@acm.org>
- *          David Campbell <campbell@torque.net>
+ *          David Campbell
  *          Andrea Arcangeli
  *
  * based on work by Grant Guenther <grant@torque.net> and Phil Blundell.
--- linux-2.6.16-mm2-full/drivers/parport/procfs.c.old	2006-04-04 12:00:03.000000000 +0200
+++ linux-2.6.16-mm2-full/drivers/parport/procfs.c	2006-04-04 12:00:08.000000000 +0200
@@ -1,6 +1,6 @@
 /* Sysctl interface for parport devices.
  * 
- * Authors: David Campbell <campbell@torque.net>
+ * Authors: David Campbell
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *          Philip Blundell <philb@gnu.org>
  *          Andrea Arcangeli
--- linux-2.6.16-mm2-full/drivers/scsi/imm.c.old	2006-04-04 12:00:16.000000000 +0200
+++ linux-2.6.16-mm2-full/drivers/scsi/imm.c	2006-04-04 12:00:38.000000000 +0200
@@ -3,9 +3,6 @@
  * 
  * (The IMM is the embedded controller in the ZIP Plus drive.)
  * 
- * Current Maintainer: David Campbell (Perth, Western Australia)
- *                     campbell@torque.net
- *
  * My unoffical company acronym list is 21 pages long:
  *      FLA:    Four letter acronym with built in facility for
  *              future expansion to five letters.
--- linux-2.6.16-mm2-full/drivers/scsi/imm.h.old	2006-04-04 12:00:48.000000000 +0200
+++ linux-2.6.16-mm2-full/drivers/scsi/imm.h	2006-04-04 12:01:08.000000000 +0200
@@ -2,7 +2,7 @@
 /*  Driver for the Iomega MatchMaker parallel port SCSI HBA embedded in 
  * the Iomega ZIP Plus drive
  * 
- * (c) 1998     David Campbell     campbell@torque.net
+ * (c) 1998     David Campbell
  *
  * Please note that I live in Perth, Western Australia. GMT+0800
  */
--- linux-2.6.16-mm2-full/drivers/scsi/ppa.c.old	2006-04-04 12:01:16.000000000 +0200
+++ linux-2.6.16-mm2-full/drivers/scsi/ppa.c	2006-04-04 12:01:24.000000000 +0200
@@ -6,8 +6,6 @@
  * (c) 1995,1996 Grant R. Guenther, grant@torque.net,
  * under the terms of the GNU General Public License.
  * 
- * Current Maintainer: David Campbell (Perth, Western Australia, GMT+0800)
- *                     campbell@torque.net
  */
 
 #include <linux/config.h>
--- linux-2.6.16-mm2-full/drivers/scsi/ppa.h.old	2006-04-04 12:01:31.000000000 +0200
+++ linux-2.6.16-mm2-full/drivers/scsi/ppa.h	2006-04-04 12:01:38.000000000 +0200
@@ -2,7 +2,7 @@
  * the Iomega ZIP drive
  * 
  * (c) 1996     Grant R. Guenther  grant@torque.net
- *              David Campbell     campbell@torque.net
+ *              David Campbell
  *
  *      All comments to David.
  */

