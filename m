Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273157AbRIJCXJ>; Sun, 9 Sep 2001 22:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273162AbRIJCW7>; Sun, 9 Sep 2001 22:22:59 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:37380 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273157AbRIJCWl>; Sun, 9 Sep 2001 22:22:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Manfred Spraul" <manfred@colorfullife.com>,
        "Andrea Arcangeli" <andrea@suse.de>
Subject: Re: Purpose of the mm/slab.c changes
Date: Mon, 10 Sep 2001 04:28:51 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        <torvalds@transmeta.com>
In-Reply-To: <3B9B4CFE.E09D6743@colorfullife.com> <20010909162613.Q11329@athlon.random> <001201c13942$b1bec9a0$010411ac@local>
In-Reply-To: <001201c13942$b1bec9a0$010411ac@local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910022138Z16066-26183+699@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 9, 2001 05:18 pm, Manfred Spraul wrote:
> lifo/fifo for unused slabs is obviously superflous - free is free, it
> doesn't matter which free page is used first/last.

Welll... there is a some difference with respect to the buddy allocator and 
fragmentation.  <--- nit

--
Daniel
