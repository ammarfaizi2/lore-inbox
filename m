Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273028AbRIIUXY>; Sun, 9 Sep 2001 16:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273031AbRIIUXP>; Sun, 9 Sep 2001 16:23:15 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20235 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273028AbRIIUXE>; Sun, 9 Sep 2001 16:23:04 -0400
Date: Sun, 9 Sep 2001 17:23:04 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <torvalds@transmeta.com>
Subject: Re: Purpose of the mm/slab.c changes
In-Reply-To: <001201c13942$b1bec9a0$010411ac@local>
Message-ID: <Pine.LNX.4.33L.0109091722060.21049-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Sep 2001, Manfred Spraul wrote:

> > it provides lifo allocations from both partial and unused slabs.
>
> lifo/fifo for unused slabs is obviously superflous - free is
> free, it doesn't matter which free page is used first/last.

Mind that the L2 cache is often as much as 10 times faster
than RAM, so it would be nice if we had a good chance that
the slab we just allocated would be in L2 cache.

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

