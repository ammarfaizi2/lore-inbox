Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbQKQRvf>; Fri, 17 Nov 2000 12:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129894AbQKQRvZ>; Fri, 17 Nov 2000 12:51:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20230 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129878AbQKQRvN>;
	Fri, 17 Nov 2000 12:51:13 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011171720.RAA01403@raistlin.arm.linux.org.uk>
Subject: Re: VGA PCI IO port reservations
To: root@chaos.analogic.com
Date: Fri, 17 Nov 2000 17:20:28 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org,
        mj@suse.cz
In-Reply-To: <Pine.LNX.3.95.1001117114858.19946A-100000@chaos.analogic.com> from "Richard B. Johnson" at Nov 17, 2000 12:13:14 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson writes:
> This can't be.

Richard,  before I read any further, I suggest that you get some
documentation on a few PCI VGA cards and read up on the register
addresses.  You may want to change your assumptions about what can and
can't be. ;)

And I can definitely say that if you don't allow access to these "extended"
VGA ports, BIOSes either enter infinite loops or else terminate without
initialising the card.  Trust me; I've been successfully running various
PCI VGA card BIOSes under an x86 emulator on an ARM machine for the past
few months.
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
