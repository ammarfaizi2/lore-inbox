Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130484AbRAGLot>; Sun, 7 Jan 2001 06:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130486AbRAGLoj>; Sun, 7 Jan 2001 06:44:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19987 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130484AbRAGLo2>;
	Sun, 7 Jan 2001 06:44:28 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101070958.f079wmx22407@flint.arm.linux.org.uk>
Subject: Re: Little question about modules...
To: Pixel@the-babel-tower.nobis.phear.org (Nicolas Noble)
Date: Sun, 7 Jan 2001 09:58:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-kernel's Mailing list)
In-Reply-To: <Pine.LNX.4.21.0101140318240.5780-100000@the-babel-tower.nobis.phear.org> from "Nicolas Noble" at Jan 14, 2001 03:20:52 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Noble writes:
> Why do I have used by -1 for the module ipv6 onto my system?

I guess this is going to be a new FAQ!  Can we add it to the lkml FAQ
please?

"-1" means that the module itself decides whether it can be unloaded or
not, in this case it is decided by the function "ipv6_unload".  It is
not a bug to have a use count of "-1".
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
