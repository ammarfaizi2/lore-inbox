Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265752AbRF1Nee>; Thu, 28 Jun 2001 09:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265744AbRF1NeY>; Thu, 28 Jun 2001 09:34:24 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:4100 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S265752AbRF1NeN>;
	Thu, 28 Jun 2001 09:34:13 -0400
Date: Thu, 28 Jun 2001 15:33:57 +0200 (CEST)
From: Tobias Ringstrom <tori@unhappy.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <mike_phillips@urscorp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <E15FawW-0006qI-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106281523390.1258-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Alan Cox wrote:

> > This would be extremely useful. My laptop has 256mb of ram, but every day
> > it runs the updatedb for locate. This fills the memory with the file
> > cache. Interactivity is then terrible, and swap is unnecessarily used. On
> > the laptop all this hard drive thrashing is bad news for battery life
>
> That isnt really down to labelling pages, what you are talking qbout is what
> you get for free when page aging works right (eg 2.0.39) but don't get in
> 2.2 - and don't yet (although its coming) quite get right in 2.4.6pre.

Correct, but all pages are not equal.

The problem with updatedb is that it pushes all applications to the swap,
and when you get back in the morning, everything has to be paged back from
swap just because the (stupid) OS is prepared for yet another updatedb
run.

Other bad activities include copying lots of files, tar/untar:ing and CD
writing.  They all cause unwanted paging, at least for the desktop user.

/Tobias

