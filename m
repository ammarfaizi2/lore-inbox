Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132400AbRALBaW>; Thu, 11 Jan 2001 20:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132403AbRALBaN>; Thu, 11 Jan 2001 20:30:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19023 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132400AbRALBaC>; Thu, 11 Jan 2001 20:30:02 -0500
Date: Fri, 12 Jan 2001 02:30:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Petersohn <jkp@mccoy.penguinpowered.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ingo's RAID patch for 2.2.18 final?
Message-ID: <20010112023023.G1101@athlon.random>
In-Reply-To: <200101112136.PAA07626@mccoy.penguinpowered.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101112136.PAA07626@mccoy.penguinpowered.com>; from jkp@mccoy.penguinpowered.com on Thu, Jan 11, 2001 at 03:36:13PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 03:36:13PM -0600, Jens Petersohn wrote:
> My appologies if this has been asked before. I'm looking for
> Ingo Molnar's RAID patch for 2.2.18-final. I tried applying A2, but
> it has a number of conflicts in raid1.c which I cannot resolve in
> my meager spare time.

I had to fix those things myself too. However I stay on top of 2.2.19pre7 not
on top of 2.2.18. Raid 0.90 is included into 2.2.19pre7aa1:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.19pre7aa1.bz2

The single raid patch can be downloaded from the the below link but it's going
to reject too if applied on top of 2.2.19pre7 because of lvm that is applied
first (it is equivalent to the raid-2.2.18-A2).

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.19pre7aa1/93_raid-2.2.18-A2_2.2.19pre7aa1-5.bz2

Then later on the generic-map patch changes both lvm and raid to make them
stackable (also for GFS).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
