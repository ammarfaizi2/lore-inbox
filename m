Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268154AbUHXSPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268154AbUHXSPX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUHXSPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:15:23 -0400
Received: from proxy.hsp-law.de ([62.48.88.110]:58502 "EHLO gjba.hsp-law.de")
	by vger.kernel.org with ESMTP id S268154AbUHXSPU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:15:20 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ralf Gerbig <rge-news@quengel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ACPI interrupt routing
References: <m0isb9ispy.fsf@test3.hsp-law.de>
	<200408241047.54796.bjorn.helgaas@hp.com>
From: Ralf Gerbig <rge@hsp-law.de>
Date: Tue, 24 Aug 2004 20:15:16 +0200
In-Reply-To: <200408241047.54796.bjorn.helgaas@hp.com> (Bjorn Helgaas's
 message of "Tue, 24 Aug 2004 10:47:54 -0600")
Message-ID: <m0vff8pfm3.fsf@test3.hsp-law.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

* Bjorn Helgaas:

>> ACPI: PCI interrupt 0000:01:06.1[A] -> GSI 18 (level, high) -> IRQ 18 
>> bt878(0): Bt878 (rev 17) at 01:06.1, irq: 10, <==================================== 
 
> Can you try this patch, please?  The bt878 driver has the classic problem 
> of looking at pci_dev->irq before pci_enable_device(). 

yep, gets assigned IRQ 18 and works.

Thanks,

Ralf
-- 
Ralf Gerbig			// P:     Linus Torvalds
Dr. Heinz Schäfer & Partner	//-S:     Buried alive in diapers
				//+S:     Buried alive in reporters
				   patch-2.2.4
