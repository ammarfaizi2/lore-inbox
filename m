Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261590AbREOVl6>; Tue, 15 May 2001 17:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbREOVls>; Tue, 15 May 2001 17:41:48 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:53496 "EHLO tytlal")
	by vger.kernel.org with ESMTP id <S261590AbREOVle>;
	Tue, 15 May 2001 17:41:34 -0400
Date: Tue, 15 May 2001 14:40:20 -0700
From: Chip Salzenberg <chip@valinux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515144020.H3098@valinux.com>
In-Reply-To: <Pine.LNX.4.21.0105150204020.1078-100000@penguin.transmeta.com> <E14zb68-0002Fq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14zb68-0002Fq-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 15, 2001 at 10:26:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Alan Cox:
> Given a file handle 'X' how do I find out what ioctl groups I should
> apply to it.

Wouldn't it be better just to *try* ioctls and see which ones work and
which ones don't?

This ioctl situation reminds me of how novice programmers assume that
they have to call access() or stat() and check a file for existence
and readability before calling open().  But that's just stupid when
you think about it, because if the file isn't there and the open()
fails, that's OK!  Failures are not fatal.

Similarly, ioctl failures are not fatal.  Just Try Them.
-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
