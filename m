Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131075AbRAXRtr>; Wed, 24 Jan 2001 12:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131113AbRAXRth>; Wed, 24 Jan 2001 12:49:37 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:29701 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S131075AbRAXRt1>; Wed, 24 Jan 2001 12:49:27 -0500
Date: Wed, 24 Jan 2001 09:49:05 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Russell King <rmk@arm.linux.org.uk>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010124094905.A15372@twiddle.net>
In-Reply-To: <20010110163158.F19503@athlon.random> <200101102209.f0AM9N803486@flint.arm.linux.org.uk> <20010111005924.L29093@athlon.random> <20010123235115.A14786@twiddle.net> <20010124100240.A4526@athlon.random> <20010124015149.A14891@twiddle.net> <20010124132144.A13308@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010124132144.A13308@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 01:21:44PM +0100, Andrea Arcangeli wrote:
> For example you don't know if there's another object that will cast
> the int pointer back to char pointer before dereferencing. That would
> get a defined runtime behaviour on all archs.

No.  The representation of "int*" and "char*" needn't be the same.
And isn't on old word addressed machines.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
