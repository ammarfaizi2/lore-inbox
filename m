Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbRGKPtd>; Wed, 11 Jul 2001 11:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267337AbRGKPtY>; Wed, 11 Jul 2001 11:49:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:53831 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267334AbRGKPtC>; Wed, 11 Jul 2001 11:49:02 -0400
Date: Wed, 11 Jul 2001 17:49:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
Message-ID: <20010711174913.E3496@athlon.random>
In-Reply-To: <200107110849.f6B8nlm00414@df1tlpc.local.here> <shslmlv62us.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shslmlv62us.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Jul 11, 2001 at 02:56:43PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 02:56:43PM +0200, Trond Myklebust wrote:
> >>>>> " " == Klaus Dittrich <kladit@t-online.de> writes:
> 
>      > Kernel: 2.4.7p5 or 2.4.7p6 System: PII-SMP, BX-Chipset
> 
>      > The kernel boots up to the message
> 
>      > ..  Linux NET4.0 for Linux 2.4 Based upon Swansea University
>      > Computer Society NET3.039
> 
>      > and then stops.
> 
>      > I actually use 2.4.7p3 without problems.
> 
> I have the same problem on my setup. To me, it looks like the loop in
> spawn_ksoftirqd() is suffering from some sort of atomicity problem.

can you reproduce with 2.4.7pre5aa1?

Andrea
