Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKBU3z>; Thu, 2 Nov 2000 15:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKBU3p>; Thu, 2 Nov 2000 15:29:45 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11056 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129033AbQKBU3c>; Thu, 2 Nov 2000 15:29:32 -0500
Date: Thu, 2 Nov 2000 21:29:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tim Riker <Tim@Rikers.org>
Cc: Andi Kleen <ak@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
Message-ID: <20001102212924.A20396@athlon.random>
In-Reply-To: <3A01B8BB.A17FE178@Rikers.org> <E13rPhi-0001ng-00@the-village.bc.nu> <20001102201836.A14409@gruyere.muc.suse.de> <3A01BDCD.FCBCFFF8@Rikers.org> <20001102205246.A17332@athlon.random> <3A01C7CD.C5AEB5B5@Rikers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A01C7CD.C5AEB5B5@Rikers.org>; from Tim@Rikers.org on Thu, Nov 02, 2000 at 01:00:13PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 01:00:13PM -0700, Tim Riker wrote:
> This started off with some comments from the group (hpa in particular)
> that even between gcc releases, the gcc extensions have been much less
> stable that the standard compiler features. The danger of implementing

Given how the thread started I'm uncertain if with "stable" he meant "bug-free"
or "same API". You certainly mean "same API" and I see your point, OTOH
supporting gcc extensions still looks like the best solution to me - even if we
lack the standardization - because: 1) if you try to change the kernel I think
you'll get even more mainteinance troubles :), 2) the stable kernels never get
compiled with the bleeding edge gcc, so you would have plenty of time to
catchup any potential change in the gcc extensions.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
