Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbREZBgi>; Fri, 25 May 2001 21:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262504AbREZBg1>; Fri, 25 May 2001 21:36:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59398 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262432AbREZBgZ>;
	Fri, 25 May 2001 21:36:25 -0400
Date: Fri, 25 May 2001 22:35:58 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.31.0105251826290.1126-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105252235260.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Linus Torvalds wrote:

> Ok, I applied Andrea's (nee Ingo's) version, as that one most clearly
> attacked the real deadlock cause. It's there as 2.4.5 now.

But only for highmem bounce buffers. Normal GFP_BUFFER
allocations can still headlock.

> I'm going to be gone in Japan for the next week

Oh well, I guess people can always run the -ac kernel ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

