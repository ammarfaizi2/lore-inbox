Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132729AbRDDCMr>; Tue, 3 Apr 2001 22:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132730AbRDDCMh>; Tue, 3 Apr 2001 22:12:37 -0400
Received: from mout1.freenet.de ([194.97.50.132]:3503 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S132729AbRDDCM3>;
	Tue, 3 Apr 2001 22:12:29 -0400
Message-ID: <002b01c0bcac$9abeb480$0a00000a@berlin.mediaplexus.com>
From: "Marcus Wegner" <marcus.wegner@mediaplexus.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: BTTV problems in 2.4.3
Date: Wed, 4 Apr 2001 04:11:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.4.3/arch/i386/kernel/pci-pc.c
linux/arch/i386/kernel/pci-pc.c
  --- linux-2.4.3/arch/i386/kernel/pci-pc.c       Sat Mar 31 00:12:41 2001
  +++ linux/arch/i386/kernel/pci-pc.c             Thu Mar 29 05:00:04 2001
  @@ -1035,7 +1035,7 @@
          { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_82C686_4,     pci_fixup_via_acpi },
          { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_8363_0,       pci_fixup_vt8363 },
          { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_82C691,       pci_fixup_via691 },
  -       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_82C598_1,     pci_fixup_via691_2 },
  +//     { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_82C598_1,     pci_fixup_via691_2 },
          { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_82371AB_3,  pci_fixup_piix4_acpi },
          { 0 }
   };


  I had the same problem. This change solved it for me.


  Marcus


