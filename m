Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270690AbRHJXzx>; Fri, 10 Aug 2001 19:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270691AbRHJXzn>; Fri, 10 Aug 2001 19:55:43 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:18189 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270690AbRHJXzZ>;
	Fri, 10 Aug 2001 19:55:25 -0400
Date: Fri, 10 Aug 2001 20:55:09 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps getting _VERY_ long
In-Reply-To: <Pine.LNX.4.33.0108101618270.1045-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0108102053140.3530-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001, Linus Torvalds wrote:

> Which brings us back to the original question, and answers it: we already
> do all of this, and we do it RIGHT. We optimize for the right things.

... and die under load.

There still are a whole number of things outstanding:

1) true low-memory deadlock prevention (memory reservations?)
2) load control, so we won't die from thrashing
3) better IO clustering, to push the thrashing point out further

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

