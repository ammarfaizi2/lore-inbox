Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130020AbRBBSgM>; Fri, 2 Feb 2001 13:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbRBBSfx>; Fri, 2 Feb 2001 13:35:53 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:22954 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129904AbRBBSfp>; Fri, 2 Feb 2001 13:35:45 -0500
Message-Id: <l03130310b6a0ac26266f@[192.168.239.105]>
In-Reply-To: <3A7AD873.821.F1A284@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 2 Feb 2001 18:29:30 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: DFE-530TX with no mac address
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have a D-Link DFE-530TX Rev A, PCI ethernet card, but it refuses
>to work.
>
>I have looked at http://www.scyld.com/network/index.html#pci
>which sugests using the via-rhine driver.
>
>I did this and compiled it into the kernel. It detects it at boot (via-
>rhine v1.08-LK1.1.6 8/9/2000 Donald Becker) but says the
>hardware address (mac address?) is 00-00-00-00-00-00.

I have an identical card, which usually works - except when I've rebooted
from Windows, when it shows the above symptoms.  After using Windows, I
have to power the machine off, including turning off the "standby power"
switch on the PSU, then turn it back on and boot straight into Linux.  Very
occasionally it also loses "identity" and requires a similar reset, even
when running Linux.

I'm using kernel 2.4.1 on that machine too, which is a Duron 700MHz on an
Abit KT7 (KT133 chipset).

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
