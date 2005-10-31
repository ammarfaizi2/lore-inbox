Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVJaO7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVJaO7K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVJaO7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:59:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34251 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750917AbVJaO7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:59:09 -0500
Subject: Re: 2.6.14-rc5-mm1: EDAC: several options without a help text
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051028175849.GC4180@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <20051028175849.GC4180@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Oct 2005 15:26:50 +0000
Message-Id: <1130772410.9145.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-10-28 at 19:58 +0200, Adrian Bunk wrote:
> Hi Alan,
> 
> the hardware-specific EDAC drivers don't have a help text.
> 
> Can you add help texts?

Done

Signed-off-by: Alan Cox <alan@redhat.com>

--- drivers/edac/Kconfig~	2005-10-31 14:49:10.707520192 +0000
+++ drivers/edac/Kconfig	2005-10-31 14:49:10.707520192 +0000
@@ -44,26 +44,44 @@
 config EDAC_AMD76X
 	tristate "AMD 76x (760, 762, 768)"
 	depends on EDAC
+	help
+	  Support for error detection and correction on the AMD 76x
+	  series of chipsets used with the Athlon processor.
 
 config EDAC_E7XXX
 	tristate "Intel e7xxx (e7205, e7500, e7501, e7505)"
 	depends on EDAC
+	help
+	  Support for error detection and correction on the Intel
+	  E7205, E7500, E7501 and E7505 server chipsets.
 
 config EDAC_E752X
 	tristate "Intel e752x (e7520, e7525, e7320)"
 	depends on EDAC
+	help
+	  Support for error detection and correction on the Intel
+	  E7520, E7525, E7320 server chipsets.
 
 config EDAC_I82875P
 	tristate "Intel 82875p (D82875P, E7210)"
 	depends on EDAC
+	help
+	  Support for error detection and correction on the Intel
+	  DP82785P and E7210 server chipsets.
 
 config EDAC_I82860
 	tristate "Intel 82860"
 	depends on EDAC
+	help
+	  Support for error detection and correction on the Intel
+	  82860 chipset.
 
 config EDAC_R82600
 	tristate "Radisys 82600 embedded chipset"
 	depends on EDAC
+	help
+	  Support for error detection and correction on the Radisys
+	  82600 embedded chipset.
 
 choice
 	prompt "Error detecting method"

