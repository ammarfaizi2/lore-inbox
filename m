Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSEYJNG>; Sat, 25 May 2002 05:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSEYJNF>; Sat, 25 May 2002 05:13:05 -0400
Received: from bs1.dnx.de ([213.252.143.130]:45479 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S314340AbSEYJND>;
	Sat, 25 May 2002 05:13:03 -0400
Date: Sat, 25 May 2002 11:08:30 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525110830.U598@schwebel.de>
In-Reply-To: <3CEF0157.ACF6518E@opersys.com> <Pine.LNX.4.44.0205242020010.4051-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 08:25:38PM -0700, Linus Torvalds wrote:
> With RTLinux, you have to split the app up into the "hard realtime" part
> (which ends up being in kernel space) and the "rest".
> 
> Which is, in my opinion, the only sane way to handle hard realtime. No
> confusion about priority inversions, no crap. Clear borders between what
> is "has to happen _now_" and "this can do with the regular soft realtime".

... which in turn results in the situation that applications must be
implemented as kernel modules. 

> Your claim was that RTLinux made realtime hard to do with licensing
> concerns. MY claim is that if you actually were to use RTLinux, you
> wouldn't _have_ any licensing concerns: the kernel module would have to
> be GPL (both because the kernel wants it that way _and_ because you get
> the liences to the patent that way), and the user-level code that uses
> whatever data the RT module produces is no longer hard realtime at all.

This is only correct for open-loop applications. Most real life apps are
closed-loop. 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
