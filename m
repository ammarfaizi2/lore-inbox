Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbRGVEis>; Sun, 22 Jul 2001 00:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267907AbRGVEij>; Sun, 22 Jul 2001 00:38:39 -0400
Received: from [216.81.19.22] ([216.81.19.22]:1796 "EHLO black.pepper")
	by vger.kernel.org with ESMTP id <S267906AbRGVEiW>;
	Sun, 22 Jul 2001 00:38:22 -0400
Date: Sat, 21 Jul 2001 23:39:51 -0500 (CST)
From: Daryl F <wyatt@escape.ca>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.6/2.4.7 won't boot ASUS P2-99B
Message-ID: <Pine.LNX.4.32.0107212124510.1173-100000@black.pepper>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I am at an impasse. I can't get kernel 2.4.6 or 2.4.7 to boot on my ASUS
P2-99B. 2.4.5 works fine. Right after I select the boot image from LILO,
the uncompressing message comes out followed by the Ok, booting kernel
message. The screen flashes like it has changed video modes, then the
system just reboots itself.

I've searched high and low on the Internet and the Usenet for a similiar
problems. I tried "noapic" and even "nmi_watchdog=0" on the lilo
parameters and nothing works.

The systems is an ASUS P2-99B motherboard with:

	466MHz Celeron - uniprocessorA
	Intel 440ZX AGPset
	Intel PIIX4E PCIset
	128MB RAM

I've tried moving as much optional support out of the kernel and into
modules, hoping to isolate the problem, but I can't get anywhere. I never
get far enough to get any error messages or any logs.

This system has worked fine since I got it, starting with the 2.2.16
kernel. I've upgraded it many times and have built many kernels.
I've checked the compile for the kernel and modules and found nothing
unusual. I've made sure I've run lilo after updating the /etc/lilo.conf.

I've check all the versions in /usr/src/linux/Documentation/Changes and
am at the correct levels or higher. I even tried compiling the kernel with
three different compilers: GCC 2.95.2, GCC 3.0, and EGCS 1.1.2 since my
usual GCC 2.95.2 compiler has a caveat in the kernel documentation.

I've run out of things to check. Any ideas how to get some kind of
diagnostic info or anything else I should check?

TIA,
Daryl




