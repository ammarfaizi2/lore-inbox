Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRBOPrV>; Thu, 15 Feb 2001 10:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129663AbRBOPrM>; Thu, 15 Feb 2001 10:47:12 -0500
Received: from [212.209.126.29] ([212.209.126.29]:30980 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129400AbRBOPrA>; Thu, 15 Feb 2001 10:47:00 -0500
Date: Thu, 15 Feb 2001 16:48:12 +0100 (CET)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Martin Rode <Martin.Rode@programmfabrik.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 crashes every two days, oopses included
In-Reply-To: <3A8BF396.7611091F@programmfabrik.de>
Message-ID: <Pine.LNX.4.31.0102151645110.25331-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.31.0102151645112.25331@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2001, Martin Rode wrote:

> My last bug report did not seem to attract to much attention.

> For now we have switched back to 2.2.18 which stays up for about
> a week before it crashes because of the VM too.

[snip]
> VM: reclaim_page, wrong page on list.
> VM: refill_inactive, wrong page on list.
> Unable to handle kernel paging request at virtual address 00002208

Since:
1. you see this kind of bug with both 2.2 and the completely
   changed 2.4 VM code  and
2. this bug usually only happens when people have RAM problems,

could you try running memtest86 on that machine to see if it indeed
has memory errors or if the problem is coming from somewhere else ?

thanks,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

