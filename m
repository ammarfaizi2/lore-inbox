Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131447AbRCUOhb>; Wed, 21 Mar 2001 09:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131506AbRCUOhW>; Wed, 21 Mar 2001 09:37:22 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:23257 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131447AbRCUOhF>; Wed, 21 Mar 2001 09:37:05 -0500
Message-Id: <l03130301b6de66229e10@[192.168.239.101]>
In-Reply-To: <20010321143956.917977A94@Nicole.muc.suse.de>
In-Reply-To: <200103210348.VAA24013@xirr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 21 Mar 2001 14:18:50 +0000
To: egger@suse.de
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Only 10 MB/sec with via 82c686b chipset?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Duh, before making such a claim you should consider the fact that
> this is overclocking your PCI/AGP bus and I have yet to see any
> graphic cards/IDE controllers/other devices which are rated for
> 37MHz PCI bus speed.

The "blue and white" PowerMac G3 and certain early PowerMac G4s used a
66MHz PCI card for graphics in lieu of proper AGP.  66MHz PCI is used in
certain high-end workstations, as well, but it's not normally found on
consumer-level devices.

Look at 'lspci -vvv' output for the "66MHz" flag on the devices listed
there - all the ones in my Duron system leave it unset, except for my (very
recent and pretty nippy) SCSI controller and (AGP) video card.

That said, *most* PCI devices don't like being overclocked, and it's not
well known that pushing the system bus also pushes the PCI and ISA buses in
the same manner.  A friend of mine had *severe* locking problems with his
system when he inserted his cheap SCSI adapter into his overclocked
machine, even though the other cards handled it OK (relatively speaking -
I'm not convinced).  I don't know how far he'd overclocked it, but 37MHz
kinda rings true.

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
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


