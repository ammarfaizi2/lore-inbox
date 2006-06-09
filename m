Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWFIOEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWFIOEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWFIOEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:04:33 -0400
Received: from mo31.po.2iij.net ([210.128.50.54]:49484 "EHLO mo31.po.2iij.net")
	by vger.kernel.org with ESMTP id S965191AbWFIOEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:04:33 -0400
Date: Fri, 9 Jun 2006 23:04:25 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add select GPIO_VR41XX for TANBAC_TB0229
Message-Id: <20060609230425.3e51cd93.yoichi_yuasa@tripeaks.co.jp>
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

diff -pruN -X rc6/Documentation/dontdiff rc6-orig/drivers/char/Kconfig rc6/drivers/char/Kconfig
--- rc6-orig/drivers/char/Kconfig	2006-06-09 22:52:04.203313000 +0900
+++ rc6/drivers/char/Kconfig	2006-06-09 22:33:38.858233250 +0900
@@ -865,6 +865,7 @@ config SONYPI
 config TANBAC_TB0219
 	tristate "TANBAC TB0219 base board support"
 	depends TANBAC_TB022X
+	select GPIO_VR41XX
 
 menu "Ftape, the floppy tape device driver"
 
