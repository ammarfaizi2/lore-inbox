Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136165AbRD0SoD>; Fri, 27 Apr 2001 14:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136168AbRD0Snx>; Fri, 27 Apr 2001 14:43:53 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:38152 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136165AbRD0Snj>; Fri, 27 Apr 2001 14:43:39 -0400
Date: Fri, 27 Apr 2001 15:43:33 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104271930070.225-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0104271541190.17635-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, Mike Galbraith wrote:

> virgin pre7 +Rik
> real    11m44.088s
> user    7m57.720s
> sys     0m36.420s

> None of them make much difference.

Good, then I suppose we can put in the cleanup from my code, since
it makes the balancing a bit more predictable and should keep the
background aging within bounds.

I'll send a fixed patch tonight (with that last small thinko you
and marcelo discovered removed).

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

