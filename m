Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130256AbQKQRGB>; Fri, 17 Nov 2000 12:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129412AbQKQRFs>; Fri, 17 Nov 2000 12:05:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130251AbQKQRF2>;
	Fri, 17 Nov 2000 12:05:28 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011171634.QAA01184@raistlin.arm.linux.org.uk>
Subject: Re: [PATCH] pcmcia event thread. (fwd)
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 17 Nov 2000 16:34:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        dwmw2@infradead.org (David Woodhouse),
        dhinds@valinux.com (David Hinds), tytso@valinux.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011170819250.2272-100000@penguin.transmeta.com> from "Linus Torvalds" at Nov 17, 2000 08:21:31 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> On Fri, 17 Nov 2000, Alan Cox wrote:
> Alan, Russell is talking about CardBus controllers (it's also PCMCIA, in
> fact, these days it's the _only_ pcmcia in any machine made less than five
> years ago).

Actually, I wasn't.  I was referring to the embedded-type ARM devices of which
I have two sat in front of me (both are manufactured within the past year so
are "current") and about half the platforms that "ARM Linux" covers have some
form of PCMCIA.

Some ARM CPUs even have the PCMCIA controller embedded within them (look at
arch/arm/tools/mach-types - each entry containing a reference to SA1100 means
that particular platform has the ability to use PCMCIA).

All of the drivers for these devices were written around the in-kernel PCMCIA
code.
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
