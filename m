Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262229AbRENDJi>; Sun, 13 May 2001 23:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262232AbRENDJ2>; Sun, 13 May 2001 23:09:28 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49157 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262229AbRENDJR>;
	Sun, 13 May 2001 23:09:17 -0400
Date: Mon, 14 May 2001 00:09:08 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <200105140239.f4E2dNd08399@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.21.0105140007400.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2001, Richard Gooch wrote:
> Larry McVoy writes:

> > Ha.  For once you're both wrong but not where you are thinking.  One
> > of the few places that I actually hacked Linux was for exactly this
> > - it was in the 0.99 days I think.  I saved the list of I/O's in a
> > file and filled the buffer cache with them at next boot.  It
> > actually didn't help at all.
> 
> Maybe you did something wrong :-)

How about "the data loads got instrumented, but the metadata
loads which caused over half of the disk seeks didn't" ?

(just a wild guess ... if it turns out to be true we may want
to look into doing agressive readahead on inode blocks ;))

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

