Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262143AbRETTM6>; Sun, 20 May 2001 15:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262150AbRETTMj>; Sun, 20 May 2001 15:12:39 -0400
Received: from marks-43.caltech.edu ([131.215.92.43]:63647 "EHLO
	velius.chaos2.org") by vger.kernel.org with ESMTP
	id <S262149AbRETTM1>; Sun, 20 May 2001 15:12:27 -0400
Date: Sun, 20 May 2001 12:12:16 -0700 (PDT)
From: Jacob Luna Lundberg <jacob@velius.chaos2.org>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 del_timer_sync oops in schedule_timeout
In-Reply-To: <Pine.LNX.4.33.0105201945370.31113-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.32.0105201209470.4055-100000@velius.chaos2.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 May 2001, Ingo Molnar wrote:
> > Unable to handle kernel paging request at virtual address 78626970
> this appears to be some sort of DMA-corruption or other memory scribble
> problem. hexa 78626970 is ASCII "pibx", which shows in the direction of
> some sort of disk-related DMA corruption.
> we havent had any similar crash in del_timer_sync() for ages.

Ahh.  Thanks then, I'll go look hard at the disk in that box.  :)

-Jacob

-- 

Only when work uses up all energy and people are too tired to
enjoy the persuit of their passions are they ready to be reduced
to the passively receptive state suitable for television.

 - ``The Hacker Ethic'' by Pekka Himanen

