Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289725AbSAJV7S>; Thu, 10 Jan 2002 16:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289723AbSAJV7J>; Thu, 10 Jan 2002 16:59:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48077 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289722AbSAJV6w>;
	Thu, 10 Jan 2002 16:58:52 -0500
Date: Fri, 11 Jan 2002 00:56:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <20020110200446.A695@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.33.0201110055480.10579-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, Ivan Kokshaysky wrote:

> Note that comment for this function is a bit confusing:
>  * ... It's the fastest
>  * way of searching a 168-bit bitmap where the first 128 bits are
>  * unlikely to be set.
>
> s/set/cleared/

no, it's really 'cleared'. The bits are inverted right now.

	Ingo

