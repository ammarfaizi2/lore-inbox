Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135912AbREIIqk>; Wed, 9 May 2001 04:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135913AbREIIqY>; Wed, 9 May 2001 04:46:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38152 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135912AbREIIpc>; Wed, 9 May 2001 04:45:32 -0400
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
To: tleete@mountain.net (Tom Leete)
Date: Wed, 9 May 2001 09:49:28 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3AF8A73A.C02F119E@mountain.net> from "Tom Leete" at May 08, 2001 10:11:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xPf0-0001pn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What still stands out is that exactly _zero_ people have reported the same
> > problem with non VIA chipset Athlons.
> 
> Not any more :-(

Still the same

> IIRC this thread is about boot going catatonic right after unloading
> __initmem.

Nope. Its about memory corruptions. Your bug sounds very different

> Earlier, it looks like handle_mm_fault is being triggered from
> fast_clear_page.

That would be messy. The other way around is sane but not that way
