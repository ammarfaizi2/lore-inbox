Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVHXG1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVHXG1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 02:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVHXG1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 02:27:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37902 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750753AbVHXG1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 02:27:11 -0400
Date: Wed, 24 Aug 2005 08:27:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] Documentation/dvb/get_dvb_firmware: fix firmware URL
Message-ID: <20050824062709.GB5603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a wrong URL in Documentation/dvb/get_dvb_firmware.

This patch fixes kernel Bugzilla #4301.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm2-full/Documentation/dvb/get_dvb_firmware.old	2005-08-24 08:16:01.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/Documentation/dvb/get_dvb_firmware	2005-08-24 08:16:43.000000000 +0200
@@ -223,7 +223,7 @@
 }
 
 sub dibusb {
-	my $url = "http://www.linuxtv.org/downloads/firmware/dvb-dibusb-5.0.0.11.fw";
+	my $url = "http://www.linuxtv.org/downloads/firmware/dvb-usb-dibusb-5.0.0.11.fw";
 	my $outfile = "dvb-dibusb-5.0.0.11.fw";
 	my $hash = "fa490295a527360ca16dcdf3224ca243";
 

