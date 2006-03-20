Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWCTPfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWCTPfG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbWCTPet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:34:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40632 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965303AbWCTP0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:26:42 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 074/141] V4L/DVB (3325): Disabled debug on by default in
	tvp5150
Date: Mon, 20 Mar 2006 12:08:49 -0300
Message-id: <20060320150849.PS378977000074@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Rechberger <mrechberger@gmail.com>
Date: 1139281279 +0100

disabled debug on by default in tvp5150

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index 3ae8a9f..69d0fe1 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -1182,7 +1182,7 @@ static int tvp5150_detect_client(struct 
 		return rv;
 	}
 
-//	if (debug > 1)
+	if (debug > 1)
 		dump_reg(c);
 	return 0;
 }

