Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129977AbQK3JL7>; Thu, 30 Nov 2000 04:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131746AbQK3JLu>; Thu, 30 Nov 2000 04:11:50 -0500
Received: from ns.caldera.de ([212.34.180.1]:52231 "EHLO ns.caldera.de")
        by vger.kernel.org with ESMTP id <S129977AbQK3JLm>;
        Thu, 30 Nov 2000 04:11:42 -0500
Date: Thu, 30 Nov 2000 09:40:30 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@torque.net
Subject: Re: [KBUILD] Re: PATCH  - kbuild documentation.
Message-ID: <20001130094030.A18717@caldera.de>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@torque.net
In-Reply-To: <14885.37565.611695.816426@notabene.cse.unsw.edu.au> <200011300036.eAU0aTc05028@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200011300036.eAU0aTc05028@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Nov 30, 2000 at 12:36:28AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 12:36:28AM +0000, Russell King wrote:
> and CONFIG_FOO=y and CONFIG_BAR=m?  What about CONFIG_FOO=y and
> CONFIG_BAR=y?  Do we still support this method?  If not, what is the
> recommended way of doing this sort of stuff?

To do this you need to extend the scheme a little bit. I once wrote a
patch that implements this scheme in a common place -
$(TOPDIR)/Makefile.inc - and sent it to Linux for inclusion, but it was
not applied.  IF you are interested I could try to search it...

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
