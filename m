Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271971AbRIIOZs>; Sun, 9 Sep 2001 10:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271972AbRIIOZj>; Sun, 9 Sep 2001 10:25:39 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:37168 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271971AbRIIOZd>; Sun, 9 Sep 2001 10:25:33 -0400
Date: Sun, 9 Sep 2001 16:26:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com
Subject: Re: Purpose of the mm/slab.c changes
Message-ID: <20010909162613.Q11329@athlon.random>
In-Reply-To: <3B9B4CFE.E09D6743@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B9B4CFE.E09D6743@colorfullife.com>; from manfred@colorfullife.com on Sun, Sep 09, 2001 at 01:05:34PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 01:05:34PM +0200, Manfred Spraul wrote:
> What's the purpose of the mm/slab.c changes?

it provides lifo allocations from both partial and unused slabs.  You
should benchmark it with a real load, not with dummy
allocations/freeing.

Andrea
