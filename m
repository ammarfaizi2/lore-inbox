Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315378AbSELTKo>; Sun, 12 May 2002 15:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSELTKn>; Sun, 12 May 2002 15:10:43 -0400
Received: from mark.mielke.cc ([216.209.85.42]:12292 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S315378AbSELTKm>;
	Sun, 12 May 2002 15:10:42 -0400
Date: Sun, 12 May 2002 15:04:49 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        Elladan <elladan@eskimo.com>, Alexander Viro <viro@math.psu.edu>,
        Kasper Dupont <kasperd@daimi.au.dk>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020512150449.A5622@mark.mielke.cc>
In-Reply-To: <20020512103432.A24018@eskimo.com> <Pine.GSO.4.21.0205121412160.25791-100000@weyl.math.psu.edu> <20020512113730.A24085@eskimo.com> <20020512210202.B17334@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2002 at 09:02:02PM +0200, Jakob Østergaard wrote:
> On Sun, May 12, 2002 at 11:37:30AM -0700, Elladan wrote:
> > Having unsupported security features is typically a bad idea.
> I guess the point is that it is not a security feature.
> The 5% default is good for ext2, since the filesystem will get heavily
> fragmented if you fill it up more than ~95%.  So it is a convenience
> feature.

I would place it as 'system crash avoidance' rather than 'convenience'
or 'security'.

If somebody purposefully tries to circumvent the 'system crash avoidance'
feature, well... they could just as easily have said "while (1) fork;"
and accomplished something similar.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

