Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130642AbRAHUkz>; Mon, 8 Jan 2001 15:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130690AbRAHUkp>; Mon, 8 Jan 2001 15:40:45 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:59388 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130642AbRAHUkh>; Mon, 8 Jan 2001 15:40:37 -0500
Date: Mon, 8 Jan 2001 18:40:21 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Linux-2.4.x patch submission policy
In-Reply-To: <20010108223343.O10035@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.21.0101081837520.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Ingo Oeser wrote:
> On Sun, Jan 07, 2001 at 02:37:47PM -0200, Rik van Riel wrote:
> > Once we are sure 2.4 is stable for just about anybody I
> > will submit some of the really trivial enhancements for
> > inclusion; all non-trivial patches I will maintain in a
> > VM bigpatch, which will be submitted for inclusion around
> > 2.5.0 and should provide one easy patch for those distribution
> > vendors who think 2.4 VM performance isn't good enough for
> > them ;)
> 
> Hmm, could you instead follow Andreas approach and have a
> directory with little patches, that do _exactly_ one thing and a
> file along to describe what is related, dependend and what each
> patch does?

I wasn't aware Andrea switched the way he stored his patches
lately ;)

But seriously, you're right that this is a good thing. I'll
work on splitting out my patches and documenting what each
part does.

(but not now, I'm headed off for Australia ... maybe I can
split out the patches on my way there and cvs commit when
I'm there)

OTOH, the advantage of having a big patch means that it's
easier for me to get people to test all of the things I
have. Guess I'll need to find a way to easily get both the
small and the big patches ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
