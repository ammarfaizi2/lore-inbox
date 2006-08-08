Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWHHVK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWHHVK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWHHVK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:10:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42442 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965047AbWHHVK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:10:27 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 01/14] V4L/DVB (4340): Videodev.h should be included also
	when V4L1_COMPAT is selected.
Date: Tue, 08 Aug 2006 18:06:52 -0300
Message-id: <20060808210652.PS73142300001@infradead.org>
In-Reply-To: <20060808210151.PS78629800000@infradead.org>
References: <20060808210151.PS78629800000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 include/media/v4l2-dev.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index f866532..600d61d 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -16,7 +16,7 @@ #include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/compiler.h> /* need __user */
-#ifdef CONFIG_VIDEO_V4L1
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 #include <linux/videodev.h>
 #else
 #include <linux/videodev2.h>

