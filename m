Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSIPWq7>; Mon, 16 Sep 2002 18:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbSIPWq7>; Mon, 16 Sep 2002 18:46:59 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:31925 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S263280AbSIPWq6>; Mon, 16 Sep 2002 18:46:58 -0400
Date: Mon, 16 Sep 2002 15:51:56 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Oliver Xymoron <oxymoron@waste.org>
cc: David Wagner <daw@mozart.cs.berkeley.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <20020909194707.GB31597@waste.org>
Message-ID: <Pine.LNX.4.44.0209161541430.3465-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Oliver Xymoron wrote:

> making the RNG guessable is relatively easy. On the other hand
> determining whether a given snippet of code is doing RSA, etc. is
> equivalent to solving the halting problem, so it's seems to me pretty
> damn hard to usefully put this sort of back door into a CPU without
> sacrificing general-purpose functionality.

while the general problem is certainly halting-problem level of
complexity, there's a much more simple problem which amounts to string
matching.  the simple problem is "is this a specific portion of openssl /
cryptoapi / whatever?"

if you consider a technology like transmeta's which only has to
compile/translate code infrequently (rather than a traditional technology
with decoders running all the time) then it's pretty easy to see how you
could use a few cycles to do the string matching.

people have been doing this in compilers for years, where the string
matching question is "is this part of SPECCPU?"

-dean

