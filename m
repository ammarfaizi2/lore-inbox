Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262160AbRETTW2>; Sun, 20 May 2001 15:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262157AbRETTWS>; Sun, 20 May 2001 15:22:18 -0400
Received: from chiara.elte.hu ([157.181.150.200]:63502 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262160AbRETTWI>;
	Sun, 20 May 2001 15:22:08 -0400
Date: Sun, 20 May 2001 21:20:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jacob Luna Lundberg <jacob@velius.chaos2.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 del_timer_sync oops in schedule_timeout
In-Reply-To: <Pine.LNX.4.32.0105201209470.4055-100000@velius.chaos2.org>
Message-ID: <Pine.LNX.4.33.0105202119150.32188-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 May 2001, Jacob Luna Lundberg wrote:

> > > Unable to handle kernel paging request at virtual address 78626970
> > this appears to be some sort of DMA-corruption or other memory scribble
> > problem. hexa 78626970 is ASCII "pibx", which shows in the direction of
> > some sort of disk-related DMA corruption.
> > we havent had any similar crash in del_timer_sync() for ages.
>
> Ahh.  Thanks then, I'll go look hard at the disk in that box.  :)

not necesserily the disk. it can be any sort of overheating or other
thermal noise (unlikely), or SCSI/IDE cable problem (likely), or driver
problem (likely too). Disk faults typically show very different symptoms.

	Ingo

