Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315425AbSELV3K>; Sun, 12 May 2002 17:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSELV3J>; Sun, 12 May 2002 17:29:09 -0400
Received: from inet03.olgc.on.ca ([216.94.172.41]:51460 "EHLO inet03")
	by vger.kernel.org with ESMTP id <S315425AbSELV3J>;
	Sun, 12 May 2002 17:29:09 -0400
To: linux-kernel@vger.kernel.org
Subject: UDMA Troubles and Possible Physical Damage?!
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF3BBACEBD.3823AB14-ON85256BB7.0074FF80@LocalDomain>
From: aeleblanc@olgc.on.ca
Date: Sun, 12 May 2002 17:27:20 -0400
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, sorry if this message looks messed up, work forces us to use 
Lotus Notes (Bah!)
and second off heres the system that causing me greif:

Duron 1GHz on an ACS Mobo with SiS Chipset. 100MHz FSB & 384 MB PC133 
SDRAM.
and a Fujitsu 30MB ATA100 Drive


I Just finished installing Debian - Woody, which installs Kernel Version 
2.2.17 I Believe (I may be wrong there)

I installed and ran hdparm and after telling me that dma and all that 
other good stuff was disabled it said "HDIO: Failed to check BUSSTATE"

i ran hdparm -c3 -d1 -X34 to try and get DMA Working... the command ran 
fine but as soon as I tried to run another command (just 'ls' in fact) the 
system Locked up Solid.  upon rebooting my Bios didn't even Pick up the 
Hard drive.. I did a Hard reset again and the Bios picked it up, then 
reset again and it failed to pick it up again.. is it possible that I 
Screwed up my motherboard or Hard drive somehow?

the on a side note, before attempting to use hdparm under the above 
mentioned kernel, I compiled a custom 2.4.18 kernel, however it caused 
even more problems with ide, a bunch of:

hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }

Flew by then it said ide0: reset: success, then locked up again.

if anyone can help it would be greatly appreciated.

