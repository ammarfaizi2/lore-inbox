Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbUJZOFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUJZOFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbUJZOFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:05:09 -0400
Received: from [212.156.4.130] ([212.156.4.130]:13044 "EHLO fep01.ttnet.net.tr")
	by vger.kernel.org with ESMTP id S262270AbUJZOEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:04:43 -0400
Message-ID: <417E5904.9030107@ttnet.net.tr>
Date: Tue, 26 Oct 2004 17:02:44 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: Re: Linux 2.4.28-rc1
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are many lost/forgotten patches posted here on lkml. Since 2.4.28
is near and 2.4 is going into "deep maintainance" mode soon, I gathered
a short list of some of them.  There, sure, are many more of them,  but
here it goes.
I think they deserve a re-review and re-consideration for inclusion.

Regards,
O. Sezer

The "list":
- Dave Jones:  AMD K7 MCE changes backported from 2.6.
   http://marc.theaimsgroup.com/?l=linux-kernel&m=106521456014393&w=2

- David Vrabel: TI CardBus PCI interrupt routing fix
   http://marc.theaimsgroup.com/?l=linux-kernel&m=108446444125446&w=2

- Michael Mueller: opti-viper pci-chipset support
   (have an updated-for-2.4.23+ patch for this)
   http://marc.theaimsgroup.com/?t=106698970100002&r=1&w=2
   http://marc.theaimsgroup.com/?l=linux-kernel&m=106698965700864&w=2

- Michael Frank: Highmem user-friendliness, Shutdown kernel on zone-
   alignment failure
   (have an updated patch)
   http://lkml.org/lkml/2004/2/7/51
   http://marc.theaimsgroup.com/?t=107619437300052&r=1&w=2
   http://marc.theaimsgroup.com/?l=linux-kernel&m=107619342911564&w=2

- Terry Hardie: 8 port SIIG serial card support
   http://marc.theaimsgroup.com/?l=linux-kernel&m=107765546507508&w=2

- Mauricio Martinez/Corey Minyard: fix a problem (multiple reads of
   the same data) while reading from a CDU31 SONY CD-ROM drive
   http://marc.theaimsgroup.com/?l=linux-kernel&m=106824345717317&w=2

- Roger Luethi: via-rhine, fix force media
   http://marc.theaimsgroup.com/?l=linux-kernel&m=108507431710317&w=2

- Robert White: usbserial hangup on disconnect
   http://marc.theaimsgroup.com/?t=108114071200002&r=1&w=2
   http://marc.theaimsgroup.com/?l=linux-kernel&m=108114073600529&w=2

- V Ganesh: ipaq, hangup tty on usb disconnect
   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=109049411609590&w=2

- David M. Wilson: sis900 Wake-on-LAN support
   http://marc.theaimsgroup.com/?l=linux-kernel&m=105835662823748&w=2

- Thomas Gleixner: sis5513 fix for SiS962 chipset
   http://marc.theaimsgroup.com/?t=109482706500001&r=1&w=2
   http://marc.theaimsgroup.com/?l=linux-kernel&m=109482716300929&w=2

- Eric Sandeen: fix for large direct I/O
   http://marc.theaimsgroup.com/?l=linux-kernel&m=108197617129880&w=2

- Geert Uytterhoeven: smb_ops_unix compiler warning
   http://marc.theaimsgroup.com/?l=linux-kernel&m=107659039710361&w=2

- David A. Lethe: scsi_scan.c, look for LUNs on XYRATEX RAID subsystems
   http://marc.theaimsgroup.com/?l=linux-kernel&m=105534062611620&w=2

- Andrey Borzenkov: devfs deadlock on concurrent lookups on
   non-existent entry
   http://marc.theaimsgroup.com/?l=linux-kernel&m=105630542714518&w=2

- Jim Carter: apm.c, Dell Inspiron, limit rate of power status calls
   (without the star to the asm code)
   http://marc.theaimsgroup.com/?l=linux-kernel&m=106049225722612&w=2

- Eric Uhrhane: ATP867X PCI IDE driver: driver for the Acard/Artop PCI
   ATA/SATA cards (6885[LP]/6896[S]) based on the ATP867{A,B} chips.
   http://marc.theaimsgroup.com/?l=linux-kernel&m=108198418515134&w=2

- Jakub Bogusz: missing include in farsync WAN driver
   http://marc.theaimsgroup.com/?l=linux-kernel&m=109376793014054&w=2

- Willy Tarreau: MTU fix for tulip driver
   http://marc.theaimsgroup.com/?l=linux-kernel&m=109130863303540&w=2

- Ivan Kokshaysky: alpha, make bootimage and make bootpfile failure,
   boot failure
   http://marc.theaimsgroup.com/?t=109760337800003&r=1&w=2
   http://marc.theaimsgroup.com/?l=linux-kernel&m=109820176212217&w=2

- Sam King: usbserial, down function call being made from an interrupt
   handler
   http://marc.theaimsgroup.com/?t=109639065100005&r=1&w=2
   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=109639053122263&w=2

- Wolfgang Mues: auerswald-usb, kernel oops at disconnect or reconnect
   time because of an endless urb resubmit
   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108465864428213&w=2

- Hilko Bengen: minor error in /proc/isapnp output
   http://marc.theaimsgroup.com/?l=linux-kernel&m=107607982001162&w=2

- Joshua Kwan:  scripts: Support output of new ld
   http://marc.theaimsgroup.com/?t=109549085600003&r=1&w=2

- Joshua Kwan: kbuild: use infobox instead of msgbox and 'sleep 5'
   http://marc.theaimsgroup.com/?l=linux-kernel&m=109549111519324&w=2

- Andre Hedrick: ide updates for 2.4.25
   http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.4.25/

