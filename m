Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265801AbRFXXqs>; Sun, 24 Jun 2001 19:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265802AbRFXXqi>; Sun, 24 Jun 2001 19:46:38 -0400
Received: from Expansa.sns.it ([192.167.206.189]:9233 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S265801AbRFXXqd>;
	Sun, 24 Jun 2001 19:46:33 -0400
Date: Mon, 25 Jun 2001 01:46:21 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>,
        <linux-kernel@vger.kernel.org>
Subject: Re: GCC3.0 Produce REALLY slower code!
In-Reply-To: <Pine.LNX.4.33L.0106241947230.23112-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106250142070.1314-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Jun 2001, Rik van Riel wrote:

> On Mon, 25 Jun 2001, Alexander V. Bilichenko wrote:
>
> > Some tests that I have recently check out. kernel compiled with
> > 3.0 (2.4.5) function call: 1000000 iteration. 3% slower than
> > 2.95. test example - hash table add/remove - 4% slower (compiled
> > both with -O2 -march=i686).
>
> > Why have this version been released?
>
> It would be better to ask that to the GCC people, but I
> suspect it was released because it was (almost) stable
> and the only way to do the last small tweaks to the code
> would be to have it tested in the field ?
>
Actually I think the just one very good reason to use gcc 3.0 is if you
are programming using C++. It's a kind of paradise for C++ programmers.
So I had to install it on my servers used by C++ programmers, they were
so happy...
To use C, it's better to avoid gcc 3.0, it's just slower.
All bench i did, it's slower about 3/5% depending on the kind of code.
It is faster just on some floating point with really small
code, (I used optimizzations for athlon CPU).

Luigi



