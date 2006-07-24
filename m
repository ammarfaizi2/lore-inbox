Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWGXRWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWGXRWy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWGXRWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:22:53 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:58518 "EHLO
	outbound2-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932240AbWGXRWv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:22:51 -0400
X-BigFish: V
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 4/4] [PATCH] gxfb: Add timings for the OLPC LCD
Date: Mon, 24 Jul 2006 10:56:07 -0600
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       blizzard@redhat.com, dwmw2@redhat.com
Message-ID: <20060724165607.18822.38609.stgit@cosmic.amd.com>
In-Reply-To: <20060724165454.18822.30310.stgit@cosmic.amd.com>
References: <20060724165454.18822.30310.stgit@cosmic.amd.com>
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 24 Jul 2006 16:52:04.0704 (UTC)
 FILETIME=[7DECBE00:01C6AF41]
MIME-Version: 1.0
X-WSS-ID: 68DA253E1NW73666-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=fixed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jordan.crouse@amd.com>

Add a mode for the OLPC LCD.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/geode/gxfb_core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 1e0d47e..75c7fd9 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -103,6 +103,9 @@ static const struct fb_videomode __initd
 	{ NULL, 85, 1600, 1200, 4357, 304, 64, 46, 1, 192, 3,
 	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	{ "OLPC-1", 50, 1200, 900, 17460, 24, 8, 4, 5, 8, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, 0 }
 };
 
 static int gxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)


