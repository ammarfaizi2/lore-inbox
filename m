Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132613AbQLNNlf>; Thu, 14 Dec 2000 08:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132481AbQLNNkv>; Thu, 14 Dec 2000 08:40:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30475 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131489AbQLNNkh>;
	Thu, 14 Dec 2000 08:40:37 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012141246.eBECkoc06148@flint.arm.linux.org.uk>
Subject: Re: test12 + initrd = swapper at 99.8% CPU time
To: joseph@cheek.com (Joseph Cheek)
Date: Thu, 14 Dec 2000 12:46:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A38019E.925D809B@cheek.com> from "Joseph Cheek" at Dec 13, 2000 03:09:18 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Cheek writes:
> i'm using test12 to perform a clean linux install.  as soon as i get to
> a command prompt, ps axufw shows swapper at 99.8% CPU usage.  this
> didn't repro with test11, and doesn't repro if i don't use an initrd.

What pid does this task have?  The only process that should be "swapper"
is pid0, and pid0 should be hidden from view.

If its not pid0, then I'd guess that it may be a rogue program...
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
