Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSC1PU3>; Thu, 28 Mar 2002 10:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313180AbSC1PUT>; Thu, 28 Mar 2002 10:20:19 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34276 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313181AbSC1PUH>;
	Thu, 28 Mar 2002 10:20:07 -0500
Date: Thu, 28 Mar 2002 10:20:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Nikita Danilov <Nikita@Namesys.COM>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <15523.11788.516552.132449@laputa.namesys.com>
Message-ID: <Pine.GSO.4.21.0203280957130.24447-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Mar 2002, Nikita Danilov wrote:

>  > If your structure will be written on disk you'd better have full control
>  > over alignment - otherwise you are risking incompatibilities between
>  > platforms and compiler versions.
> 
> Yes, but such experience frequently is only gained after format is
> already carved in stone^Wdisk.

Or after reading through a FAQ or two.  Not to mention any half-decent
textbook on C from mid-80s or later...


