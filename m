Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbRCOPwI>; Thu, 15 Mar 2001 10:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131762AbRCOPv7>; Thu, 15 Mar 2001 10:51:59 -0500
Received: from [148.88.16.231] ([148.88.16.231]:5336 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S131446AbRCOPvp>;
	Thu, 15 Mar 2001 10:51:45 -0500
Message-Id: <l0313030cb6d6931983e8@[192.168.239.101]>
In-Reply-To: <200103151420.JAA03185@gloworm.cnchost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 15 Mar 2001 15:44:51 +0000
To: Peter DeVries <peter@devries.tv>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Drvie Corruption CONSTANTLY with Linux and KT7-RAID
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>At this point I am 100% lost.  any help would be
>greatly appreciated.  I am willing to do any testing
>of the system that anyone may need.  Currently I have
>no working copy of linux on the sytem.  My normal
>process to get running is to install slackware.
>download 2.4.2 and the latest ac patch.  Compile, add
>ide=reverse to lilo, switch the hd over to the
>highpoint hpt366 controller and reboot.  As soon as I
>boot corruption begins and drive will be useless
>within 10 minutes.  I have also tried leaving the HD
>on the VIA82686a controller witht the same results.
>Also note I have tried IBM & MAXTOR UDMA100 drives as
>well as IBM & WD UDMA66 Drives.  I have tried both 40
>& 80 pin cables on the drives.

I suggest using the 82686-based controller rather than the HPT one.  Also,
try running with DMA mode disabled.  Personally, I'm running fine with the
82686-based controller in DMA mode with a Seagate UDMA/66 drive.  You might
also want to look at the BIOS settings, which Windows drivers might
"adjust" at runtime to saner values.

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


