Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVGaT65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVGaT65 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVGaT6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:58:42 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:25875 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261957AbVGaT5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:57:33 -0400
Date: Sun, 31 Jul 2005 21:57:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (9/11) hwmon vs i2c, second round
Message-Id: <20050731215733.42657957.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Delete DEFAULT_VRM from hwmon-vid.h, it has no more users.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/hwmon-vid.h |    2 --
 1 files changed, 2 deletions(-)

--- linux-2.6.13-rc4.orig/include/linux/hwmon-vid.h	2005-07-31 16:59:30.000000000 +0200
+++ linux-2.6.13-rc4/include/linux/hwmon-vid.h	2005-07-31 20:55:49.000000000 +0200
@@ -53,8 +53,6 @@
 
 int vid_which_vrm(void);
 
-#define DEFAULT_VRM	82
-
 static inline int vid_from_reg(int val, int vrm)
 {
 	int vid;


-- 
Jean Delvare
