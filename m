Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318657AbSHAIBW>; Thu, 1 Aug 2002 04:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318658AbSHAIBV>; Thu, 1 Aug 2002 04:01:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5134 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318657AbSHAIBV>; Thu, 1 Aug 2002 04:01:21 -0400
Date: Thu, 1 Aug 2002 04:14:01 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jens Axboe <axboe@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: Linux v2.4.19-rc5
In-Reply-To: <20020801074953.GJ1644@suse.de>
Message-ID: <Pine.LNX.4.44.0208010406230.1728-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Aug 2002, Jens Axboe wrote:

> On Thu, Aug 01 2002, Marcelo Tosatti wrote:
> > <akpm@zip.com.au> (02/08/01 1.663)
> > 	[PATCH] disable READA
>
> Since -rc5 is not to be found yet, I don't know what version of this
> made it in. Is READA just being disabled on SMP, or was it the general
> #if 0 change that got included?

Its being disabled on UP and SMP. I dont like having such readahead IO
mode working only for UP.

> I'm asking since plain disabling READA might have nasty performance
> effects. Andrew, I bet you did some numbers on this, care to share?

If thats true (the performance effects) I'll release -final with IMO not
very coherent READA semantics :)

Anyway, lets wait for the numbers.




