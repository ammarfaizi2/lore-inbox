Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSERCPT>; Fri, 17 May 2002 22:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316627AbSERCPS>; Fri, 17 May 2002 22:15:18 -0400
Received: from h209-71-227-55.gtconnect.net ([209.71.227.55]:46600 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S316544AbSERCPQ>;
	Fri, 17 May 2002 22:15:16 -0400
Date: Fri, 17 May 2002 22:12:32 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Andrea Arcangeli <andrea@suse.de>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <20020518011410.GD29509@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0205172203380.18643-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2002, Andrea Arcangeli wrote:

> you're right if we need a make clean it's because the buildsystem is
> broken. However one thing that happens all the time to me, is that I
> change an header like mm.h or sched.h and ~everything needs to be
> rebuilt then. And since I cannot trust the current buildsystem I need to
> `make clean` first just in case somebody is getting mm.h included
> implicitly and fastdep so cannot notice it has to rebuild such object
> too. But in such case make clean doesn't hurt much because almost
> everything needs to be rebuilt anyways. Now the only regression I can
> see is that kbuild was quite slower in compiling the kernel from scrach
> (so I suspect that for me after editing mm.h it would take more time
> with kbuild2.5 to reach the vmlinux generation than it took with the old
> buildsystem after the make clean) Is that the case, or did you improved
> the performance of kbuild recently?

recently==a month ago.


	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

