Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271552AbRIBDVt>; Sat, 1 Sep 2001 23:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271555AbRIBDVj>; Sat, 1 Sep 2001 23:21:39 -0400
Received: from www.wen-online.de ([212.223.88.39]:54277 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S271552AbRIBDVW>;
	Sat, 1 Sep 2001 23:21:22 -0400
Date: Sun, 2 Sep 2001 05:21:12 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
In-Reply-To: <20010901205401.158577a1.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0109020518590.510-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2001, Stephan von Krawczynski wrote:

> On Sat, 1 Sep 2001 10:26:48 +0200 (CEST) Mike Galbraith <mikeg@wen-online.de>
> wrote:
>
> > On Sat, 1 Sep 2001, Daniel Phillips wrote:
> >
> > > Better go back and read the thread.  The allocation rate is definitely
> > > limited - he's doing a cd burn and some network copies.  [....]
> >                          ^^^^^^^
> > P.S.
> > Stephan:  try unconditionally doing gfp_mask &= ~__GFP_WAIT at the top
> > of page_launder().  I think that will help your problem some.
>
> Hi Mike,
>
> I tried, doesn't make a difference. Same number of alloc-fails.
> Sorry.

Darn.  Scratch one theory.

