Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbTBTCDf>; Wed, 19 Feb 2003 21:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTBTCAh>; Wed, 19 Feb 2003 21:00:37 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:58885 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265077AbTBTB72>; Wed, 19 Feb 2003 20:59:28 -0500
Subject: [PATCH] Spelling fixes for availible -> available and others in 11
	files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 19 Feb 2003 19:00:49 -0700
Message-Id: <1045706451.5611.498.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the following spelling fixes:

negotation   -> negotiation
stabelized   -> stabilized
labled       -> labeled
availible     -> available
tabel         -> table

 Documentation/DocBook/parportbook.tmpl   |    2 +-
 Documentation/s390/TAPE                  |    2 +-
 Documentation/video4linux/bttv/Sound-FAQ |    2 +-
 drivers/net/via-rhine.c                  |    2 +-
 drivers/scsi/aic7xxx/aic79xx.h           |    2 +-
 drivers/scsi/aic7xxx/aic79xx_core.c      |    6 +++---
 drivers/scsi/aic7xxx/aic7xxx.h           |    2 +-
 drivers/scsi/aic7xxx/aic7xxx_core.c      |    6 +++---
 drivers/scsi/aic7xxx_old.c               |    4 ++--
 drivers/scsi/sym53c8xx.c                 |    2 +-
 include/sound/uda1341.h                  |    2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff -ur linux-2.5-current/Documentation/DocBook/parportbook.tmpl linux/Documentation/DocBook/parportbook.tmpl
--- linux-2.5-current/Documentation/DocBook/parportbook.tmpl	Wed Feb 19 07:34:40 2003
+++ linux/Documentation/DocBook/parportbook.tmpl	Wed Feb 19 08:28:19 2003
@@ -1149,7 +1149,7 @@
    peripheral what transfer mode it would like to use, and the
    peripheral either accepts that mode or rejects it; if the mode is
    rejected, the host can try again with a different mode.  This is
-   the negotation phase.  Once the peripheral has accepted a
+   the negotiation phase.  Once the peripheral has accepted a
    particular transfer mode, data transfer can begin that mode.
   </para>
 
diff -ur linux-2.5-current/Documentation/s390/TAPE linux/Documentation/s390/TAPE
--- linux-2.5-current/Documentation/s390/TAPE	Wed Feb 19 07:35:17 2003
+++ linux/Documentation/s390/TAPE	Wed Feb 19 08:31:17 2003
@@ -91,7 +91,7 @@
 
 TODO List 
 
-   - Driver has to be stabelized still
+   - Driver has to be stabilized still
 
 BUGS 
 
diff -ur linux-2.5-current/Documentation/video4linux/bttv/Sound-FAQ linux/Documentation/video4linux/bttv/Sound-FAQ
--- linux-2.5-current/Documentation/video4linux/bttv/Sound-FAQ	Wed Feb 19 07:35:23 2003
+++ linux/Documentation/video4linux/bttv/Sound-FAQ	Wed Feb 19 08:33:39 2003
@@ -120,7 +120,7 @@
 video_inputs    - # of video inputs the card has
 audio_inputs    - historical cruft, not used any more.
 tuner           - which input is the tuner
-svhs            - which input is svhs (all others are labled composite)
+svhs            - which input is svhs (all others are labeled composite)
 muxsel          - video mux, input->registervalue mapping
 pll             - same as pll= insmod option
 tuner_type      - same as tuner= insmod option
diff -ur linux-2.5-current/drivers/net/via-rhine.c linux/drivers/net/via-rhine.c
--- linux-2.5-current/drivers/net/via-rhine.c	Wed Feb 19 07:35:21 2003
+++ linux/drivers/net/via-rhine.c	Wed Feb 19 08:28:40 2003
@@ -132,7 +132,7 @@
    Both 'options[]' and 'full_duplex[]' should exist for driver
    interoperability.
    The media type is usually passed in 'options[]'.
-   The default is autonegotation for speed and duplex.
+   The default is autonegotiation for speed and duplex.
      This should rarely be overridden.
    Use option values 0x10/0x20 for 10Mbps, 0x100,0x200 for 100Mbps.
    Use option values 0x10 and 0x100 for forcing half duplex fixed speed.
diff -ur linux-2.5-current/drivers/scsi/aic7xxx/aic79xx.h linux/drivers/scsi/aic7xxx/aic79xx.h
--- linux-2.5-current/drivers/scsi/aic7xxx/aic79xx.h	Wed Feb 19 07:35:06 2003
+++ linux/drivers/scsi/aic7xxx/aic79xx.h	Wed Feb 19 08:37:04 2003
@@ -365,7 +365,7 @@
 
 /*
  * The driver keeps up to MAX_SCB scb structures per card in memory.  The SCB
- * consists of a "hardware SCB" mirroring the fields availible on the card
+ * consists of a "hardware SCB" mirroring the fields available on the card
  * and additional information the kernel stores for each transaction.
  *
  * To minimize space utilization, a portion of the hardware scb stores
diff -ur linux-2.5-current/drivers/scsi/aic7xxx/aic79xx_core.c linux/drivers/scsi/aic7xxx/aic79xx_core.c
--- linux-2.5-current/drivers/scsi/aic7xxx/aic79xx_core.c	Wed Feb 19 07:34:37 2003
+++ linux/drivers/scsi/aic7xxx/aic79xx_core.c	Wed Feb 19 08:35:19 2003
@@ -516,7 +516,7 @@
 	ahd_dump_card_state(ahd);
 	panic("BRKADRINT");
 
-	/* Tell everyone that this HBA is no longer availible */
+	/* Tell everyone that this HBA is no longer available */
 	ahd_abort_scbs(ahd, CAM_TARGET_WILDCARD, ALL_CHANNELS,
 		       CAM_LUN_WILDCARD, SCB_LIST_NULL, ROLE_UNKNOWN,
 		       CAM_NO_HBA);
