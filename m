Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWI2DhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWI2DhE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWI2DhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:37:04 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:46211 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751279AbWI2DhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:37:03 -0400
Message-ID: <451C9574.1030500@student.ltu.se>
Date: Fri, 29 Sep 2006 05:39:32 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] drivers/media/video/cx88: Remove unused defined FALSE/TRUE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Remove defines of FALSE/TRUE because they are not used.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

'find -name *.[chS] | xargs grep "cx88.h"' found nothing outside cx88/
Against 2.6.18-mm2, compile-tested


diff -Narup -X linux-2.6.18-mm2/Documentation/dontdiff linux-2.6.18-mm2/drivers/media/video/cx88/cx88.h linux-2.6.18-mm2_drivers_media_video_cx88/drivers/media/video/cx88/cx88.h
--- linux-2.6.18-mm2/drivers/media/video/cx88/cx88.h	2006-09-29 04:55:44.000000000 +0200
+++ linux-2.6.18-mm2_drivers_media_video_cx88/drivers/media/video/cx88/cx88.h	2006-09-29 04:49:48.000000000 +0200
@@ -39,12 +39,6 @@
 #include <linux/mutex.h>
 #define CX88_VERSION_CODE KERNEL_VERSION(0,0,6)
 
-#ifndef TRUE
-# define TRUE (1==1)
-#endif
-#ifndef FALSE
-# define FALSE (1==0)
-#endif
 #define UNSET (-1U)
 
 #define CX88_MAXBOARDS 8


