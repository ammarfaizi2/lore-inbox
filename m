Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267009AbRHSDeY>; Sat, 18 Aug 2001 23:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbRHSDeF>; Sat, 18 Aug 2001 23:34:05 -0400
Received: from waste.org ([209.173.204.2]:30293 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267009AbRHSDdz>;
	Sat, 18 Aug 2001 23:33:55 -0400
Date: Sat, 18 Aug 2001 22:33:54 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <Pine.LNX.4.33L.0108182137250.5646-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.30.0108182231030.31188-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2001, Rik van Riel wrote:

> On Sat, 18 Aug 2001, Oliver Xymoron wrote:
> > On 18 Aug 2001, Robert Love wrote:
> >
> > > obviously some people fear NICs feeding entropy provides a hazard.  for
> > > those who dont, or are increadibly low on entropy, enable the
> > > configuration option.
> >
> > Why don't those who aren't worried about whether they _really_ have
> > enough entropy simply use /dev/urandom?
>
> So how are you going to feed /dev/urandom on your firewall ??
> (which has no keyboard, program or disk activity)

The network is still feeding data to the pool, yes? It's merely
underestimating the value of that data. If you think you're getting enough
entropy for your application, use /dev/urandom, don't weaken /dev/random.

Practically speaking, /dev/urandom is pretty damn strong anyway.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

