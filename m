Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbREOXC6>; Tue, 15 May 2001 19:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261688AbREOXCs>; Tue, 15 May 2001 19:02:48 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:35076 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S261692AbREOXCd>;
	Tue, 15 May 2001 19:02:33 -0400
Date: Tue, 15 May 2001 16:02:32 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: export linux_logo_bw for hgafb.c
Message-ID: <20010515160232.A19573@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch for 2.4.4. linux_logo_bw is used in hgafb.c, which
can be compiled as a module. But linux_logo_bw is not exported.


H.J.
---
--- linux-2.4.4-ac9/drivers/video/fbcon.c.mod	Tue May 15 15:39:17 2001
+++ linux-2.4.4-ac9/drivers/video/fbcon.c	Tue May 15 15:40:18 2001
@@ -2495,3 +2495,4 @@ EXPORT_SYMBOL(fbcon_redraw_bmove);
 EXPORT_SYMBOL(fbcon_redraw_clear);
 EXPORT_SYMBOL(fbcon_dummy);
 EXPORT_SYMBOL(fb_con);
+EXPORT_SYMBOL(linux_logo_bw);
