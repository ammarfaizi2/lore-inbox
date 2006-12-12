Return-Path: <linux-kernel-owner+w=401wt.eu-S1751394AbWLLOxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWLLOxB (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 09:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWLLOxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 09:53:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51917 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbWLLOxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 09:53:01 -0500
Date: Tue, 12 Dec 2006 09:52:58 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: corbet@lwn.net
Subject: Make OLPC camera driver depend on x86.
Message-ID: <20061212145258.GA29952@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, corbet@lwn.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.19.noarch/drivers/media/video/Kconfig~	2006-12-12 09:51:16.000000000 -0500
+++ linux-2.6.19.noarch/drivers/media/video/Kconfig	2006-12-12 09:51:32.000000000 -0500
@@ -668,7 +668,7 @@ config VIDEO_M32R_AR_M64278
 
 config VIDEO_CAFE_CCIC
 	tristate "Marvell 88ALP01 (Cafe) CMOS Camera Controller support"
-	depends on I2C && VIDEO_V4L2
+	depends on I2C && VIDEO_V4L2 && X86_32
 	select VIDEO_OV7670
 	---help---
 	  This is a video4linux2 driver for the Marvell 88ALP01 integrated

-- 
http://www.codemonkey.org.uk
