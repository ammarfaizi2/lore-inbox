Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129113AbRBDKYG>; Sun, 4 Feb 2001 05:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131538AbRBDKX5>; Sun, 4 Feb 2001 05:23:57 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:37323 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129113AbRBDKXv>; Sun, 4 Feb 2001 05:23:51 -0500
Message-Id: <l03130328b6a2de0ec77b@[192.168.239.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 4 Feb 2001 10:23:34 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: d-link dfe-530 tx (bug-report)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>/var/log/messages on the linux-server with the d-link dfe-530 tx:
>[THIS IS THE ERROR-MESSAGE!]
>Feb  1  17:25:56 Nethost kernel: NETDEV WATCHDOG: eth0: transmit timed out
>Feb  1  17:25:56 Nethost kernel: eth0: Transmit timed out, status 0000,
>PHY status 782d, resetting...
>
>after booting everthing is fine (..until the big smb-transfer):
>/var/log/messages (good):
>
>via-rhine.c:v1.08b-LK1.1.6  8/9/2000  Written by Donald Becker
>  http://www.scyld.com/network/via-rhine.html
>PCI: Assigned IRQ 9 for device 00:0a.0
>PCI: Setting latency timer of device 00:0a.0 to 64
>eth0: VIA VT6102 Rhine-II at 0xe000, 00:50:ba:68:59:9c, IRQ 9.
>eth0: MII PHY found at address 8, status 0x7829 advertising 01e1 Link 0081.


This sounds every much like it's related to the problems we're having with
the card not initialising on reboot from Windows.

What's the bets we're looking at a new revision of the chip which VIA
haven't (publically) released documentation for yet?  I'd say they're
pretty high...

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
