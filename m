Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSEXCf7>; Thu, 23 May 2002 22:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317074AbSEXCf6>; Thu, 23 May 2002 22:35:58 -0400
Received: from rj.SGI.COM ([192.82.208.96]:19661 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317073AbSEXCf6>;
	Thu, 23 May 2002 22:35:58 -0400
Date: Fri, 24 May 2002 12:35:10 +1000
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jan Kara <jack@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: Quota patches
Message-ID: <20020524123510.A180298@wobbly.melbourne.sgi.com>
In-Reply-To: <20020523091626.GA8683@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0205231002460.1006-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus,

On Thu, May 23, 2002 at 10:03:50AM -0700, Linus Torvalds wrote:
> 
> On Thu, 23 May 2002, Jan Kara wrote:
> > ... . If he has newer tools
> > (<3.05) he has to decide depending on format he wants to use...
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^

> This makes me pretty certain we just do not want to have the backwards-
> compatibility layer in 2.5.x
> 
> Are there _any_ reasons to use the old stuff, if the fix is just to
> upgrade to a newer quota tool?

Moving to newer interfaces implies use of the new ondisk format
for the quota files (exclusively) - I'd imagine that's the main
reason behind providing a choice.  Whether or not that reason is
sufficently compelling though... dunno.  If one wanted to be able
to switch between booting either 2.4 (unpatched) and 2.5+, and
also maintain quota information on filestystems, then the choice
would be useful in that situation.

cheers.

-- 
Nathan
