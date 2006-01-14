Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945974AbWANCMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945974AbWANCMO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945977AbWANCMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:12:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26130 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945974AbWANCMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:12:12 -0500
Date: Sat, 14 Jan 2006 03:12:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] spelling: s/appropiate/appropriate/
Message-ID: <20060114021212.GG29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/cachetlb.txt            |    2 +-
 Documentation/ioctl/hdio.txt          |    2 +-
 Documentation/laptop-mode.txt         |    2 +-
 Documentation/networking/sk98lin.txt  |    2 +-
 Documentation/x86_64/boot-options.txt |    2 +-
 drivers/s390/scsi/zfcp_erp.c          |    2 +-
 drivers/scsi/gdth.c                   |    2 +-
 sound/oss/opl3sa2.c                   |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.15-mm3-full/Documentation/cachetlb.txt.old	2006-01-14 02:19:46.000000000 +0100
+++ linux-2.6.15-mm3-full/Documentation/cachetlb.txt	2006-01-14 02:20:02.000000000 +0100
@@ -136,7 +136,7 @@
 8) void lazy_mmu_prot_update(pte_t pte)
 	This interface is called whenever the protection on
 	any user PTEs change.  This interface provides a notification
-	to architecture specific code to take appropiate action.
+	to architecture specific code to take appropriate action.
 
 
 Next, we have the cache flushing interfaces.  In general, when Linux
--- linux-2.6.15-mm3-full/Documentation/ioctl/hdio.txt.old	2006-01-14 02:20:09.000000000 +0100
+++ linux-2.6.15-mm3-full/Documentation/ioctl/hdio.txt	2006-01-14 02:20:14.000000000 +0100
@@ -946,7 +946,7 @@
 
 	  This ioctl initializes the addresses and irq for a disk
 	  controller, probes for drives, and creates /proc/ide
-	  interfaces as appropiate.
+	  interfaces as appropriate.
 
 
 
--- linux-2.6.15-mm3-full/Documentation/laptop-mode.txt.old	2006-01-14 02:20:25.000000000 +0100
+++ linux-2.6.15-mm3-full/Documentation/laptop-mode.txt	2006-01-14 02:20:30.000000000 +0100
@@ -357,7 +357,7 @@
 # Read-ahead, in kilobytes
 READAHEAD=${READAHEAD:-'4096'}
 
-# Shall we remount journaled fs. with appropiate commit interval? (1=yes)
+# Shall we remount journaled fs. with appropriate commit interval? (1=yes)
 DO_REMOUNTS=${DO_REMOUNTS:-'1'}
 
 # And shall we add the "noatime" option to that as well? (1=yes)
--- linux-2.6.15-mm3-full/Documentation/networking/sk98lin.txt.old	2006-01-14 02:20:37.000000000 +0100
+++ linux-2.6.15-mm3-full/Documentation/networking/sk98lin.txt	2006-01-14 02:20:44.000000000 +0100
@@ -91,7 +91,7 @@
    with (M)
 5. Execute the command "make modules".
 6. Execute the command "make modules_install".
-   The appropiate modules will be installed.
+   The appropriate modules will be installed.
 7. Reboot your system.
 
 
--- linux-2.6.15-mm3-full/Documentation/x86_64/boot-options.txt.old	2006-01-14 02:20:52.000000000 +0100
+++ linux-2.6.15-mm3-full/Documentation/x86_64/boot-options.txt	2006-01-14 02:20:57.000000000 +0100
@@ -198,6 +198,6 @@
 
 Misc
 
-  noreplacement  Don't replace instructions with more appropiate ones
+  noreplacement  Don't replace instructions with more appropriate ones
 		 for the CPU. This may be useful on asymmetric MP systems
 		 where some CPU have less capabilities than the others.
--- linux-2.6.15-mm3-full/drivers/s390/scsi/zfcp_erp.c.old	2006-01-14 02:21:04.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/s390/scsi/zfcp_erp.c	2006-01-14 02:21:08.000000000 +0100
@@ -3403,7 +3403,7 @@
 /**
  * zfcp_erp_action_cleanup
  *
- * Register unit with scsi stack if appropiate and fix reference counts.
+ * Register unit with scsi stack if appropriate and fix reference counts.
  * Note: Temporary units are not registered with scsi stack.
  */
 static void
--- linux-2.6.15-mm3-full/drivers/scsi/gdth.c.old	2006-01-14 02:21:15.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/scsi/gdth.c	2006-01-14 02:21:20.000000000 +0100
@@ -328,7 +328,7 @@
  * hdr_channel:x                x - number of virtual bus for host drives
  * shared_access:Y              disable driver reserve/release protocol to 
  *                              access a shared resource from several nodes, 
- *                              appropiate controller firmware required
+ *                              appropriate controller firmware required
  * shared_access:N              enable driver reserve/release protocol
  * probe_eisa_isa:Y             scan for EISA/ISA controllers
  * probe_eisa_isa:N             do not scan for EISA/ISA controllers
--- linux-2.6.15-mm3-full/sound/oss/opl3sa2.c.old	2006-01-14 02:21:27.000000000 +0100
+++ linux-2.6.15-mm3-full/sound/oss/opl3sa2.c	2006-01-14 02:21:34.000000000 +0100
@@ -530,7 +530,7 @@
 	if (hw_config->slots[0] != -1) {
 		/* Did the MSS driver install? */
 		if(num_mixers == (initial_mixers + 1)) {
-			/* The MSS mixer is installed, reroute mixers appropiately */
+			/* The MSS mixer is installed, reroute mixers appropriately */
 			AD1848_REROUTE(SOUND_MIXER_LINE1, SOUND_MIXER_CD);
 			AD1848_REROUTE(SOUND_MIXER_LINE2, SOUND_MIXER_SYNTH);
 			AD1848_REROUTE(SOUND_MIXER_LINE3, SOUND_MIXER_LINE);

