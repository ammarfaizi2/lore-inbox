Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135522AbRDSC1c>; Wed, 18 Apr 2001 22:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135523AbRDSC1V>; Wed, 18 Apr 2001 22:27:21 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:59396 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S135521AbRDSC1Q>;
	Wed, 18 Apr 2001 22:27:16 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), modica@sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: Proposal for a new PCI function call
In-Reply-To: <E14nrdT-0001po-00@the-village.bc.nu>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 19 Apr 2001 04:27:04 +0200
In-Reply-To: Alan Cox's message of "Fri, 13 Apr 2001 01:40:25 +0100 (BST)"
Message-ID: <d31yqpzksn.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Introducing a new function that takes bit flags as arguments might
>> be better?

Alan> pci_set_dma_mask_bits() ? So you could do

Alan> pci_set_dma_mask_bits(pdev, 64);

Alan> We want everything to go through pci_set_dma_mask... type
Alan> functions either way so that we can and the mask with upstream
Alan> bridges when we hit address range limits in some peoples
Alan> hardware

Looks good to me

Jes
