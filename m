Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268280AbRGWQD4>; Mon, 23 Jul 2001 12:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268281AbRGWQDq>; Mon, 23 Jul 2001 12:03:46 -0400
Received: from felix.convergence.de ([212.84.236.131]:10126 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S268280AbRGWQDa>;
	Mon, 23 Jul 2001 12:03:30 -0400
Date: Mon, 23 Jul 2001 18:02:01 +0200
From: Felix von Leitner <leitner@convergence.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Athlon/MSI mobo combo broken?
Message-ID: <20010723180201.A10557@convergence.de>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

I have now had two MSI mainboards and two Athlons with 1330 MHz, and
none of them works as advertised.  When I compile an Athlon kernel (I
previously had an Athlon 900 with an Epox board, which was flaky and did
not boot reliably and the USB subsystem was unreliable, too), the
resulting kernel will boot only partially, get spurious errors like a
divide error in the reiserfs code trying to mount a reiserfs volume, and
finally panic on me because it tried to kill the swapper.

When I compile the same kernel for Pentium Pro, it works.  How can this
be?

This is not my only problem with this combination, though.  My network
card (tulip) only works in two of the six PCI slots, my 1995 NCR SCSI
controller only works two slots, and there is only one slot combination
with my sound card that actually works.  When I start Windoze on the
hardware, it hangs trying to load drivers for the NCR controller.

Since this is now my second MSI board, my second power supply, my second
Athlon and there appear to be no thermal problems (judging from the
BIOS health display), I am out of guesses here.  I basically replaces
everything in my PC and it still won't work.

Felix
