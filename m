Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130996AbRARBaW>; Wed, 17 Jan 2001 20:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131257AbRARBaN>; Wed, 17 Jan 2001 20:30:13 -0500
Received: from [129.94.172.186] ([129.94.172.186]:61680 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131184AbRARB35>; Wed, 17 Jan 2001 20:29:57 -0500
Date: Thu, 18 Jan 2001 12:29:52 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Xuan Baldauf <xuan--lkml@baldauf.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Relative CPU time limit
In-Reply-To: <3A65E573.D004302B@baldauf.org>
Message-ID: <Pine.LNX.4.31.0101181227221.31432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Xuan Baldauf wrote:

> is it possible with linux2.4 to limit the relative CPU time
> per process or per UID?

The (more complex) userbeans patches are IMHO something that
should wait for 2.5, but I will be "porting" my fair share
scheduler to 2.4 RSN.

The fair share scheduler I created some time ago doesn't have
a lot of configurability, isn't always fair to within the last
few percent and doesn't do some other funky things.

Instead, it changes the current Linux scheduler the minimum amount
possible and makes sure nobody can completely hog the CPU.

A version against 2.3.99 and 2.2.x is available from my home page:
	http://www.surriel.com/patches/

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
