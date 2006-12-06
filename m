Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937721AbWLFWNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937721AbWLFWNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937717AbWLFWNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:13:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57594 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937721AbWLFWNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:13:23 -0500
Date: Wed, 6 Dec 2006 23:13:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: [PATCH] ARM: OMAP: cleanup long lines in sx1 mixer
Message-ID: <20061206221315.GA2038@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix too long lines in sound headers.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/sound/arm/omap/omap-alsa-sx1-mixer.h b/sound/arm/omap/omap-alsa-sx1-mixer.h
index 02b8b6a..4004ae4 100644
--- a/sound/arm/omap/omap-alsa-sx1-mixer.h
+++ b/sound/arm/omap/omap-alsa-sx1-mixer.h
@@ -28,10 +28,11 @@ #define PLAYBACK_TARGET_LOUDSPEAKER	0x00
 #define PLAYBACK_TARGET_HEADPHONE	0x01
 #define PLAYBACK_TARGET_CELLPHONE	0x02
 
-/* following are used for register 03h Mixer PGA control bits D7-D5 for selecting record source */
+/* following are used for register 03h Mixer PGA control bits
+   D7-D5 for selecting record source */
 #define REC_SRC_TARGET_COUNT		0x08
-#define REC_SRC_SINGLE_ENDED_MICIN_HED	0x00	/* oss code referred to MIXER_LINE */
-#define REC_SRC_SINGLE_ENDED_MICIN_HND	0x01	/* oss code referred to MIXER_MIC */
+#define REC_SRC_SINGLE_ENDED_MICIN_HED	0x00 /* oss code referred to MIXER_LINE */
+#define REC_SRC_SINGLE_ENDED_MICIN_HND	0x01 /* oss code referred to MIXER_MIC */
 #define REC_SRC_SINGLE_ENDED_AUX1	0x02
 #define REC_SRC_SINGLE_ENDED_AUX2	0x03
 #define REC_SRC_MICIN_HED_AND_AUX1	0x04
@@ -39,7 +40,7 @@ #define REC_SRC_MICIN_HED_AND_AUX2	0x05
 #define REC_SRC_MICIN_HND_AND_AUX1	0x06
 #define REC_SRC_MICIN_HND_AND_AUX2	0x07
 
-#define DEFAULT_OUTPUT_VOLUME		5	/* default output volume to dac dgc */
-#define DEFAULT_INPUT_VOLUME		2	/* default record volume */
+#define DEFAULT_OUTPUT_VOLUME 5	/* default output volume to dac dgc */
+#define DEFAULT_INPUT_VOLUME  2	/* default record volume */
 
 #endif

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
