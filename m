Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263414AbRFNRp1>; Thu, 14 Jun 2001 13:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263437AbRFNRpR>; Thu, 14 Jun 2001 13:45:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18482 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263414AbRFNRo7>; Thu, 14 Jun 2001 13:44:59 -0400
Date: Thu, 14 Jun 2001 19:44:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@redhat.com>
Subject: Re: unregistered changes to the user<->kernel API
Message-ID: <20010614194419.A715@athlon.random>
In-Reply-To: <20010614191219.A30567@athlon.random> <3B28F376.1F528D5A@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B28F376.1F528D5A@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jun 14, 2001 at 01:25:10PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 01:25:10PM -0400, Jeff Garzik wrote:
> They don't hurt but it's also a bad precedent - you don't want to add a
> ton of CONFIG_xxx to the Linus tree for stuff outside the Linus tree. 
> disagree with this patch.

If tux will ever be merged into mainline eventually I don't think
there's a value in defer such bit. Of course if tux will never get
merged then I totally agree with you.

> this conflicts with noone, so can wait for tux patch

same as above.

> ouch!   I would understand if this was inside CONFIG_TUX, but even so I
> would disagree until Tux is merged.

Then you may prefer to wait tux to be merged before merging the rest as
well, in the meantime 90% of the kernels running out there will show
such stuff out of /proc/stats (hopefully "the same stuff" which is why
I'm posting those patches in first place).

Andrea
