Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269631AbRHHXVO>; Wed, 8 Aug 2001 19:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269630AbRHHXVE>; Wed, 8 Aug 2001 19:21:04 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:5128 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269632AbRHHXUy>; Wed, 8 Aug 2001 19:20:54 -0400
Date: Wed, 8 Aug 2001 16:20:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.10.10108082314410.10284-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0108081620250.10337-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Aug 2001, Mark Hahn wrote:
>
> > Your change in pre7 makes zone_inactive_shortage() not return the shortage
> > size, which is needed by refill_inactive().
>
> similar for zone_free_shortage used in total_free_shortage I think.

No, they are just booleans.

		Linus

