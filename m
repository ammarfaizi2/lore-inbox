Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270532AbRHHRpK>; Wed, 8 Aug 2001 13:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270537AbRHHRpA>; Wed, 8 Aug 2001 13:45:00 -0400
Received: from [63.209.4.196] ([63.209.4.196]:12040 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270532AbRHHRor>; Wed, 8 Aug 2001 13:44:47 -0400
Date: Wed, 8 Aug 2001 10:43:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@us.ibm.com>
cc: Mike Kravetz <mkravetz@beaverton.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Scalable Scheduling
In-Reply-To: <OFF9CB2CBE.6FCCA7C5-ON85256AA2.005FE800@pok.ibm.com>
Message-ID: <Pine.LNX.4.33.0108081041260.8047-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Aug 2001, Hubertus Franke wrote:
>
> Linus, great input on the FLAME side, criticism accepted :-)
>
> More importantly, we wanted to get some input (particular from you)
> on whether our approach is actually an acceptable one, not
> withstanding the #ifdef's :-),

I think what the code itself tried to do looked reasonable, but it was so
distracting to read the patch that I can't make any really intelligent
comments about it.

The only thing that looked really ugly was that real-time runqueue thing.
Does it _really_ have to be done that way?

		Linus

