Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWBJK2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWBJK2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWBJK2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:28:18 -0500
Received: from mail22.bluewin.ch ([195.186.19.66]:15339 "EHLO
	mail22.bluewin.ch") by vger.kernel.org with ESMTP id S1751233AbWBJK2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:28:08 -0500
Cc: Arthur Othieno <apgo@patchbomb.org>, perex@suse.cz,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sound: remove PC98-specific OPL3_HW_OPL3_PC98
In-Reply-To: <11395672534150-git-send-email-apgo@patchbomb.org>
X-Mailer: git-send-email
Date: Fri, 10 Feb 2006 05:27:34 -0500
Message-Id: <1139567254768-git-send-email-apgo@patchbomb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Arthur Othieno <apgo@patchbomb.org>
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Arthur Othieno <apgo@patchbomb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OPL3_HW_OPL3_PC98 #define isn't used anywhere; previously in
sound/drivers/opl3/opl3_lib.c and sound/isa/cs423x/pc98.c,
the latter of which went away with the rest of PC98 subarch.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

---

 include/sound/opl3.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

96e21d8b6cccd08b82767d89f802a6e2356ee96b
diff --git a/include/sound/opl3.h b/include/sound/opl3.h
index 8339264..30936ab 100644
--- a/include/sound/opl3.h
+++ b/include/sound/opl3.h
@@ -229,7 +229,6 @@
 #define OPL3_HW_OPL3_CS		0x0302	/* CS4232/CS4236+ */
 #define OPL3_HW_OPL3_FM801	0x0303	/* FM801 */
 #define OPL3_HW_OPL3_CS4281	0x0304	/* CS4281 */
-#define OPL3_HW_OPL3_PC98	0x0305	/* PC9800 */
 #define OPL3_HW_OPL4		0x0400	/* YMF278B/YMF295 */
 #define OPL3_HW_OPL4_ML		0x0401	/* YMF704/YMF721 */
 #define OPL3_HW_MASK		0xff00
-- 
1.1.5


