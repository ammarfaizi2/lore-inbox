Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266015AbRF1QVK>; Thu, 28 Jun 2001 12:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266013AbRF1QVA>; Thu, 28 Jun 2001 12:21:00 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:62933 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S266015AbRF1QUt>; Thu, 28 Jun 2001 12:20:49 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880AD5@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: (reposting) how to get DMA'able memory within 4GB on 64-bit m
	achi ne
Date: Thu, 28 Jun 2001 10:20:46 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then why do we have 64-bit dma_addr_t on ia64 ?

-hiren

-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com]
Sent: Wednesday, June 27, 2001 2:26 PM
To: MEHTA,HIREN (A-SanJose,ex1)
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit
machi ne



MEHTA,HIREN (A-SanJose,ex1) writes:
 > Is there a way for a driver to ask kernel to
 > give DMA'able memory within 4GB ? I read about
 > pci_alloc_consistent(). But I could not find out
 > whether that guarantees the DMA'able memory to be
 > within 4GB or not. Is there any other kernel routine
 > that I should call from Driver to get such a memory ?

All of the pci_*() DMA allocation/mapping interfaces give you
32-bit PCI dma addresses.

Later,
David S. Miller
davem@redhat.com
