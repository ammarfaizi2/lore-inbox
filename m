Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbRGFWGG>; Fri, 6 Jul 2001 18:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266872AbRGFWF4>; Fri, 6 Jul 2001 18:05:56 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:35327 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S266875AbRGFWFm>; Fri, 6 Jul 2001 18:05:42 -0400
Date: Fri, 6 Jul 2001 23:06:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM kill trigger fix
In-Reply-To: <Pine.LNX.4.33L.0107061817300.17825-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0107062256440.4167-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Rik van Riel wrote:
> 
> Of course, to implement this we have to count the number of
> swapcache pages, but that's a 2-liner ;)

swapper_space.nrpages already counts that (as Andrea once pointed out),
no need to add your nr_swapcache_pages.

Hugh

