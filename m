Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263406AbRFFHyi>; Wed, 6 Jun 2001 03:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263435AbRFFHyS>; Wed, 6 Jun 2001 03:54:18 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:2810 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S263406AbRFFHyK>; Wed, 6 Jun 2001 03:54:10 -0400
Message-Id: <l03130306b7438fa51b18@[192.168.239.105]>
In-Reply-To: <3B1DD68A.17C8FD52@TeraPort.de>
In-Reply-To: <E157KV1-00077L-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 6 Jun 2001 08:45:25 +0100
To: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: 2.4.5 VM
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On a side question: does Linux support swap-files in addition to
>sawp-partitions? Even if that has a performance penalty, when the system
>is swapping performance is dead anyway.

Yes.  Simply use mkswap and swapon/off on a regular file instead of a
partition device.  I don't notice any significant performance penalty (a
swapfile on a SCSI disk is faster than a swap-partition on an IDE disk),
although you'd be advised to attempt to keep the file unfragmented.

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


