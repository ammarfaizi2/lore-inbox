Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbSKTH5y>; Wed, 20 Nov 2002 02:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbSKTH5y>; Wed, 20 Nov 2002 02:57:54 -0500
Received: from netrealtor.ca ([216.209.85.42]:60932 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262882AbSKTH5x>;
	Wed, 20 Nov 2002 02:57:53 -0500
Date: Wed, 20 Nov 2002 03:12:15 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Rik van Riel <riel@conectiva.com.br>
Cc: David McIlwraith <quack@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: spinlocks, the GPL, and binary-only modules
Message-ID: <20021120081215.GC26018@mark.mielke.cc>
References: <024101c2903f$7650a050$41368490@archaic> <Pine.LNX.4.44L.0211200105090.4103-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211200105090.4103-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 01:06:39AM -0200, Rik van Riel wrote:
> On Wed, 20 Nov 2002, David McIlwraith wrote:
> > How should it? The compiler (specifically, the C preprocessor) includes
> > the code, thus it is not the AUTHOR violating the GPL.
> If the compiler includes a .h file, it happens because
> the programmer told it to do so, using a #include.

I was recently re-reading the GPL and I came to the following conclusion:

The GPL is only an issue if the software is *distributed* with GPL
software. Meaning -- it is not legal to distribute a linux kernel that
contains non-GPL code, however, it *is* legal for an administrator to
install linux, and then download a copy of the dynamically linked
module from a separate web site, under a different (incompatible)
license, and load it into the kernel. This new kernel image is a
'derived work', however, as long as the new kernel image is not
distributed to 'the public', the GPL terms do *not* come into play.

While I believe my understanding on this issue to be correct, I still
haven't answered the original question... is it legal to distribute a
non-GPL binary that used a GPL header file to be compiled? Is the
answer to this different depending on the amount of code that is
generated using the GPL header file as source (i.e. inlined
functions)?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

