Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129201AbRBFVPv>; Tue, 6 Feb 2001 16:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRBFVPl>; Tue, 6 Feb 2001 16:15:41 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:48340 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129201AbRBFVPX>; Tue, 6 Feb 2001 16:15:23 -0500
Message-Id: <l03130306b6a6125473c5@[192.168.239.105]>
In-Reply-To: <1915665718.20010205155145@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Feb 2001 21:15:17 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: d-link dfe-530 tx (bug-report)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed Urban's most recent patch, and I still get much the same
problems when I reboot from Windows.  The main difference appears to be
that there's a few seconds' pause during the via-rhine driver
initialisation (presumably while it tries to find PHY devices), and there
aren't quite so many "transmit timed out" messages in the system log after
booting.  They do still appear though, and the network is not accessible.
This happens when I reboot from Windows, and when I subsequently soft-power
the machine and turn it back on.  If also happens if I soft-power the
machine from Windows and switch on straight into Linux.

In short, the card still needs a hard power-off for Linux to get it working
after Windows.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
