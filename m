Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbRE3Sn0>; Wed, 30 May 2001 14:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbRE3SnQ>; Wed, 30 May 2001 14:43:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59921 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261823AbRE3SnA>;
	Wed, 30 May 2001 14:43:00 -0400
Date: Wed, 30 May 2001 15:42:51 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: andrea@e-mind.com
Cc: Mark Hemment <markhe@veritas.com>, Jens Axboe <axboe@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, cut three
In-Reply-To: <20010530162607.D1408@athlon.random>
Message-ID: <Pine.LNX.4.21.0105301542210.12540-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001 andrea@e-mind.com wrote:

> btw, I think such heuristic is horribly broken ;), the highmem zone
> simply needs to be balanced if it is under the pages_low mark, just
> skipping it and falling back into the normal zone that happens to be
> above the low mark is the wrong thing to do.

2.3.51 did this, we all know the result.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

