Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVGGVks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVGGVks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGGVdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:33:49 -0400
Received: from coderock.org ([193.77.147.115]:49804 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262335AbVGGVcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:32:18 -0400
Message-Id: <20050707213142.385007000@homer>
Date: Thu, 07 Jul 2005 23:31:41 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [patch 4/4] cleanup indenting on drivers/char/Makefile
Content-Disposition: inline; filename=indent-drivers_char_Makefile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Cromie <jcromie@divsol.com>


items in makefile are partially tabbed into columns,
this patch finishes that indenting, minus an ifeq block,
which I think should stand out, so I left it.

Signed-of-by:  Jim Cromie <jcromie@divsol.com>

---
 Makefile |   70 +++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 35 insertions(+), 35 deletions(-)

Index: quilt/drivers/char/Makefile
===================================================================
--- quilt.orig/drivers/char/Makefile
+++ quilt/drivers/char/Makefile
@@ -44,51 +44,51 @@ obj-$(CONFIG_HVC_CONSOLE)	+= hvc_console
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MMTIMER)		+= mmtimer.o
-obj-$(CONFIG_VIOCONS) += viocons.o
+obj-$(CONFIG_VIOCONS)		+= viocons.o
 obj-$(CONFIG_VIOTAPE)		+= viotape.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
 obj-$(CONFIG_SGI_MBCS)		+= mbcs.o
 
-obj-$(CONFIG_PRINTER) += lp.o
-obj-$(CONFIG_TIPAR) += tipar.o
+obj-$(CONFIG_PRINTER)		+= lp.o
+obj-$(CONFIG_TIPAR)		+= tipar.o
 
-obj-$(CONFIG_DTLK) += dtlk.o
-obj-$(CONFIG_R3964) += n_r3964.o
-obj-$(CONFIG_APPLICOM) += applicom.o
-obj-$(CONFIG_SONYPI) += sonypi.o
-obj-$(CONFIG_RTC) += rtc.o
-obj-$(CONFIG_HPET) += hpet.o
-obj-$(CONFIG_GEN_RTC) += genrtc.o
-obj-$(CONFIG_EFI_RTC) += efirtc.o
-obj-$(CONFIG_SGI_DS1286) += ds1286.o
-obj-$(CONFIG_SGI_IP27_RTC) += ip27-rtc.o
-obj-$(CONFIG_DS1302) += ds1302.o
-obj-$(CONFIG_S3C2410_RTC) += s3c2410-rtc.o
-obj-$(CONFIG_RTC_VR41XX) += vr41xx_rtc.o
+obj-$(CONFIG_DTLK)		+= dtlk.o
+obj-$(CONFIG_R3964)		+= n_r3964.o
+obj-$(CONFIG_APPLICOM)		+= applicom.o
+obj-$(CONFIG_SONYPI)		+= sonypi.o
+obj-$(CONFIG_RTC)		+= rtc.o
+obj-$(CONFIG_HPET)		+= hpet.o
+obj-$(CONFIG_GEN_RTC)		+= genrtc.o
+obj-$(CONFIG_EFI_RTC)		+= efirtc.o
+obj-$(CONFIG_SGI_DS1286)	+= ds1286.o
+obj-$(CONFIG_SGI_IP27_RTC)	+= ip27-rtc.o
+obj-$(CONFIG_DS1302)		+= ds1302.o
+obj-$(CONFIG_S3C2410_RTC)	+= s3c2410-rtc.o
+obj-$(CONFIG_RTC_VR41XX)	+= vr41xx_rtc.o
 ifeq ($(CONFIG_GENERIC_NVRAM),y)
   obj-$(CONFIG_NVRAM) += generic_nvram.o
 else
   obj-$(CONFIG_NVRAM) += nvram.o
 endif
-obj-$(CONFIG_TOSHIBA) += toshiba.o
-obj-$(CONFIG_I8K) += i8k.o
-obj-$(CONFIG_DS1620) += ds1620.o
-obj-$(CONFIG_HW_RANDOM) += hw_random.o
-obj-$(CONFIG_FTAPE) += ftape/
-obj-$(CONFIG_COBALT_LCD) += lcd.o
-obj-$(CONFIG_PPDEV) += ppdev.o
-obj-$(CONFIG_NWBUTTON) += nwbutton.o
-obj-$(CONFIG_NWFLASH) += nwflash.o
-obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
-obj-$(CONFIG_GPIO_VR41XX) += vr41xx_giu.o
-obj-$(CONFIG_TANBAC_TB0219) += tb0219.o
-
-obj-$(CONFIG_WATCHDOG)	+= watchdog/
-obj-$(CONFIG_MWAVE) += mwave/
-obj-$(CONFIG_AGP) += agp/
-obj-$(CONFIG_DRM) += drm/
-obj-$(CONFIG_PCMCIA) += pcmcia/
-obj-$(CONFIG_IPMI_HANDLER) += ipmi/
+obj-$(CONFIG_TOSHIBA)		+= toshiba.o
+obj-$(CONFIG_I8K)		+= i8k.o
+obj-$(CONFIG_DS1620)		+= ds1620.o
+obj-$(CONFIG_HW_RANDOM)		+= hw_random.o
+obj-$(CONFIG_FTAPE)		+= ftape/
+obj-$(CONFIG_COBALT_LCD)	+= lcd.o
+obj-$(CONFIG_PPDEV)		+= ppdev.o
+obj-$(CONFIG_NWBUTTON)		+= nwbutton.o
+obj-$(CONFIG_NWFLASH)		+= nwflash.o
+obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
+obj-$(CONFIG_GPIO_VR41XX)	+= vr41xx_giu.o
+obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o
+
+obj-$(CONFIG_WATCHDOG)		+= watchdog/
+obj-$(CONFIG_MWAVE)		+= mwave/
+obj-$(CONFIG_AGP)		+= agp/
+obj-$(CONFIG_DRM)		+= drm/
+obj-$(CONFIG_PCMCIA)		+= pcmcia/
+obj-$(CONFIG_IPMI_HANDLER)	+= ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
 obj-$(CONFIG_TCG_TPM) += tpm/

--
