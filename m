Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbQLIMI5>; Sat, 9 Dec 2000 07:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbQLIMIs>; Sat, 9 Dec 2000 07:08:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7442 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131244AbQLIMIm>;
	Sat, 9 Dec 2000 07:08:42 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012091138.eB9Bc5l29476@flint.arm.linux.org.uk>
Subject: Re: pdev_enable_device no longer used ?
To: davej@suse.de
Date: Sat, 9 Dec 2000 11:38:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List), mj@suse.cz
In-Reply-To: <Pine.LNX.4.21.0012091122460.3465-100000@neo.local> from "davej@suse.de" at Dec 09, 2000 11:30:44 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de writes:
> 2. Why is pdev_device_enable no longer used ?

It is used from pci_assign_unassigned_resources.  iirc, its just that
x86 doesn't call this function.
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
