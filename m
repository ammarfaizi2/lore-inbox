Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130198AbRAGVNW>; Sun, 7 Jan 2001 16:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRAGVNM>; Sun, 7 Jan 2001 16:13:12 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:35060 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131704AbRAGVM6>; Sun, 7 Jan 2001 16:12:58 -0500
Date: Sun, 7 Jan 2001 19:11:56 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Patch (repost): cramfs memory corruption fix
In-Reply-To: <Pine.LNX.4.10.10101071153470.27944-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101071910200.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Linus Torvalds wrote:
> On Sun, 7 Jan 2001, Alan Cox wrote:
> 
> > -ac has the rather extended ramfs with resource limits and stuff. That one
> > also has rather more extended bugs 8). AFAIK none of those are in the vanilla
> > ramfs code

> This is actually where I agree with whoever it was that said that ramfs as
> it stands now (without the limit checking etc) is much nicer simply
> because it can act as an example of how to do a simple filesystem. 
> 
> I wonder what to do about this - the limits are obviously useful, as would
> the "use swap-space as a backing store" thing be. At the same time I'd
> really hate to lose the lean-mean-clean ramfs. 

Sounds like a job for ... <drum roll> ... tmpfs!!

(and yes, I share your opinion that ramfs is nice _because_
it's an easy example for filesystem code teaching)

cheers,

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
