Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbTE0VcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTE0VcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:32:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19701 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264057AbTE0VcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:32:20 -0400
Date: Tue, 27 May 2003 23:45:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Mitch@0Bits.COM, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       Alex Romosan <romosan@sycorax.lbl.gov>
Subject: Re: Linux 2.4.21-rc5
Message-ID: <20030527214526.GE19265@fs.tum.de>
References: <Pine.LNX.4.53.0305272142200.565@mx.homelinux.com> <200305272317.09854.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272317.09854.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 11:17:09PM +0200, Marc-Christian Petersen wrote:
> On Tuesday 27 May 2003 22:48, Mitch@0Bits.COM wrote:
> 
> Hi Mitch,
> 
> > It's be nice if we could also have the definition of
> > PCI_DEVICE_ID_VIA_8237 ?
> here it is.

I'd propose the following patch instead that also removes the duplicated 
PCI_DEVICE_ID_VIA_8377_0 :


--- linux-2.4.21-rc5-full/include/linux/pci_ids.h.old	2003-05-27 23:34:50.000000000 +0200
+++ linux-2.4.21-rc5-full/include/linux/pci_ids.h	2003-05-27 23:36:57.000000000 +0200
@@ -1026,10 +1026,10 @@
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
-#define PCI_DEVICE_ID_VIA_P4X333   0x3168
-#define PCI_DEVICE_ID_VIA_8235        0x3177
-#define PCI_DEVICE_ID_VIA_8377_0  0x3189
+#define PCI_DEVICE_ID_VIA_P4X333	0x3168
+#define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189
+#define PCI_DEVICE_ID_VIA_8237		0x3227
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235


> ciao, Marc


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

