Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbRCCAkT>; Fri, 2 Mar 2001 19:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130187AbRCCAj7>; Fri, 2 Mar 2001 19:39:59 -0500
Received: from palrel1.hp.com ([156.153.255.242]:21263 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S130180AbRCCAjt>;
	Fri, 2 Mar 2001 19:39:49 -0500
Message-Id: <200103030042.QAA00481@milano.cup.hp.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0 parisc PCI support 
In-Reply-To: Your message of "Fri, 02 Mar 2001 19:09:07 PST."
             <3AA03623.E37EEF04@mandrakesoft.com> 
Date: Fri, 02 Mar 2001 16:42:48 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik wrote:
> The patch worked 100% on my laptop, but failed to allocate a PCI memory
> region on my desktop machine.  Two attachments... "diff -u" output for
> dmesg before and after your patch, and "diff -u" output for lspci before
> and after your patch.

Jeff,
Thanks for trying. I'll rework and resubmit later.

Can you send me the complete lspci output of your desktop?
(either with or without the patch)

I'd like to pull whatever docs I can find on the offending bridge.
I'll also look at moving "transparent Bridge" support to x86
pci_fixup_bus() code (and see if I can find a machine locally
which has this same "feature").

thanks,
grant

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
