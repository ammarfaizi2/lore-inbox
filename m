Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSGDVxB>; Thu, 4 Jul 2002 17:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSGDVxB>; Thu, 4 Jul 2002 17:53:01 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11475 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S313711AbSGDVxA>; Thu, 4 Jul 2002 17:53:00 -0400
Date: Thu, 4 Jul 2002 23:55:09 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 IDE 97
In-Reply-To: <20020704175126.29120@192.168.4.1>
Message-ID: <Pine.SOL.4.30.0207042353140.7744-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jul 2002, Benjamin Herrenschmidt wrote:

> >My tuning scheme satisfies your both demands, by ch->dma_base,
> >ch->autodma and ch->modes_map host informs generic code about its
> >capabilities.
>
> Just keep in mind that some chipsets don't use dma_base
> but still can do DMA (typically ide-pmac, and some embedded
> controllers). They do DMA their own way, not using the PRD
> tables. Actually, I would love beeing able to use that same
> dma_base (and others) fields for my own stuffs, but the common
> layer, last I looked at it, still does assumptions that when
> those are filled, they match a legacy controller.
>
> Ben.

Yep, I'm aware of them.

--
Bartlomiej

