Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRBIQak>; Fri, 9 Feb 2001 11:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRBIQab>; Fri, 9 Feb 2001 11:30:31 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:33422 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129311AbRBIQaL>; Fri, 9 Feb 2001 11:30:11 -0500
Message-Id: <l0313030eb6a9c97163a0@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 9 Feb 2001 16:29:40 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: ISA-PnP and Passing options to non-modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two questions:

1) ISA-PnP detection in the kernel doesn't work properly on my Abit KT7
(the card in question is a SoundBlaster AWE64), but userspace ISA-PnP works
fine...

2) I'm trying to pass options to the SoundBlaster driver using LILO - it's
built into the kernel - but can't figure out the correct syntax to use the
append = "..." option in this context.  I need to do the equivalent of
"options sb io=0x220 dma=1,6 irq=7", which is what the BIOS reports
configuring the card as at boot time.  Yes, i've tried using it as a
module, but it stopped working when I recompiled the kernel with Radeon DRM
support and K7 optimisations.

Any pointers?

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
