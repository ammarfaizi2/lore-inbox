Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130267AbRCBCoX>; Thu, 1 Mar 2001 21:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130290AbRCBCoO>; Thu, 1 Mar 2001 21:44:14 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:1725 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S130267AbRCBCny>;
	Thu, 1 Mar 2001 21:43:54 -0500
Message-Id: <l03130301b6c4b77f741e@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 2 Mar 2001 02:43:48 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Strange NAT messages on multicast packets
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a lot of messages in my gateway's system log of the form:

lithium kernel: NAT: 0 dropping untracket packet c233f340 1 10.38.10.67 ->
224.0.0.2

Virtually all these packets come from machines on the student LAN on the
"outside" of the gateway.  Whether or not iptables is configured to drop
the packets (on input or forward), these messages still appear.

I understand 224.0.0.2 means "multicast router", but why does my kernel
have to be so verbose about it?  Is there a sensible way to turn off the
messages without playing havoc with my syslogd configuration?

Kernel 2.4.1 on a P166/MMX, compiled with gcc 2.95.2, based on a
barely-recognisable RH 6.2 installation.  The NIC which these packets come
in on is a 3c509, which is not in promiscuous mode.

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


