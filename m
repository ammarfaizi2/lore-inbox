Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271319AbRHZM5l>; Sun, 26 Aug 2001 08:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271320AbRHZM5b>; Sun, 26 Aug 2001 08:57:31 -0400
Received: from alpha.netvision.net.il ([194.90.1.13]:54791 "EHLO
	alpha.netvision.net.il") by vger.kernel.org with ESMTP
	id <S271319AbRHZM5V>; Sun, 26 Aug 2001 08:57:21 -0400
Message-ID: <3B88F25B.8AF25EF9@netvision.net.il>
Date: Sun, 26 Aug 2001 15:58:03 +0300
From: Michael Ben-Gershon <mybg@netvision.net.il>
Organization: My Office
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Keyboard and PS/2 mouse lockups
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this is not new, but I feel that my input is worth
noting.

I recently upgraded my hardware from a Tyan board with a PII 333
to an ASUS P4T with a P4 1.5G.

Running either kernel 2.2.19 or 2.4.6, 2.4.7, 2.4.8, 2.4.9, I get
a serious conflict between the PS/2 mouse and the keyboard. If the
mouse is plugged into the machine and generates any mouse event (by
moving it or clicking) the keyboard is completely locked up. I am
using a KVM (=kbd-video-mouse) splitter box, and the strange thing
is that the box will respond to a 'double scroll lock' keypress to
switch from one machine to the next, but if the kbd is locked up by
the above trouble it will not respond at all, and the manual switching
button must be used. This is very strange, as the 'double scroll lock'
action works even if the currently selected machine is switched off!

I get the lockup whether or not gpm is running, and even if the
kernel is built with no PS/2 mouse support. If the mouse is removed
before the trouble is triggered, all is OK.

All of the above is using the console. I can run X from a remote
machine - this is what I have usually done anyway, for a number
of local reasons. I can also telnet into the machine. But the
console keyboard is totally, utterly dead.

For what it is worth, the problem does not occur if the machine
is booted up into DOS rather than linux, so it cannot be purely
a hardware problem, but must be s combined hardware/linux kernel
problem.

Any ideas?

Michael Ben-Gershon
mybg@netvision.net.il
