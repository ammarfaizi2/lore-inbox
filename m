Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269702AbUJAICa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269702AbUJAICa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 04:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269723AbUJAICa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 04:02:30 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:63971 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S269702AbUJAICZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 04:02:25 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 1 Oct 2004 09:41:35 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org, greg@kroah.com
Subject: Re: [PATCH 2.6.9-rc2-mm4 zr36120.c][5/8] Convert pci_find_device	to pci_dev_present
Message-ID: <20041001074135.GB31175@bytesex>
References: <19730000.1096496900@w-hlinder.beaverton.ibm.com> <1096496127.16721.10.camel@localhost.localdomain> <24740000.1096500358@w-hlinder.beaverton.ibm.com> <20040930082748.GC20456@bytesex> <56140000.1096583304@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56140000.1096583304@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks a lot for your help. Is this what you were thinking?

> +++ linux-2.6.9-rc2-mm4patch/drivers/media/video/zr36120.c	2004-09-30 15:17:56.201723784 -0700

> -	while ((dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437, dev)))
> -	{
> +	if (pci_pci_problems & PCIPCI_TRITON) {
>  		printk(KERN_INFO "zoran: Host bridge 82437FX Triton PIIX\n");
>  		triton1 = ZORAN_VDC_TRICOM;

Looks fine to me.

  Gerd

-- 
return -ENOSIG;
