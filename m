Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276074AbRJPMdO>; Tue, 16 Oct 2001 08:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276099AbRJPMdE>; Tue, 16 Oct 2001 08:33:04 -0400
Received: from [213.237.118.153] ([213.237.118.153]:38784 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S276074AbRJPMcn>;
	Tue, 16 Oct 2001 08:32:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre3aa1
Date: Tue, 16 Oct 2001 14:30:43 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <20011016110708.D2380@athlon.random>
In-Reply-To: <20011016110708.D2380@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15tTMq-0000E6-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 October 2001 11:07, Andrea Arcangeli wrote:
> Only in 2.4.13pre2aa1: 00_lvm-1.0.1-rc4-1.bz2
> Only in 2.4.13pre3aa1: 00_lvm-1.0.1-rc4-2.bz2
>
> 	Rediffed merging the unsigned long change in the blkdev size ioctl.
>
> Only in 2.4.13pre2aa1: 00_vm-3.1
> Only in 2.4.13pre3aa1: 00_vm-3.2
>
> 	Further vm minor updates. In particular make sure not to overstimate
> 	the amount of buffers available during balance_dirty(), by using the
> 	exact per-classzone active/inactive info.
>
> Only in 2.4.13pre2aa1: 50_uml-patch-2.4.12-1-1.bz2
> Only in 2.4.13pre3aa1: 50_uml-patch-2.4.12-3-1.bz2
>
> 	Latest update from Jeff.
>
> Only in 2.4.13pre2aa1: 60_tux-2.4.10-ac10-F5.bz2
> Only in 2.4.13pre3aa1: 60_tux-2.4.10-ac12-H1.bz2
>
> 	Latest update from Ingo.
>
> Andrea

I was expecting a more serious bug-fix. I recently upgraded my kernel from 
2.4.11pre1 to 2.4.13-pre2aa1. Now anacron "kill"s the machine every morning 
by starting updatedb. Basicly everything swaps out. If I don't touch the 
mouse for 3 seconds, it will take 15 seconds to respond next time I touch it. 
Switching between desktops in KDE, takes from 3 to 10 minutes, and updatedb 
never seems to complete, I have had to kill it manually every time so far. I 
had similar problems every morning with 2.4.9 although not as bad, but I 
havent seen them before in 2.4.10 and later.
The problem is easily replicable, I just need to run updatedb. Would you like 
some statistics and which?

regards
`Allan
