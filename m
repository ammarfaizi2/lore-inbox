Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSELTCF>; Sun, 12 May 2002 15:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315378AbSELTCE>; Sun, 12 May 2002 15:02:04 -0400
Received: from unthought.net ([212.97.129.24]:37784 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S315375AbSELTCC>;
	Sun, 12 May 2002 15:02:02 -0400
Date: Sun, 12 May 2002 21:02:02 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Elladan <elladan@eskimo.com>
Cc: Alexander Viro <viro@math.psu.edu>, Kasper Dupont <kasperd@daimi.au.dk>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020512210202.B17334@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Elladan <elladan@eskimo.com>, Alexander Viro <viro@math.psu.edu>,
	Kasper Dupont <kasperd@daimi.au.dk>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020512103432.A24018@eskimo.com> <Pine.GSO.4.21.0205121412160.25791-100000@weyl.math.psu.edu> <20020512113730.A24085@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2002 at 11:37:30AM -0700, Elladan wrote:
...
Ok, thanks for the explanation earlier in the thread. I was mistaken.

> 
> Regardless of whether it's a good thing to depend on security-wise, it
> is a problem to have something that appears to be a security feature
> which doesn't actually work.
...
> Having unsupported security features is typically a bad idea.

I guess the point is that it is not a security feature.

The 5% default is good for ext2, since the filesystem will get heavily
fragmented if you fill it up more than ~95%.  So it is a convenience
feature.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
