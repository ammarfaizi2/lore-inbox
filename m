Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbWIFXHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbWIFXHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbWIFXHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:07:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38148 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965280AbWIFXHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:07:01 -0400
Date: Thu, 7 Sep 2006 01:07:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Stelian Pop <stelian@popies.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [-mm patch] ACPI_SONY shouldn't default m
Message-ID: <20060906230700.GE12157@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should default to n.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc5-mm1/drivers/acpi/Kconfig.old	2006-09-07 00:49:37.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/acpi/Kconfig	2006-09-07 00:50:01.000000000 +0200
@@ -251,7 +251,6 @@
 config ACPI_SONY
 	tristate "Sony Laptop Extras"
 	depends on X86 && ACPI
-	default m
 	  ---help---
 	  This mini-driver drives the ACPI SNC device present in the
 	  ACPI BIOS of the Sony Vaio laptops.

