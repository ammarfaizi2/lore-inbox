Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130229AbRAMSzd>; Sat, 13 Jan 2001 13:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131131AbRAMSzX>; Sat, 13 Jan 2001 13:55:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:529 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130229AbRAMSzK>;
	Sat, 13 Jan 2001 13:55:10 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101131854.f0DIskb17050@flint.arm.linux.org.uk>
Subject: Re: ide.2.4.1-p3.01112001.patch
To: dwmw2@infradead.org (David Woodhouse)
Date: Sat, 13 Jan 2001 18:54:46 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        andre@linux-ide.org
In-Reply-To: <Pine.LNX.4.30.0101131639500.21182-100000@imladris.demon.co.uk> from "David Woodhouse" at Jan 13, 2001 04:42:34 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
> Please can we also stop HPT366 from attempting UDMA66 on the IBM DTLA
> drives, while we're at it? I don't care if it's done by blacklisting the
> DTLA drives, as was done by the patch I resent numerous times, or if it's
> done the other way round by putting known-compatible drives (include
> "FUJITSU MPE3136AT") into a whitelist. But it needs doing.

I've been wondering recently why there isn't an option to tell the kernel
"even if you've been configured to use dma by default, please don't on this
IDE interface".  There is an option for tuning the interface up, but
nothing to tune down.

It strikes me that this might be a good thing to have.  Comments?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
