Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137149AbREKOYZ>; Fri, 11 May 2001 10:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137150AbREKOYP>; Fri, 11 May 2001 10:24:15 -0400
Received: from 069up090.chartermi.net ([24.247.69.90]:23716 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S137149AbREKOYB>; Fri, 11 May 2001 10:24:01 -0400
Date: Fri, 11 May 2001 10:23:53 -0400
From: Simon Kirby <sim@netnation.com>
To: Dan Mann <daniel_b_mann@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c590 vs. tulip
Message-ID: <20010511102353.A11468@netnation.com>
In-Reply-To: <OE73aZbF27y4RbrxUrO000014d0@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <OE73aZbF27y4RbrxUrO000014d0@hotmail.com>; from daniel_b_mann@hotmail.com on Fri, May 11, 2001 at 09:27:29AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 09:27:29AM -0400, Dan Mann wrote:

> The server has lots (ok, about 20,000 not counting the os itself) of medium
> sized files on it, ranging in size from 60k to 40MB.  When I run gqview
> (image viewing program) on the client and point to a local directory that is
> mapped to the server using samba, the images (over 4000 in one directory)
> are displayed absolutely as fast as I can click my mouse button.  No lag
> time whatsoever.  How can this be so fast?  Even with the images on my local
> faster machine it is much slower.  Images take at least .5 to 1 second to
> load when they are stored locally.  But over the network, with 2.4.4 and
> samba 2.2, It's as if the server "knows" what I'm going to ask for before I
> actually do.  Is this normal?  I honestly don't think it was this fast when
> server was on 2.2 Kernel with samba 2.07.

Note that the newer gqviews preload the "next" image (next based on your
previous clicking direction).  If you are clicking sequentially and give
it enough time between images, it will immediately display the next image
when you click on it.

I don't see how even if it were any sort of caching bug or something that
gqview would be able to load them that much faster -- it still has to
decode them at one point or another.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
