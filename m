Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130881AbQLGXVo>; Thu, 7 Dec 2000 18:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131414AbQLGXVZ>; Thu, 7 Dec 2000 18:21:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1806 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130881AbQLGXVR>;
	Thu, 7 Dec 2000 18:21:17 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012072250.eB7Moc813396@flint.arm.linux.org.uk>
Subject: Re: Oops while assigning PCI resources
To: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 7 Dec 2000 22:50:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200012071922.TAA09634@raistlin.arm.linux.org.uk> from "Russell King" at Dec 07, 2000 07:22:24 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> I'm seeing an oops while assigning PCI resources on an ARM board.  This
> board as a PCI to PCI bridge on board without any devices on the second
> bus.

I've solved this one, sorry for the noise.
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
