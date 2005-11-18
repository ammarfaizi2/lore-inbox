Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbVKRV3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbVKRV3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVKRV3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:29:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39844 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750984AbVKRV3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:29:54 -0500
Date: Fri, 18 Nov 2005 16:29:38 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: dell_rbu driver depends on x86[64]
Message-ID: <20051118212938.GB3881@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This driver only appears on IA32 & EM64T boxes.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/firmware/Kconfig~	2005-11-14 19:23:45.000000000 -0500
+++ linux-2.6.14/drivers/firmware/Kconfig	2005-11-14 19:24:18.000000000 -0500
@@ -60,6 +60,7 @@ config EFI_PCDP
 
 config DELL_RBU
 	tristate "BIOS update support for DELL systems via sysfs"
+	depends on X86
 	select FW_LOADER
 	help
 	 Say m if you want to have the option of updating the BIOS for your

