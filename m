Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAJC1s>; Tue, 9 Jan 2001 21:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRAJC1h>; Tue, 9 Jan 2001 21:27:37 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7744 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129764AbRAJC1T>; Tue, 9 Jan 2001 21:27:19 -0500
Date: Wed, 10 Jan 2001 03:26:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Zlatko Calusic <zlatko@iskon.hr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010110032607.A12565@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10101091041150.2070-100000@penguin.transmeta.com> <Pine.LNX.4.30.0101100144280.7564-100000@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101100144280.7564-100000@imladris.demon.co.uk>; from dwmw2@infradead.org on Wed, Jan 10, 2001 at 01:45:47AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 01:45:47AM +0000, David Woodhouse wrote:
> How does this affect embedded systems with no swap space at all?

If there's no swap the swap-cache dirty-sticky issue can't arise.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
