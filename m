Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVATPm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVATPm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVATPlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:41:14 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:17060 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262159AbVATPaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:30:15 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 20 Jan 2005 16:26:36 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l2 tuner api update
Message-ID: <20050120152636.GA12923@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add new tuner type to the v4l2 API.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 include/linux/videodev2.h |    1 +
 1 files changed, 1 insertion(+)

diff -u linux-2.6.10/include/linux/videodev2.h linux/include/linux/videodev2.h
--- linux-2.6.10/include/linux/videodev2.h	2005-01-13 10:48:21.000000000 +0100
+++ linux/include/linux/videodev2.h	2005-01-19 14:05:40.661259590 +0100
@@ -78,6 +78,7 @@
 enum v4l2_tuner_type {
 	V4L2_TUNER_RADIO	     = 1,
 	V4L2_TUNER_ANALOG_TV	     = 2,
+	V4L2_TUNER_DIGITAL_TV	     = 3,
 };
 
 enum v4l2_memory {

-- 
#define printk(args...) fprintf(stderr, ## args)
