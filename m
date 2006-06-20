Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWFTOz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWFTOz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWFTOz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:55:28 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:51397 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S1751252AbWFTOz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:55:27 -0400
From: Kirill Smelkov <kirr@mns.spb.ru>
Organization: MNS
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: [PATCH] ide: disable dma for transcend CF
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <200606201452.37905.kirr@mns.spb.ru> <E1FseQD-0001Tn-00@chiark.greenend.org.uk>
In-Reply-To: <E1FseQD-0001Tn-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 20 Jun 2006 18:56:33 +0400
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200606201856.35332.kirr@mns.spb.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Sorry, Cyrillic letters were blocked on linux-ide>

Matthew Garrett wrote:
> > but if dma is turned on i get a lot of errors::
> > 
> >     hdc: dma_timer_epiry: dma_status == 0x21
> >     hdc: DMA timeout error
> >     hdc: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
> >     ide: failed opcode was: unknown
> 
> Are you sure that your CF adapter has the DMA lines hooked up? See 
> http://lkml.org/lkml/2006/5/23/198 for instance - IIRC, the kernel has 
> no way of telling whether the failure is because the card supports DMA 
> and the adapter doesn't, or whether the card is lying. If it's the 
> former, the card shouldn't be blacklisted.

No, I'm not sure.

My HW is PCISA-C800EVN-1G industrial MB (VT82C686B chipset) with integrated CF adapter.
The adapter seems to have all pins soldered.

I don't have another CF with DMA capability, so I can't check who creates the problem  --
the card or the adapter.

Let's see if someone have similar motherboard & CF with dma capabilities.

-- 
	Kirill
