Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129762AbRCAS3Q>; Thu, 1 Mar 2001 13:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRCAS3I>; Thu, 1 Mar 2001 13:29:08 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:18290 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129762AbRCAS2k>; Thu, 1 Mar 2001 13:28:40 -0500
Date: Thu, 1 Mar 2001 19:30:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Ivan Stepnikov <iv@spylog.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
Message-ID: <20010301193017.E15051@athlon.random>
In-Reply-To: <20010301153935.G32484@athlon.random> <E14YXh5-0008GQ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14YXh5-0008GQ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 01, 2001 at 06:20:49PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 06:20:49PM +0000, Alan Cox wrote:
> > It's not broken, it's not there any longer as somebody dropped it between test7
> > and 2.4.2, may I ask why?
> 
> Linus took it out because it was breaking things.

If it happened to be buggy it didn't looked unfixable from a design standpoint
and I think it was a very worthwhile feature, not just for memory but also to
avoid growing the size of the avl that we would have to pay later all the time
at each page fault.

Andrea
