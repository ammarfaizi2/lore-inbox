Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130155AbQLKXK4>; Mon, 11 Dec 2000 18:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbQLKXKq>; Mon, 11 Dec 2000 18:10:46 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:3337 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S130147AbQLKXKf>;
	Mon, 11 Dec 2000 18:10:35 -0500
Date: Mon, 11 Dec 2000 14:40:18 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.X PPC/atyfb patch
Message-ID: <Pine.LNX.4.21.0012111439160.296-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The previous patch for 2.2.X for 2.4.0-testX.

--- atyfb.c.orig	Mon Dec 11 14:38:11 2000
+++ atyfb.c	Mon Dec 11 14:35:03 2000
@@ -3621,7 +3621,7 @@
 		}
 #endif
 		if (default_vmode == VMODE_CHOOSE) {
-		    if (Gx == LG_CHIP_ID || Gx == LI_CHIP_ID)
+		    if (Gx == LG_CHIP_ID || Gx == LI_CHIP_ID || Gx == LP_CHIP_ID)
 			/* G3 PowerBook with 1024x768 LCD */
 			default_vmode = VMODE_1024_768_60;
 		    else if (machine_is_compatible("iMac"))

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
