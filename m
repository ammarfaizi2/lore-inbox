Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVF0Fje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVF0Fje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 01:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVF0Fjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:39:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12244 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261563AbVF0Fjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:39:31 -0400
Date: Mon, 27 Jun 2005 01:39:28 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: fix silly config option.
Message-ID: <20050627053928.GA9759@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CONFIG_TUNER_MULTI_I2C probably isn't what the
author meant to create.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/drivers/media/video/Kconfig~	2005-06-27 01:37:39.000000000 -0400
+++ linux-2.6.12/drivers/media/video/Kconfig	2005-06-27 01:37:56.000000000 -0400
@@ -7,7 +7,7 @@ menu "Video For Linux"
 
 comment "Video Adapters"
 
-config CONFIG_TUNER_MULTI_I2C
+config TUNER_MULTI_I2C
 	bool "Enable support for multiple I2C devices on Video Adapters (EXPERIMENTAL)"
 	depends on VIDEO_DEV && EXPERIMENTAL
 	---help---
