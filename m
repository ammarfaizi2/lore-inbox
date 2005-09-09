Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbVIIHxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVIIHxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVIIHxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:53:33 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:54716 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S1751436AbVIIHxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:53:32 -0400
Date: Fri, 9 Sep 2005 09:53:21 +0200
From: Borislav Petkov <petkov@uni-muenster.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] [2.6.13-mm2] set IBM ThinkPad extras to default n in Kconfig
Message-ID: <20050909075321.GA12020@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

   I think the following isn't on purpose but the IBM Thinkpad acpi
   extras default to y in Kconfig. The patch below fixes it:

   Signed-off-by: <petkov@uni-muenster.de>


--- drivers/acpi/Kconfig.orig	2005-09-09 09:46:26.000000000 +0200
+++ drivers/acpi/Kconfig	2005-09-09 09:46:46.000000000 +0200
@@ -197,7 +197,7 @@ config ACPI_ASUS
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
-	default y
+	default n
 	---help---
 	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
