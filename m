Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274520AbRJORzQ>; Mon, 15 Oct 2001 13:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRJORzH>; Mon, 15 Oct 2001 13:55:07 -0400
Received: from trident.vpharm.com ([63.98.23.2]:22596 "EHLO stamped.vpharm.com")
	by vger.kernel.org with ESMTP id <S274520AbRJORy4>;
	Mon, 15 Oct 2001 13:54:56 -0400
Message-ID: <XFMail.20011015135310.fant@vpharm.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 15 Oct 2001 13:53:10 -0400 (EDT)
Reply-To: fant@vpharm.com
Organization: Vertex Pharmaceuticals
From: Andrew Fant <fant@vpharm.com>
To: linux-kernel@vger.kernel.org
Subject: System Hang with Gigabit Ethernet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pardon my interruption.  I am having kernel hangs when I attempt to access a
gigabit ethernet addapter from a linux server.

The system is a Compaq ML370 dual processor running RedHat 6.2EE (and oracle), and
the kernel version is 2.2.14 ( Upgrading is not a particularly pleasant option, as I
don't know if I could recreate the changes that RedHat made to the kernel for the
Enterprise Edition).  Because the system must now be multihomed between two mutually
disconnected networks, I need to add a gigabit ethernet adapter to the system.

I have attempted to install a Netgear GA620 ( with the acenic drivers included in
the distribution) and a Netgear GA621 (using the drivers which they provide on CD
with the card).   In both cases, the results are the same. The system comes back up
fine, and runs, until I attempt to run ifconfig on the gigabit card.  At this point,
I get back the information about the card, a shell prompt, and 5-10 seconds later,
the machines freezes hard. So hard that I have to pull the power cord to shut down.

Has anyone else seen this problem, or does anyone have any insights about a likely
fix?  I'm more than willing to get a different card, but it would be nice to have a
clue as to why both Netgear cards fail so miserably, especially since the GA620 came
out of one of the VA Linux boxen we have which have been using that card and driver
for 6 months without a hitch.

My apologies in advance for this interruption.  Please CC me on replies, as I do not
have the time to keep up with this list on a regular basis.

Thanks in advance,
        Andrew Fant

-- 
Andrew Fant           |                                 | email: fant@vrtx.com
HPC Geek              |                                 | phone: (617)444-6000
Vertex Pharmaceuticals| Disclaimer: Who would be crazy  |
Cambridge, MA  02139  | enough to claim these opinions? |  ICBM: 42.35N 71.09W
