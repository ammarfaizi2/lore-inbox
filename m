Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270572AbRHNLtb>; Tue, 14 Aug 2001 07:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270573AbRHNLtV>; Tue, 14 Aug 2001 07:49:21 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:22803 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270572AbRHNLtH>; Tue, 14 Aug 2001 07:49:07 -0400
Date: Mon, 13 Aug 2001 03:32:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Spreen <david@spreen.de>, linux-kernel@vger.kernel.org
Subject: swap & deadlocks [was Re: Encrypted Swap]
Message-ID: <20010813033214.B994@toy.ucw.cz>
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de> <20010807123358.B31832@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010807123358.B31832@athlon.random>; from andrea@suse.de on Tue, Aug 07, 2001 at 12:33:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I was just searching for swap-encryption-solutions in the lkml-archive.
> > Did I get the point saying ther's no way to do swap encryption
> > in linux right now? (Well, a swapfile in an encrypted kerneli
> > partition r something like that is not really what I want to
> > do I think).
> 
> cryptoloop on the blkdev or filebacked should work just fine. However it
> will increase memory pressure and it increases the probability for a
> deadlock (but normal 2.4 swap activities can deadlock anyways if you do
> the math).

Can you show me the math? I guess this should be fixed...
								Pavel
OTOH if it is not fixed, I can forget about nbd swap deadlocks --they too
happen only seldom ;-)

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

