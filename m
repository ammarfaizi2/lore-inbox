Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbSKFSWF>; Wed, 6 Nov 2002 13:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265905AbSKFSWE>; Wed, 6 Nov 2002 13:22:04 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:57503 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S265898AbSKFSVn>; Wed, 6 Nov 2002 13:21:43 -0500
Subject: [PATCH][mini] 2.4.46 drivers/media/video/audiochip.h
From: Brendan Burns <brendanburns@attbi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Nov 2002 13:35:01 -0500
Message-Id: <1036607702.5988.2.camel@epiphany>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like bttv-cards.c got updated without the header coming along,
this enables compiling (I took it from driver version 0.9.1 from
bytesex.org)

Please apply.
Thanks
Brendan


--- linux-2.5.46/drivers/media/video/audiochip.h	2002-11-06
13:30:15.000000000 -0500
+++ linux.new/drivers/media/video/audiochip.h	2002-11-06
13:30:07.000000000 -0500
@@ -67,4 +67,7 @@
 #define AUDC_SWITCH_MUTE      _IO('m',16)      /* turn on mute */
 #endif
 
+/* misc stuff to pass around config info to i2c chips */
+#define AUDC_CONFIG_PINNACLE  _IOW('m',32,int)
+
 #endif /* AUDIOCHIP_H */



