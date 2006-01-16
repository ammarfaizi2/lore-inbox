Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWAPJ1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWAPJ1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWAPJ1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:27:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53483 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932283AbWAPJX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:23:59 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Tyler Trafford <tatrafford@comcast.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 10/25] i2c ids for upd64031a saa717x upd64083 wm8739
Date: Mon, 16 Jan 2006 07:11:21 -0200
Message-id: <20060116091121.PS56699700010@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Tyler Trafford <tatrafford@comcast.net>

- Add i2c ids for drivers: upd64031a saa717x upd64083 wm8739

Signed-off-by: Tyler Trafford <tatrafford@comcast.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 include/linux/i2c-id.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 6ff2d36..474c8f4 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -104,6 +104,10 @@
 #define I2C_DRIVERID_AKITAIOEXP	74	/* IO Expander on Sharp SL-C1000 */
 #define I2C_DRIVERID_INFRARED	75	/* I2C InfraRed on Video boards */
 #define I2C_DRIVERID_TVP5150	76	/* TVP5150 video decoder        */
+#define I2C_DRIVERID_WM8739	77	/* wm8739 audio processor	*/
+#define I2C_DRIVERID_UPD64083	78	/* upd64083 video processor	*/
+#define I2C_DRIVERID_UPD64031A	79	/* upd64031a video processor	*/
+#define I2C_DRIVERID_SAA717X	80	/* saa717x video encoder	*/
 
 #define I2C_DRIVERID_I2CDEV	900
 #define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */

