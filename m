Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287464AbSAHAUu>; Mon, 7 Jan 2002 19:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287478AbSAHAUm>; Mon, 7 Jan 2002 19:20:42 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:38528 "HELO
	ohdarn.net") by vger.kernel.org with SMTP id <S287464AbSAHAU3>;
	Mon, 7 Jan 2002 19:20:29 -0500
Subject: USB Lockups
From: Michael Cohen <lkml@ohdarn.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Jan 2002 19:20:29 -0500
Message-Id: <1010449229.4069.6.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More experience with USB lockups here.

I have an Apollo Pro (694x) and an Apollo Super South (686b),
and it's interesting how quickly this machine freezes under 2.4.18-pre1.
All I have to do is send about 100KiB/second over my NIC and the USB
(moving the mouse and tapping on the keys on my USB HID devices causes
a hard lock with no messages of any kind.  Can't even get a serial
console.)
Tried with UHCI and JE driver. JE doesn't recognize the USB controller
half the time.  It seems to me that this is similar to the problem
with a saturated PCI bus that someone posted a latency fix for.
I'd appreciate any input.  A similar machine does this on windows as
well, too.  BIOS is as late as it gets.

-------
Michael Cohen

