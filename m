Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAXW3T>; Wed, 24 Jan 2001 17:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130382AbRAXW3L>; Wed, 24 Jan 2001 17:29:11 -0500
Received: from moon.aladdin.de ([212.14.90.34]:11274 "EHLO moon.aladdin.de")
	by vger.kernel.org with ESMTP id <S129742AbRAXW3C>;
	Wed, 24 Jan 2001 17:29:02 -0500
Subject: another problem pre10 & ppc
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.1a (Intl) 17 August 1999
Message-ID: <OFB695B713.5C7DF23A-ONC12569DE.007B6973@aladdin.de>
From: cpg@aladdin.de
Date: Wed, 24 Jan 2001 23:25:32 +0100
X-MIMETrack: Serialize by Router on Moon/MUC/AKS(Release 5.0.5 |September 22, 2000) at
 01/24/2001 11:29:49 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring    -c -o pmac_pci.o pmac_pci.c
pmac_pci.c: In function `pmac_pci_enable_device_hook':
pmac_pci.c:550: `PCI_DEVICE_ID_APPLE_KL_USB' undeclared (first use in this function)
pmac_pci.c:550: (Each undeclared identifier is reported only once
pmac_pci.c:550: for each function it appears in.)
make[1]: *** [pmac_pci.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.1-pre10/arch/ppc/kernel'

.config file on request

regards,
chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
