Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUC3WgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUC3WgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:36:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23428 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261468AbUC3Wfp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:35:45 -0500
Message-ID: <4069F631.4070405@pobox.com>
Date: Tue, 30 Mar 2004 17:35:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: akpm@osdl.org, greg@kroah.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add PCI_DMA_{64,32}BIT constants
References: <20040323052305.GA2287@havoc.gtf.org> <20040329223604.63d981d0.rddunlap@osdl.org>
In-Reply-To: <20040329223604.63d981d0.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 23 Mar 2004 00:23:05 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> | 
> | Been meaning to do this for ages...
> | 
> | Another one for the janitors.
> 
> 
>>>>Nice, I've pulled this to my pci tree and will forward it on to Linus in
>>>>the next round of pci patches after 2.6.5 is out.
>>>
>>>Yeah well...  in the intervening time, somebody on IRC commented
>>>
>>>"so what is so PCI-specific about those constants?"
>>>
>>>They probably ought to be DMA_{32,64}BIT_MASK or somesuch.
>>
>>
>>Heh, ok, care to make up another patch for this?  :)
> 
> 
> 
> Here's an updated patch, applies to 2.6.5-rc2-bk9.
> I left the DMA_xxBIT_MASK defines in linux/pci.h, although
> they aren't necessarily PCI-specific.  Would we prefer to
> have them in linux/dma-mapping.h ?


Put them whereever the DMA direction constants are, I suppose...

	Jeff



