Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTE0VEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbTE0VEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:04:53 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:56582 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264146AbTE0VEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:04:37 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Mitch@0Bits.COM, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc5
Date: Tue, 27 May 2003 23:17:09 +0200
User-Agent: KMail/1.5.2
Cc: marcelo@conectiva.com.br, Alex Romosan <romosan@sycorax.lbl.gov>
References: <Pine.LNX.4.53.0305272142200.565@mx.homelinux.com>
In-Reply-To: <Pine.LNX.4.53.0305272142200.565@mx.homelinux.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VX90+KRzHit6TY6"
Message-Id: <200305272317.09854.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_VX90+KRzHit6TY6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 27 May 2003 22:48, Mitch@0Bits.COM wrote:

Hi Mitch,

> It's be nice if we could also have the definition of
> PCI_DEVICE_ID_VIA_8237 ?
here it is.

ciao, Marc

--Boundary-00=_VX90+KRzHit6TY6
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="VIA_8237-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="VIA_8237-fix.patch"

--- a/include/linux/pci_ids.h	2003-05-27 21:08:48.000000000 +0200
+++ b/include/linux/pci_ids.h	2003-05-27 23:15:53.000000000 +0200
@@ -1026,10 +1026,11 @@
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
-#define PCI_DEVICE_ID_VIA_P4X333   0x3168
-#define PCI_DEVICE_ID_VIA_8235        0x3177
-#define PCI_DEVICE_ID_VIA_8377_0  0x3189
+#define PCI_DEVICE_ID_VIA_P4X333	0x3168
+#define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189
+#define PCI_DEVICE_ID_VIA_8377_0	0x3189
+#define PCI_DEVICE_ID_VIA_8237		0x3227
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235

--Boundary-00=_VX90+KRzHit6TY6--

