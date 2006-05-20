Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWETCw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWETCw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 22:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWETCw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 22:52:57 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:21687 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964823AbWETCw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 22:52:56 -0400
Date: Fri, 19 May 2006 19:52:55 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>
Subject: [PATCH] EDD isn't EXPERIMENTAL anymore
Message-ID: <20060520025255.GB9486@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of people use this.  Apparently RH has for over 18 months so lets
drop EXPERIMENTAL.


Signed-off-by: Chris Wedgwood <cw@f00f.org>

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 1e371a5..4ea7044 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -7,7 +7,6 @@ menu "Firmware Drivers"
 
 config EDD
 	tristate "BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
 	depends on !IA64
 	help
 	  Say Y or M here if you want to enable BIOS Enhanced Disk Drive
