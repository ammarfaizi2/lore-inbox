Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313264AbSEJSkf>; Fri, 10 May 2002 14:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313568AbSEJSke>; Fri, 10 May 2002 14:40:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59278 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313264AbSEJSkd>;
	Fri, 10 May 2002 14:40:33 -0400
Date: Fri, 10 May 2002 11:39:48 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: re: Tcp/ip offload card driver
Message-ID: <Pine.LNX.4.33.0205101130080.11400-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    > For example, do a SpecWEB run with TUX both using on-chip-TCP and
>    > without, same networking card.  Show a demonstrable gain from the
>    > on-chip-TCP implementation.  I bet you can't.
> 
>    NO! Doing such a test sets you up for a failure. If a vendor
>    of the card provides an on-chip TCP, it is entirely in the
>    vendor's interest to penalize regular TCP (for example, by
>    failing to provide checksum offload or sane S/G segments).
> 
>    I only consider fair a test of on-chip TCP compared to
>    the best of the normal NICs.
 
> Sorry, I should have stated this explicitly.  The same card
> must have SG/Checksumming capability for the no-TCP-onchip portion of
> the test.

Not to belabor the point, but most SpecWeb runs also turn off features
like timestamps, window scaling, sack, etc. ie. things you sometimes
need in the real world. 

That's representative of the problem, really. They could probably
work up a fw/hw implementation for a specific workload, benchmark...

Its much harder to be general purpose, feature rich, fully compliant
in hw than in sw. 

thanks,
Nivedita

