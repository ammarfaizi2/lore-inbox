Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271907AbRH2F2p>; Wed, 29 Aug 2001 01:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271909AbRH2F2f>; Wed, 29 Aug 2001 01:28:35 -0400
Received: from donna.siteprotect.com ([64.41.120.44]:5640 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S271907AbRH2F2U>; Wed, 29 Aug 2001 01:28:20 -0400
Date: Wed, 29 Aug 2001 01:31:13 -0400 (EDT)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: <linux-kernel@vger.kernel.org>
Subject: ALi USB Problems..similar to VIA ones?
Message-ID: <Pine.LNX.4.33.0108290120440.3566-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I already reported this to the usb list, but noone there seemed to know
anything.  And given recent similar things mentioned on this list
recently, I figured I'd try posting here.

I've got an HP laptop with the ALi Magik1 (1647) chipset in it, and an
OCHI USB controller (standard ALi 1535 southbridge).  Under Windows, USB
works ok, but 'cuts out' for about 3-5 seconds every minute or so, as if
it's resetting itself.  This seems eeriely similar to the VIA UHCI
problems reported last week on this list, even though i know OHCI and UHCI
should be nothing alike.

Under Linux, both my USB joystick and my USB keyboard fail, and it appears
that interrupts aren't getting through (/proc/interrupts shows 1
interrupt, no matter how many times i plug and unplug things in and get
URB timeouts).  This is a notebook, and the usb interrupt is shared with
acpi. (irq 9).

System information can be found at
http://www.deater.net/john/PavilionN5430.html, with links to dmesg, lspci,
and other information at the bottom of the page.  I would appreciate any
help in tracking this one down.  I've tried kernels 2.4.5-2.4.9, and I'm
willing to test or write any patches.

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


