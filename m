Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRCWUVm>; Fri, 23 Mar 2001 15:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131419AbRCWUVb>; Fri, 23 Mar 2001 15:21:31 -0500
Received: from richard2.pil.net ([207.8.164.9]:8206 "HELO richard2.pil.net")
	by vger.kernel.org with SMTP id <S131408AbRCWUVP>;
	Fri, 23 Mar 2001 15:21:15 -0500
Date: Fri, 23 Mar 2001 15:20:41 -0500 (EST)
From: Tom Diehl <tdiehl@pil.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.21.0103231154440.29682-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.30.0103231504520.19312-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Rik van Riel wrote:

> Well, in that case you'll have to live with the current OOM
> killer.  Martin wrote down a pretty detailed description of
> what's wrong with my algorithm, if it really bothers him he
> should be able to come up with something better.
>
> Personally, I think there is more important VM code to look
> after, since OOM is a pretty rare occurrance anyway.

Well actually it is not that rare at least for me. Every 3 or 4 days I run
into it (It happened again this morning). The machine has 128 Megs of ram
and 256 Megs of swap. It is my desktop machine and I keep 3 or 4 netscape
windows running all of the time. Well I try to at least. Every 3 or 4 days
the OOM Killer kills netscape, it happened this morning. If I could fix it
I would but alas I do not have the knowledge. The best I can do is test. :(

This is NOT a complaint I just bring this up as another data point.
It used to lock the machine so things are getting better. fwiw, I am
currently running 2.4.2-ac18. The old ac kernels (do not remember exactly
which ones but it was single digits) would allow the machine to start
thrashing. I could usually see that it was running out of memory and if I
was fast enough could kill Netscape b4 the machine locked. If I was not
fast enough it would lock hard. Nothing in the logs.

HTH,

-- 
......Tom	ATA100 is another testimony to the fact that pigs can be
tdiehl@pil.net	made to fly given sufficient thrust (to borrow an RFC)
		Alan Cox lkml 11 Jan 01

