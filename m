Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbRBWCQr>; Thu, 22 Feb 2001 21:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130160AbRBWCQi>; Thu, 22 Feb 2001 21:16:38 -0500
Received: from p188.usnyc5.stsn.com ([199.106.220.188]:18951 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129339AbRBWCQ3>; Thu, 22 Feb 2001 21:16:29 -0500
Date: Wed, 21 Feb 2001 20:33:15 -0300 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: <kuznet@ms2.inr.ac.ru>
cc: Magnus Walldal <magnus.walldal@b-linc.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 under heavy network load - more info
In-Reply-To: <200102211807.VAA16020@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.31.0102212031240.21127-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001 kuznet@ms2.inr.ac.ru wrote:

> > I raised the numbers a little bit more. Now with 128MB RAM in the box we can
> > handle a maximum of 7000 connections. No more because we start to swap too
> > much.
>
> Really? Well, it is unlikely to have something with net.
> Your dumps show that at 6000 connections networking eated less
> than 10MB of memory. Probably, swapping is mistuned.

In that case, could I see some vmstat (and/or top) output of
when the kernel is no longer able to keep up, or maybe even
a way I could reproduce these things at the office ?

I'm really interested in things which make Linux 2.4 break
performance-wise since I'd like to have them fixed before the
distributions start shipping 2.4 as default.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

