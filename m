Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316593AbSEQRCJ>; Fri, 17 May 2002 13:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSEQRCI>; Fri, 17 May 2002 13:02:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33549 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316593AbSEQRCH>; Fri, 17 May 2002 13:02:07 -0400
Subject: Re: [PATCH] Page replacement documentation
To: mel@csn.ul.ie (Mel)
Date: Fri, 17 May 2002 18:22:12 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205171457580.6514-100000@skynet> from "Mel" at May 17, 2002 03:01:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178lQi-0006vU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +/*
> > > + * shink_cache - Shrinks buffer caches in a zone
> > > + * nr_pages: Helps determine if process information needs to be sweapped
> >
> > You've not tested these. They should start
> >
> 
> In this case, it was deliberate. I didn't want shrink_cache to be
> advertised on the kernel-doc because it's not a function people outside of
> vmscan.c should be calling so did not see the point in having it picked
> up.

The tools already know about internal/external/listed functions only. It
means you can do stuff like ask for only exported symbols
