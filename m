Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266232AbRF3Rwq>; Sat, 30 Jun 2001 13:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266231AbRF3Rwg>; Sat, 30 Jun 2001 13:52:36 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:29711 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266232AbRF3Rwc>; Sat, 30 Jun 2001 13:52:32 -0400
Date: Sat, 30 Jun 2001 10:50:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steve Lord <lord@sgi.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bounce buffer deadlock 
In-Reply-To: <200106301748.f5UHmLs03109@jen.americas.sgi.com>
Message-ID: <Pine.LNX.4.33.0106301048180.1470-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Jun 2001, Steve Lord wrote:
>
> OK, sounds reasonable, time to go download and merge again I guess!

For 2.4.7 or so, I'll make a backwards-compatibility define (ie make
GFP_BUFFER be the same as the new GFP_NOIO, which is the historical
behaviour and the anally safe value, if not very efficient), but I'm
planning on releasing 2.4.6 without it, to try to flush out people who are
able to take advantage of the new extended semantics out of the
woodworks..

		Linus

