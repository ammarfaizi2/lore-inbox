Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272887AbRIGWp0>; Fri, 7 Sep 2001 18:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272877AbRIGWpS>; Fri, 7 Sep 2001 18:45:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9223 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272887AbRIGWpH>; Fri, 7 Sep 2001 18:45:07 -0400
Date: Fri, 7 Sep 2001 15:41:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Morten Welinder <terra@diku.dk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Type checking MIN with standard interface
In-Reply-To: <20010906192815.28608.qmail@ntyr.diku.dk>
Message-ID: <Pine.LNX.4.33.0109071540180.15361-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Sep 2001, Morten Welinder wrote:
>
> All the silent-cast properties of integer types do not apply to
> pointers.  Therefore...

Ok, we have a winner. Nice (and more understandable) warning message,
along with strict type-checking.

I'm happy. Will do this for 2.4.10-pre5.

		Linus

