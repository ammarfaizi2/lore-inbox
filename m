Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315422AbSEBVII>; Thu, 2 May 2002 17:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315423AbSEBVIH>; Thu, 2 May 2002 17:08:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57104 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315422AbSEBVIH>; Thu, 2 May 2002 17:08:07 -0400
Subject: Re: Re[2]: Support of AMD 762?
To: ekuznetsov@divxnetworks.com
Date: Thu, 2 May 2002 22:27:11 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <732555515.20020502133225@divxnetworks.com> from "Eugene Kuznetsov" at May 02, 2002 01:32:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173O6Z-0004tr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AC> When someone volunteers to test it
> I do!

--- arch/i386/kernel/pci-irq.c~	Thu May  2 21:00:46 2002
+++ arch/i386/kernel/pci-irq.c	Thu May  2 21:00:46 2002
@@ -489,6 +489,8 @@
 	  pirq_serverworks_get, pirq_serverworks_set },
 	{ "AMD756 VIPER", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B,
 		pirq_amd756_get, pirq_amd756_set },
+	{ "AMD768", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7443,
+		pirq_amd756_get, pirq_amd756_set },
 
 	{ "default", 0, 0, NULL, NULL }
 };
