Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129547AbQLAWW6>; Fri, 1 Dec 2000 17:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129626AbQLAWWt>; Fri, 1 Dec 2000 17:22:49 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7714 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129547AbQLAWWg>; Fri, 1 Dec 2000 17:22:36 -0500
Date: Fri, 1 Dec 2000 22:52:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Reto Baettig <baettig@scs.ch>
Cc: Richard Henderson <rth@twiddle.net>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org
Subject: Re: Alpha SMP problem
Message-ID: <20001201225210.A1580@inspiron.random>
In-Reply-To: <3A08455E.F3583D1B@scs.ch> <20001107225749.B26542@twiddle.net> <20001124044615.A6807@athlon.random> <3A27D1C9.95F63366@scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A27D1C9.95F63366@scs.ch>; from baettig@scs.ch on Fri, Dec 01, 2000 at 08:28:57AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 08:28:57AM -0800, Reto Baettig wrote:
> Is there any chance that we will see this patch as well as your other
> Alpha patches included in future 2.2.X and 2.4.X releases?

Yes, for 2.2.x I'm waiting 2.2.19pre, for 2.4.x as DaveM suggested we first
need to cleanup the interface of the context[] information to optimize the
memory usage on x86*/sparc64 etc...

It would be nice if in the meantime somebody with an old ev4 based machine
(possibly SMP if it exists) could verify that current 2.2.x and 2.4.x patches
works well there too.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
