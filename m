Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSFKEYk>; Tue, 11 Jun 2002 00:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316773AbSFKEYj>; Tue, 11 Jun 2002 00:24:39 -0400
Received: from [209.237.59.50] ([209.237.59.50]:59476 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S316770AbSFKEYj>; Tue, 11 Jun 2002 00:24:39 -0400
To: Brad Hards <bhards@bigpond.net.au>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <15619.9534.521209.93822@nanango.paulus.ozlabs.org>
	<20020610.201033.66168406.davem@redhat.com>
	<52lm9m7969.fsf@topspin.com>
	<200206111416.13493.bhards@bigpond.net.au>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Jun 2002 21:24:35 -0700
Message-ID: <52heka788s.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Brad" == Brad Hards <bhards@bigpond.net.au> writes:

    Brad> Would it be enought to move the transfer buffers to the
    Brad> start of the device struct, and then pad it up to a
    Brad> cacheline?

Something like the __dma_buffer macro I posted earlier makes it even
simpler.  I'll make a patch that adds <asm/dma_buffer.h> so we have
something concrete to discuss.

Best,
  Roland

