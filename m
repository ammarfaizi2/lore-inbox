Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130618AbRCEEed>; Sun, 4 Mar 2001 23:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130617AbRCEEeX>; Sun, 4 Mar 2001 23:34:23 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:664 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S130616AbRCEEeP>;
	Sun, 4 Mar 2001 23:34:15 -0500
Message-Id: <l03130300b6c8c71f0c7c@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.21.0103042043320.27829-100000@trna.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 5 Mar 2001 04:33:57 +0000
To: Ettore Perazzoli <ettore@ximian.com>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Interesting fs corruption story
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>milkplus:~# hdparm /dev/hda
>/dev/hda:
> multcount    =  0 (off)
> I/O support  =  0 (default 16-bit)
> unmaskirq    =  0 (off)
> using_dma    =  1 (on)
> keepsettings =  0 (off)
> nowerr       =  0 (off)
> readonly     =  0 (off)
> readahead    =  8 (on)
> geometry     = 2584/240/63, sectors = 39070080, start = 0
>
>Any idea?  What am I doing wrong?

You could try turning off DMA (rebuild your kernel again, and turn off "use
DMA by default").  UDMA is known to work reliably only with a (reasonably
broad) subset of chipsets, and it is likely that laptop chipsets get the
least testing.  If turning off DMA fixes the problem for you, we at least
know where to start looking.

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


