Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264744AbRF1WB4>; Thu, 28 Jun 2001 18:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbRF1WBq>; Thu, 28 Jun 2001 18:01:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51101 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264744AbRF1WBj>;
	Thu, 28 Jun 2001 18:01:39 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15163.43319.82354.562310@pizda.ninka.net>
Date: Thu, 28 Jun 2001 15:01:27 -0700 (PDT)
To: Jes Sorensen <jes@sunsite.dk>
Cc: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <d33d8kbdel.fsf@lxplus015.cern.ch>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AD5@xsj02.sjs.agilent.com>
	<d33d8kbdel.fsf@lxplus015.cern.ch>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen writes:
 > >>>>> "Hiren" == MEHTA,HIREN (A-SanJose,ex1) <hiren_mehta@agilent.com> writes:
 > 
 > Hiren> Then why do we have 64-bit dma_addr_t on ia64 ?  -hiren
 > 
 > Because on ia64 you will get back a 64 bit pointer if you use
 > pci_set_dma_mask() to set a 64 bit mask before calling the pci
 > functions in question.

Please note that this is nonstandard and undocumented behavior.

This is not a supported API at all, and the way 64-bit DMA will
eventually be done across all platforms is likely to be different.

Later,
David S. Miller
davem@redhat.com
