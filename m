Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262724AbRE0CvR>; Sat, 26 May 2001 22:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262729AbRE0CvH>; Sat, 26 May 2001 22:51:07 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:63479 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S262724AbRE0Cuu>; Sat, 26 May 2001 22:50:50 -0400
Message-Id: <l03130309b7361b2c0bc8@[192.168.239.105]>
In-Reply-To: <3B1065FD.3F8D7EDF@mandrakesoft.com>
In-Reply-To: <20010527021808.80979.qmail@web13407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 27 May 2001 03:50:28 +0100
To: Jeff Garzik <jgarzik@mandrakesoft.com>, cesar.da.silva@cyberdude.com
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Please help me fill in the blanks.
Cc: kernellist <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> * Live Upgrade
>
>LOBOS will let one Linux kernel boot another, but that requires a boot
>step, so it is not a live upgrade.  so, no, afaik

If you build nearly everything (except, obviously what you need to boot) as
modules, you can unload modules, build new versions, and reload them.  So,
you could say that partial support for "live upgrades" is included.

It works, too - I unloaded my OV511 driver a few weeks ago, copied the
source for the new one in, built it, and re-inserted it.  Same goes for the
DRM module a couple of weeks before that.  Now, the machine in question
gets rebooted fairly often in any case, but those were things I *didn't*
have to reboot for.

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


