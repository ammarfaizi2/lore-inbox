Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283071AbRLDMMT>; Tue, 4 Dec 2001 07:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283064AbRLDMMJ>; Tue, 4 Dec 2001 07:12:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55313 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283054AbRLDML6>; Tue, 4 Dec 2001 07:11:58 -0500
Subject: Re: misc_cache_init
To: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 4 Dec 2001 12:20:15 +0000 (GMT)
Cc: fcorneli@elis.rug.ac.be (Frank Cornelis),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing list)
In-Reply-To: <20011204110435.C18147@flint.arm.linux.org.uk> from "Russell King" at Dec 04, 2001 11:04:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BEYZ-0001vX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We already have this under a slightly different name (Alan didn't merge it
> into Linus' kernel though from what I remember): pgtable_cache_init.

I started merging it then Linus said no more low priority bits

> This was used in -ac to initialise the ARM PTE slab, as well as the x86
> PAE slabs immediately after the call to kmem_cache_sizes_init.

its in Marcelo's tree I believe.
