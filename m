Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267912AbRHMUWj>; Mon, 13 Aug 2001 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267923AbRHMUW3>; Mon, 13 Aug 2001 16:22:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53001 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267912AbRHMUWS>; Mon, 13 Aug 2001 16:22:18 -0400
Subject: Re: Are we going too fast?
To: weber@nyc.rr.com (John Weber)
Date: Mon, 13 Aug 2001 21:24:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "John Weber" at Aug 13, 2001 03:14:13 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WOG9-0008A5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Welcome to wacky hardware. To get a G400 stable on x86 you need at least
> > 
> > XFree86 4.1 if you are running hardware 3D (and DRM 4.1)
> > 2.4.8 or higher with the VIA fixes
> > Preferably a very recent BIOS update for the VIA box
> 
> I'm sorry, but what "VIA fixes" are we referring to?

Certain VIA chipsets had some nasty bugs that caused corruption. The older
kernels have a workaround that mostly does the job but has a few side
effects. The 2.4.8 kernel has the official VIA provided workaround, which
makes sbpci128 cards work again, and sorts out some bus hangs, especially
with matrox cards
