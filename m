Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269520AbRHHUyt>; Wed, 8 Aug 2001 16:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269536AbRHHUyj>; Wed, 8 Aug 2001 16:54:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48397 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269520AbRHHUyc>; Wed, 8 Aug 2001 16:54:32 -0400
Subject: Re: Determine if card is in 32 or 64 bit PCI slot?
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Wed, 8 Aug 2001 21:56:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010808161703.Q21901@sventech.com> from "Johannes Erdfelt" at Aug 08, 2001 04:17:03 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UaNj-00062K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a 64 bit PCI card which will work in either a 32 bit or 64 bit
> PCI slot.
> 
> I'd like to make the driver autodetect which kind of slot the card is
> in and set the dma_mask correctly, but I can't seem to figure out how to
> do this.

Are you sure the card actually needs this. Most such cards support dual address
cycle, so when placed in a 32bit slot  will still do 64bit DMA
