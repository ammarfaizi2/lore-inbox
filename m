Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264071AbRF1TmA>; Thu, 28 Jun 2001 15:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264080AbRF1Tlv>; Thu, 28 Jun 2001 15:41:51 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:30981 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S264071AbRF1Tlh>;
	Thu, 28 Jun 2001 15:41:37 -0400
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'David S. Miller'" <davem@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AD5@xsj02.sjs.agilent.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 28 Jun 2001 21:41:22 +0200
In-Reply-To: "MEHTA,HIREN's message of "Thu, 28 Jun 2001 10:20:46 -0600"
Message-ID: <d33d8kbdel.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Hiren" == MEHTA,HIREN (A-SanJose,ex1) <hiren_mehta@agilent.com> writes:

Hiren> Then why do we have 64-bit dma_addr_t on ia64 ?  -hiren

Because on ia64 you will get back a 64 bit pointer if you use
pci_set_dma_mask() to set a 64 bit mask before calling the pci
functions in question.

Jes
