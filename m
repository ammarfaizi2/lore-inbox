Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276021AbRJUN0E>; Sun, 21 Oct 2001 09:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276075AbRJUNZo>; Sun, 21 Oct 2001 09:25:44 -0400
Received: from mail.mwi-online.de ([62.159.208.115]:29703 "EHLO
	mail.mwi-online.de") by vger.kernel.org with ESMTP
	id <S276074AbRJUNZk>; Sun, 21 Oct 2001 09:25:40 -0400
Message-Id: <200110211326.PAA01192@mail.mwi-online.de>
Date: Sun, 21 Oct 2001 13:26:11 -0000
To: "linux-kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: VIA 686b Bug - once again :(
From: "Volker Dierks" <vd@mwi-online.de>
X-Mailer: TWIG 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

my first mail to this famous list .. ;)

OK, 2 month ago, I bought a Abit KG7 
MOBO (VIA 686b southbridge) and
yesterday I ended up with the second
data corruption within these two month.

This one isn't so bad as the first one ..
I can't find any 400GB files with the
rescue system and also no partition has
gone. But on normal system boot, there
are errors with rc.S and when kdm
normally should start, the system stops
to do anything. CTRL+ALT+DEL is
configured to reboot the system - when
pressed it is going into runlevel 6,
but hangs around after that.

I set _no_ special settings with hdparm.
hdparm -c -d /dev/hda gives
DMA = 1
32 bit = 1

Some words about my system:
Debian GNU/Linux (sid)
Kernel 2.4.10
Abit KG7 (lite)
Athlon 1.4GHz (step c)
Soundblaster Live (value)
1 IBM DTLA 20 GB
Dawicontrol DC-2974 PCI - AM53C974
(CDROM and CDR are SCSI)

I searched 1 hour on google but
the only solution seems to be a
fix with loadlin and pciset from
Thilo <Free.Spirit@gmx.net>

So my questions is:
I'm going to buy a 3ware 6410(B)
IDE raid controller .. can I suspect
a failure safe system (in aspect to
the 686b problems) when all discs
are connected to the 3ware
controller?

Greetings from Germany
volker
-- 
GNU/Linux
Let loose the Daemon inside...
