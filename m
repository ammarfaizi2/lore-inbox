Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262325AbREROBP>; Fri, 18 May 2001 10:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbREROBF>; Fri, 18 May 2001 10:01:05 -0400
Received: from netcore.fi ([193.94.160.1]:21257 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S262325AbREROAv>;
	Fri, 18 May 2001 10:00:51 -0400
Date: Fri, 18 May 2001 17:00:42 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: <kuznet@ms2.inr.ac.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IPv6: the same address can be added multiple times
In-Reply-To: <200105141821.WAA15869@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0105181634380.23127-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001 kuznet@ms2.inr.ac.ru wrote:
> Hello!
>
> >  2) no significant restrictions (==this)
>
> When user asks to create some object, the only required thing
> of any reasonable interface is to return an error when the object
> is not added.

Please don't get stuck on that -- It wasn't the point ;-).

I pointed out KAME (and this seems to apply to IPv4 stack too) because it
would not add the same address twice.  The fact that it doesn't print out
an error message was just some wondering on the side; irrelevant from the
point of view discussed here (this duplicate error might have to special
cased in userland tools somehow though).

The command can be made print out the error message if that's what's
deemed important.


I guess BSD people have for some reason thought returning 0 on SIOCAIFADDR
for duplicates is ok.  Or perhaps it's a bug.  Investigating.

> KAME's one is broken, ours is _one_ of right ones.

I fail to see what the other right ones (ones that will actually add
an address too) are.  But that's not important. :-)

Cc: please.
-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords



