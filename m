Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130299AbRAEBMC>; Thu, 4 Jan 2001 20:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbRAEBLw>; Thu, 4 Jan 2001 20:11:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4612 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130535AbRAEBLl>; Thu, 4 Jan 2001 20:11:41 -0500
Date: Thu, 4 Jan 2001 17:11:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: And oh, btw..
In-Reply-To: <Pine.LNX.4.21.0101042050421.1453-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101041709110.1249-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Marcelo Tosatti wrote:
>
> I have 1 patch which has not been answered and I still dont know if you
> want it only for 2.5.

The swap clustering looks ok, but it also looked like something I could
safely delay until a bit later in the 2.4.x series. Basically, the
PageDirty handling is new enough that I didn't want to add any other
wrinkles on top of it, even if they looked clean..

Life does not end at 2.4.0. Think o fit more as a "no more excuses"
release.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
