Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263415AbRFNRQr>; Thu, 14 Jun 2001 13:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbRFNRQh>; Thu, 14 Jun 2001 13:16:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:60206 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263415AbRFNRQ2>; Thu, 14 Jun 2001 13:16:28 -0400
Date: Thu, 14 Jun 2001 19:16:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@redhat.com>
Subject: Re: unregistered changes to the user<->kernel API
Message-ID: <20010614191634.B30567@athlon.random>
In-Reply-To: <20010614191219.A30567@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010614191219.A30567@athlon.random>; from andrea@suse.de on Thu, Jun 14, 2001 at 07:12:19PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 07:12:19PM +0200, Andrea Arcangeli wrote:
> is not definitive yet, O_DIRECTIO of tru64 is our O_NOFOLLOW so we're
> just screwed as we just need a wrapper anyways to make complex programs like

I just got the email from Richard that he prefers to break O_NOFOLLOW
than to define O_DIRECT to something else than 0200000.  So probably
there will be an incrmeental patch for the alpha later to apply on top
of the previous ones.

Also please folks remind to never choose random numbers for the alpha
userspace visible kernel API.

Andrea
