Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272573AbRHaA6w>; Thu, 30 Aug 2001 20:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272574AbRHaA6c>; Thu, 30 Aug 2001 20:58:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27151 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272573AbRHaA6Y>; Thu, 30 Aug 2001 20:58:24 -0400
Date: Thu, 30 Aug 2001 17:55:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108302327.f7UNRvl04257@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.33.0108301753180.2569-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 31 Aug 2001, Peter T. Breuer wrote:
>
> To give you all something definite to look at, here's some test code:

Hmm.. This might be a good idea, actually. Have you tried whether it finds
something in the existing tree (you could just take the existing macro and
ignore the first argument)?

This would definitely be acceptable to me, and should (assuming no gcc
optimization bugs) work with no run-time overhead.

Thanks,

		Linus

