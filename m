Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272983AbRIIRWu>; Sun, 9 Sep 2001 13:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272987AbRIIRWj>; Sun, 9 Sep 2001 13:22:39 -0400
Received: from colorfullife.com ([216.156.138.34]:4620 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S272983AbRIIRWc>;
	Sun, 9 Sep 2001 13:22:32 -0400
Message-ID: <3B9BA56C.5115DFBF@colorfullife.com>
Date: Sun, 09 Sep 2001 19:22:52 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Purpose of the mm/slab.c changes
In-Reply-To: <Pine.LNX.4.33.0109090952380.14365-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> (Doing per-CPU LIFO queues for the actual page allocator would potentially
> make page alloc/de-alloc much faster due to lower locking requirements
> too. So you might have a double performance win if anybody wants to try
> this out).
>
That patch already exists - Ingo wrote it, I think it's included in some
RedHat kernels.

But Andrea's changes mainly affect UP, not SMP.
--
	Manfred
