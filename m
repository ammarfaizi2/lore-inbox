Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVE3TAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVE3TAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVE3TAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:00:24 -0400
Received: from femail.waymark.net ([206.176.148.84]:51651 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261701AbVE3S74 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:59:56 -0400
Date: 30 May 2005 18:41:24 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: [PATCH] arch/i386/defconfig
To: linux-kernel@vger.kernel.org
Message-ID: <d032b4.be6d2c@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AC97_CODEC is selected by the drivers that need it, yes? and
since comparatively few people have the SND_INTEL8x0
hardware do not default.
patch is to 2.6.11-rc5

Signed-off by: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>

--- defconfig.orig      2005-05-30 12:06:33.000000000 -0500
+++ defconfig   2005-05-30 13:29:00.000000000 -0500
@@ -913,7 +913,7 @@
 #
 # PCI devices
 #
-CONFIG_SND_AC97_CODEC=y
+# CONFIG_SND_AC97_CODEC is not set
 # CONFIG_SND_ALI5451 is not set
 # CONFIG_SND_ATIIXP is not set
 # CONFIG_SND_AU8810 is not set
@@ -943,7 +943,7 @@
 # CONFIG_SND_FM801 is not set
 # CONFIG_SND_ICE1712 is not set
 # CONFIG_SND_ICE1724 is not set
-CONFIG_SND_INTEL8X0=y
+# CONFIG_SND_INTEL8X0 is not set
 # CONFIG_SND_INTEL8X0M is not set
 # CONFIG_SND_SONICVIBES is not set
 # CONFIG_SND_VIA82XX is not set

... Grauman's Chinese Theater opened in 1927 May.