@@ -3755,9 +3755,9 @@
 				    devinfo->target, &tstate);
 
 	/*
-	 * Parse as much of the message as is availible,
+	 * Parse as much of the message as is available,
 	 * rejecting it if we don't support it.  When
-	 * the entire message is availible and has been
+	 * the entire message is available and has been
 	 * handled, return MSGLOOP_MSGCOMPLETE, indicating
 	 * that we have parsed an entire message.
 	 *
diff -ur linux-2.5-current/drivers/scsi/aic7xxx/aic7xxx.h linux/drivers/scsi/aic7xxx/aic7xxx.h
--- linux-2.5-current/drivers/scsi/aic7xxx/aic7xxx.h	Wed Feb 19 07:35:01 2003
+++ linux/drivers/scsi/aic7xxx/aic7xxx.h	Wed Feb 19 08:36:35 2003
@@ -372,7 +372,7 @@
 
 /*
  * The driver keeps up to MAX_SCB scb structures per card in memory.  The SCB
- * consists of a "hardware SCB" mirroring the fields availible on the card
+ * consists of a "hardware SCB" mirroring the fields available on the card
  * and additional information the kernel stores for each transaction.
  *
  * To minimize space utilization, a portion of the hardware scb stores
diff -ur linux-2.5-current/drivers/scsi/aic7xxx/aic7xxx_core.c linux/drivers/scsi/aic7xxx/aic7xxx_core.c
--- linux-2.5-current/drivers/scsi/aic7xxx/aic7xxx_core.c	Wed Feb 19 07:34:57 2003
+++ linux/drivers/scsi/aic7xxx/aic7xxx_core.c	Wed Feb 19 08:35:47 2003
@@ -389,7 +389,7 @@
 
 	ahc_dump_card_state(ahc);
 
-	/* Tell everyone that this HBA is no longer availible */
+	/* Tell everyone that this HBA is no longer available */
 	ahc_abort_scbs(ahc, CAM_TARGET_WILDCARD, ALL_CHANNELS,
 		       CAM_LUN_WILDCARD, SCB_LIST_NULL, ROLE_UNKNOWN,
 		       CAM_NO_HBA);
@@ -2988,9 +2988,9 @@
 	targ_scsirate = tinfo->scsirate;
 
 	/*
-	 * Parse as much of the message as is availible,
+	 * Parse as much of the message as is available,
 	 * rejecting it if we don't support it.  When
-	 * the entire message is availible and has been
+	 * the entire message is available and has been
 	 * handled, return MSGLOOP_MSGCOMPLETE, indicating
 	 * that we have parsed an entire message.
 	 *
diff -ur linux-2.5-current/drivers/scsi/aic7xxx_old.c linux/drivers/scsi/aic7xxx_old.c
--- linux-2.5-current/drivers/scsi/aic7xxx_old.c	Wed Feb 19 07:34:56 2003
+++ linux/drivers/scsi/aic7xxx_old.c	Wed Feb 19 08:37:23 2003
@@ -4945,9 +4945,9 @@
   target_mask = (0x01 << tindex);
 
   /*
-   * Parse as much of the message as is availible,
+   * Parse as much of the message as is available,
    * rejecting it if we don't support it.  When
-   * the entire message is availible and has been
+   * the entire message is available and has been
    * handled, return TRUE indicating that we have
    * parsed an entire message.
    */
diff -ur linux-2.5-current/drivers/scsi/sym53c8xx.c linux/drivers/scsi/sym53c8xx.c
--- linux-2.5-current/drivers/scsi/sym53c8xx.c	Wed Feb 19 07:35:06 2003
+++ linux/drivers/scsi/sym53c8xx.c	Wed Feb 19 08:28:55 2003
@@ -9092,7 +9092,7 @@
 	ccb_p   cp  = ncr_ccb_from_dsa(np, dsa);
 
 	/*
-	 * Fix Up. Some disks respond to a PPR negotation with
+	 * Fix Up. Some disks respond to a PPR negotiation with
 	 * a bus free instead of a message reject. 
 	 * Disable ppr negotiation if this is first time
 	 * tried ppr negotiation.
diff -ur linux-2.5-current/include/sound/uda1341.h linux/include/sound/uda1341.h
--- linux-2.5-current/include/sound/uda1341.h	Wed Feb 19 07:35:06 2003
+++ linux/include/sound/uda1341.h	Wed Feb 19 08:31:37 2003
@@ -160,7 +160,7 @@
  * this was computed as peak_value[i] = pow((63-i)*1.42,1.013)
  *
  * UDA1341 datasheet on page 21: Peak value (dB) = (Peak level - 63.5)*5*log2
- * There is an tabel with these values [level]=value: [3]=-90.31, [7]=-84.29
+ * There is an table with these values [level]=value: [3]=-90.31, [7]=-84.29
  * [61]=-2.78, [62] = -1.48, [63] = 0.0
  * I tried to compute it, but using but even using logarithm with base either 10 or 2
  * i was'n able to get values in the table from the formula. So I constructed another



