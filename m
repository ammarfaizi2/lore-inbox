Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265411AbRF0V0y>; Wed, 27 Jun 2001 17:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265412AbRF0V0p>; Wed, 27 Jun 2001 17:26:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42898 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265411AbRF0V0e>;
	Wed, 27 Jun 2001 17:26:34 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.20357.647877.80788@pizda.ninka.net>
Date: Wed, 27 Jun 2001 14:26:29 -0700 (PDT)
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit machi
	ne
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880ACE@xsj02.sjs.agilent.com>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880ACE@xsj02.sjs.agilent.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
