Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWI1FDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWI1FDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 01:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWI1FDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 01:03:39 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:14985 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751599AbWI1FDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 01:03:38 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002687U451b578f@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: "Jesse Barnes" <jesse.barnes@intel.com>, <akpm@osdl.org>,
       <tony.luck@intel.com>, <greg@kroah.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Date: Thu, 28 Sep 2006 14:03:22 +0900
References: <XNM1$9$0$4$$3$3$7$A$9002684U451a5f21@hitachi.com> 
    <1159359135.11049.341.camel@localhost.localdomain>
Importance: normal
Subject: Re[2]: [PATCH 2.6.18] IA64: Add pci_fixup_video into IA64 kernel
    forembedded VGA
X400-Content-Identifier: X451B578F00000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml16060928140311JPK]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ar Mer, 2006-09-27 am 20:23 +0900, ysgrifennodd
>eiichiro.oiwa.nm@hitachi.com:
>> I moved pci_fixup_video to generic location (driver/pci/quirks.c).
>> I tested generic fixup_video on x86, x86_64 and IA64, and confirmed
>> we can read Video BIOS from the sysfs rom with embedded VGA.
>
>Lots of embedded systems don't have a PCI bios in the usual sense, and
>cannot run the x86 code in the ROM firmware either. That doesn't appear
>to be a big problem when setting PCI_ROM_SHADOW but those platforms may
>not all be able to access the shadow rom if one exists.
>
>Can you fix the comment in drivers/pci/rom.c to reflect the changes.
>
>Otherwise looks good.
>
>Alan
>

Thank you for some good advise.
I changed this subject to appropriate one:
[PATCH 2.6.18] PCI: Turn pci_fixup_video into generic for embedded VGA

Thanks,
Eiichiro
