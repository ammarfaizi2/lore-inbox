Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWJNMLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWJNMLu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWJNMH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:07:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3789 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932191AbWJNMHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:07:39 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 05/18] V4L/DVB (4731a): Kconfig: restore pvrusb2 menu items
Date: Sat, 14 Oct 2006 09:00:50 -0300
Message-id: <20061014120050.PS46293700005@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@linuxtv.org>

Looks like the pvrusb2 menu items were accidentally removed in
git commit 1450e6bedc58c731617d99b4670070ed3ccc91b4

This patch restores the menu items so that the pvrusb2 driver can be built.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index afb734d..fbe5b61 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -677,6 +677,8 @@ #
 menu "V4L USB devices"
 	depends on USB && VIDEO_DEV
 
+source "drivers/media/video/pvrusb2/Kconfig"
+
 source "drivers/media/video/em28xx/Kconfig"
 
 source "drivers/media/video/usbvideo/Kconfig"

