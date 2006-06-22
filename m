Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWFVM7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWFVM7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 08:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWFVM7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 08:59:25 -0400
Received: from ns1.ptt.yu ([212.62.32.1]:47517 "EHLO ns1.ptt.yu")
	by vger.kernel.org with ESMTP id S1030203AbWFVM7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 08:59:24 -0400
Date: Thu, 22 Jun 2006 14:58:50 +0200
From: Predrag Ivanovic <predivan@ptt.yu>
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.17]drivers/media/video/bt8xx/bttvp.h has wrong include
 line
Message-Id: <20060622145850.0cf87d8a.predivan@ptt.yu>
Reply-To: predivan@ptt.yu
Organization: Random Violence
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.
Trivial patch, really.
Fixes include line in bttvp.h(btcx-risc.h is in parent dir).
------
--- bttvp.h	2006-06-19 16:48:46.000000000 +0200
+++ bttvp.h.new	2006-06-19 16:49:54.000000000 +0200
@@ -48,7 +48,7 @@
 
 #include "bt848.h"
 #include "bttv.h"
-#include "btcx-risc.h"
+#include "../btcx-risc.h"
 
 #ifdef __KERNEL__
 
-----------
Pedja 
-- 
 Recent studies suggest that running /usr/bin/coffee from cron at regular
 intervals can be more effective at enhancing uptime than launching a big
 coffeed process at startup.
