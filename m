Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283244AbRL2PPk>; Sat, 29 Dec 2001 10:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283268AbRL2PPV>; Sat, 29 Dec 2001 10:15:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29517 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S283244AbRL2PPQ>; Sat, 29 Dec 2001 10:15:16 -0500
Date: Sat, 29 Dec 2001 16:15:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20011229161537.F1356@athlon.random>
In-Reply-To: <3C2CD326.100@athlon.maya.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C2CD326.100@athlon.maya.org>; from andihartmann@freenet.de on Fri, Dec 28, 2001 at 09:16:38PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 09:16:38PM +0100, Andreas Hartmann wrote:
> Hello all,
> 
> Again, I did a rsync-operation as described in
> "[2.4.17rc1] Swapping" MID <3C1F4014.2010705@athlon.maya.org>.
> 
> This time, the kernel had a swappartition which was about 200MB. As the 
> swap-partition was fully used, the kernel killed all processes of knode.
> Nearly 50% of RAM had been used for buffers at this moment. Why is there 
> so much memory used for buffers?
> 
> I know I repeat it, but please:
> 
> 	Fix the VM-management in kernel 2.4.x. It's unusable. Believe
> 	me! As comparison: kernel 2.2.19 didn't need nearly any swap for
> 	the same operation!
> 
> Please consider that I'm using 512 MB of RAM. This should, or better: 
> must be enough to do the rsync-operation nearly without any swapping - 
> kernel 2.2.19 does it!
> 
> The performance of kernel 2.4.18pre1 is very poor, which is no surprise, 
> because the machine swaps nearly nonstop.

please try to reproduce on 2.4.17rc2aa2, thanks.

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc2aa2.bz2

Andrea
