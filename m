Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTJUHgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 03:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbTJUHgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 03:36:10 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:15626 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S262993AbTJUHgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 03:36:08 -0400
Date: Tue, 21 Oct 2003 09:33:24 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: "David S. Miller" <davem@redhat.com>
cc: Martin Diehl <lists@mdiehl.de>, <noah@caltech.edu>,
       <irda-users@lists.sourceforge.net>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [irda-users] [PATCH] Make VLSI FIR depend on X86
In-Reply-To: <20031021001241.390a16df.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0310210929350.4246-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003, David S. Miller wrote:

> Here, do this, add a new interface called pci_dma_sync_to_device()
> with the appropriate args.  Add a NOP implementation to asm-i386/pci.h
> and suitable documentation changes to Documentation/DMA-mapping.txt
> 
> When you send me that patch, I'll work with the platform maintainers
> to take care of the rest.
> 
> Deal?

Ok, Thanks. Will do it.

One more question: Shouldn't the i386 implementation instead of being NOP 
just call flush_write_buffers() - at least this is what the vlsi-private 
implementation is doing at the moment?

Martin

