Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276313AbRJCOLx>; Wed, 3 Oct 2001 10:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276314AbRJCOLn>; Wed, 3 Oct 2001 10:11:43 -0400
Received: from web14803.mail.yahoo.com ([216.136.224.219]:21260 "HELO
	web14803.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276313AbRJCOLb>; Wed, 3 Oct 2001 10:11:31 -0400
Message-ID: <20011003141156.17014.qmail@web14803.mail.yahoo.com>
Date: Wed, 3 Oct 2001 07:11:56 -0700 (PDT)
From: Linux Bigot <linuxopinion@yahoo.com>
Subject: how to get virtual address from dma address
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All programmers

I am relatively new to linux kernel. Please advise
what is the safe way to get the original virtaul
address from dma address e.g., 


dma_addr = pci_map_single(dev, vaddr, sizeof(struct
some), PCI_DMA_BIDIRECTIONAL);

issue_command_to_the_controller();

my_isr()
{
    struct some *some;

    dma_addr = this_address_completed();

--->some = how_to_get_from_dma_addr(dma_addr);
}

Would ioremap work.

TIA
   


__________________________________________________
Do You Yahoo!?
Listen to your Yahoo! Mail messages from any phone.
http://phone.yahoo.com
