Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWFPClF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWFPClF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 22:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWFPClF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 22:41:05 -0400
Received: from mo31.po.2iij.net ([210.128.50.54]:5914 "EHLO mo31.po.2iij.net")
	by vger.kernel.org with ESMTP id S1750710AbWFPClE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 22:41:04 -0400
Date: Fri, 16 Jun 2006 11:40:55 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] add "select GPIO_VR41XX" for TANBAC_TB0229
Message-Id: <20060616114055.3492e8d4.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

TANBAC_TB0229 requires GPIO_VR41XX.
This patch adds "select GPIO_VR41XX" for TANBAC_TB0229.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X linux-2.6.17-rc6-mm2/Documentation/dontdiff linux-2.6.17-rc6-mm2-orig/drivers/char/Kconfig linux-2.6.17-rc6-mm2/drivers/char/Kconfig
--- linux-2.6.17-rc6-mm2-orig/drivers/char/Kconfig	2006-06-11 22:17:17.487656750 +0900
+++ linux-2.6.17-rc6-mm2/drivers/char/Kconfig	2006-06-16 09:52:16.642990750 +0900
@@ -852,6 +852,7 @@ config SONYPI
 config TANBAC_TB0219
 	tristate "TANBAC TB0219 base board support"
 	depends TANBAC_TB022X
+	select GPIO_VR41XX
 
 menu "Ftape, the floppy tape device driver"
 
