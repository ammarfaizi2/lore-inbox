Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135520AbRDSC1L>; Wed, 18 Apr 2001 22:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135521AbRDSC1C>; Wed, 18 Apr 2001 22:27:02 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:51204 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S135520AbRDSC0w>;
	Wed, 18 Apr 2001 22:26:52 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, modica@sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: Proposal for a new PCI function call
In-Reply-To: <3AD601B4.7E0B14E4@sgi.com> <3AD604B0.2713F08B@mandrakesoft.com> <d3vgo9ej5r.fsf@lxplus015.cern.ch> <3AD7A6ED.7626BE05@mandrakesoft.com>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 19 Apr 2001 04:25:59 +0200
In-Reply-To: Jeff Garzik's message of "Fri, 13 Apr 2001 21:25:01 -0400"
Message-ID: <d366g1zkug.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

Jeff> Jes Sorensen wrote:
>> Hmmm, I was wondering if could come up with a pretty way to do this
>> on 32 bit boxes that wants to enable highmem DMA. Right now
>> pci_set_dma_mask() wants a dma_addr_t which means you have to do
>> #ifdef CONFIG_HIGHMEM <blah> #else <bleh> #endif.

Jeff> It seems to me that not doing #ifdef CONFIG_HIGHMEM right now is
Jeff> a bug...  I think it's the megaraid driver that wants to set
Jeff> dma_addr_t to a 64-bit mask.

There's a bunch of them doing it - it's butt-ugly though.

Jes
