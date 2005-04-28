Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVD1HMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVD1HMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVD1HMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:12:41 -0400
Received: from adsl-186.flex.com ([206.126.1.185]:17024 "EHLO mail.imodulo.com")
	by vger.kernel.org with ESMTP id S261493AbVD1HLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:11:37 -0400
Date: Thu, 28 Apr 2005 07:11:36 +0000
From: Glen Nakamura <glen@imodulo.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31-pre1] Duplicate id in videodev.h
Message-ID: <20050428071136.GA2032@modulo.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VID_HARDWARE_W9968CF and VID_HARDWARE_SAA7114H are both assigned value 36.
Trivial patch below increases VID_HARDWARE_SAA7114H to 37.

Signed-off-by: Glen Nakamura <glen@imodulo.com>


--- linux-2.4.30.orig/include/linux/videodev.h	2004-02-18 13:36:32.000000000 +0000
+++ linux-2.4.30/include/linux/videodev.h	2004-02-18 13:36:32.000000000 +0000
@@ -421,7 +421,7 @@ struct video_code
 #define VID_HARDWARE_VICAM      34
 #define VID_HARDWARE_SF16FMR2	35
 #define VID_HARDWARE_W9968CF	36
-#define VID_HARDWARE_SAA7114H	36
+#define VID_HARDWARE_SAA7114H	37
 
 #endif /* __LINUX_VIDEODEV_H */
 
