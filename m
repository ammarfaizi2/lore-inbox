Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274683AbRITWbb>; Thu, 20 Sep 2001 18:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274680AbRITWbV>; Thu, 20 Sep 2001 18:31:21 -0400
Received: from [195.223.140.107] ([195.223.140.107]:1526 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274679AbRITWbL>;
	Thu, 20 Sep 2001 18:31:11 -0400
Date: Fri, 21 Sep 2001 00:31:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010921003136.H729@athlon.random>
In-Reply-To: <20010921001305.F729@athlon.random> <Pine.GSO.4.21.0109201817410.5631-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109201817410.5631-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Sep 20, 2001 at 06:20:39PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 06:20:39PM -0400, Alexander Viro wrote:
> OK.  Could you resend your patch (or just the page initialization parts
> of it)?  I'm getting to the point where I'll start seriously touching
> rd.c, so...

Of course, however if you want I can first fix initrd (I was just
looking into it in the last minutes), the security fix broke initrd
badly unfortunately [didn't tested initrd but just the ramdisks before
posting it] (not sure why initrd broke at the moment but I believe the
design of the fix was the right one, so it is probably an implementation
detail). So unless you need it urgently I will try to fix initrd first,
then I will send to you so you can go ahead without risk of future rejects.

thanks!

Andrea
