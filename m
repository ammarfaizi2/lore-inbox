Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbUKQMIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUKQMIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 07:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbUKQMGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 07:06:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55302 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262265AbUKQMFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 07:05:30 -0500
Date: Wed, 17 Nov 2004 13:03:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove unused dvb-core/Makefile.lib
Message-ID: <20041117120352.GN4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes the completely unused 
drivers/media/dvb/dvb-core/Makefile.lib (this file seems to be a 
leftover from the times when this wasn't handled with select).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/Makefile.lib	2004-10-18 23:54:32.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1 +0,0 @@
-obj-$(CONFIG_DVB_CORE)		+= crc32.o

