Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWCZVLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWCZVLY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWCZVLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:11:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6153 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751266AbWCZVLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:11:23 -0500
Date: Sun, 26 Mar 2006 23:11:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typo: s/Haupauge/Hauppauge/
Message-ID: <20060326211122.GV4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo in a comment.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-mm1-full/drivers/media/dvb/ttpci/av7110.c.old	2006-03-26 20:10:57.000000000 +0200
+++ linux-2.6.16-mm1-full/drivers/media/dvb/ttpci/av7110.c	2006-03-26 20:11:08.000000000 +0200
@@ -2123,7 +2123,7 @@
 							read_pwm(av7110));
 				break;
 			case 0x0003:
-				/* Haupauge DVB-C 2.1 VES1820/ALPS TDBE2 */
+				/* Hauppauge DVB-C 2.1 VES1820/ALPS TDBE2 */
 				av7110->fe = ves1820_attach(&alps_tdbe2_config, &av7110->i2c_adap,
 							read_pwm(av7110));
 				break;

