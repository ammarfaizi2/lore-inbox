Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129191AbRCFGri>; Tue, 6 Mar 2001 01:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbRCFGr3>; Tue, 6 Mar 2001 01:47:29 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:3818 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S129191AbRCFGrU>;
	Tue, 6 Mar 2001 01:47:20 -0500
Message-Id: <l03130308b6ca353ffb51@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.10.10103052136580.1011-100000@penguin.transmeta.com>
In-Reply-To: <3AA47557.1DC03D6@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Mar 2001 06:43:05 +0000
To: Linus Torvalds <torvalds@transmeta.com>,
        Douglas Gilbert <dougg@torque.net>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: scsi vs ide performance on fsync's
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't know if there is any way to turn of a write buffer on an IDE disk.

hdparm has an option of this nature, but it makes no difference (as I
reported).  It's worth noting that even turning off UDMA to the disk on my
machine doesn't help the situation - although it does slow things down a
little, it's not "slow enough" to indicate that the drive is behaving
properly.  Might be worth running the test on some of my other machines,
with their diverse collection of IDE controllers (mostly non-UDMA) and
disks.

>Of course, whether you should even trust the harddisk is another question.

I think this result in itself would lead me *not* to trust the hard disk,
especially an IDE one.  Has anybody tried running this test with a recent
IBM DeskStar - one of the ones that is the same mech as the equivalent
UltraStar but with IDE controller?  I only have SCSI and laptop IBMs here -
all my desktop IDE drives are Seagate.  However I do have one SCSI Seagate,
which might be worth firing up for the occasion...

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


