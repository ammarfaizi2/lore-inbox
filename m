Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273557AbRIQKHQ>; Mon, 17 Sep 2001 06:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272548AbRIQKHG>; Mon, 17 Sep 2001 06:07:06 -0400
Received: from CPE-61-9-150-73.vic.bigpond.net.au ([61.9.150.73]:39300 "EHLO
	wagner") by vger.kernel.org with ESMTP id <S273524AbRIQKG4>;
	Mon, 17 Sep 2001 06:06:56 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bzImage target for PPC 
In-Reply-To: Your message of "Sun, 16 Sep 2001 21:25:38 MST."
             <20010916212538.F14279@cpe-24-221-152-185.az.sprintbbd.net> 
Date: Mon, 17 Sep 2001 20:07:09 +1000
Message-Id: <E15ivIz-00087v-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010916212538.F14279@cpe-24-221-152-185.az.sprintbbd.net> you writ
e:
> On Mon, Sep 17, 2001 at 02:11:34PM +1000, Rusty Russell wrote:
> 
> > All the instructions (including the message after "make oldconfig")
> > talk about "make bzImage".  So I suppose it's best to give in to this
> > rampant Intelism 8)
> 
> What about 'bzlilo' and 'zlilo' ? Those are mentioned too.  Linus, please
> don't apply this.  Hopefully Paul will say that too. :)

Actually, Paul suggested it.  As for bzlilo, that's even a problem on
non-lilo Intel (and should be subsumed by make install).  Of course,
make install should be moved to the top level Makefile, but that's
another battle.

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
