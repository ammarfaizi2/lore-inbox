Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTGAVVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTGAVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:21:38 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:39178 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263183AbTGAVVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:21:33 -0400
Date: Tue, 1 Jul 2003 23:30:36 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Slow writer...
Message-ID: <20030701213036.GB239@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    I've installed a PlexWriter Premium (52x) in my system, and the
highest speed I can achieve with it is 24x with data and 15x with
audio (the speed difference is quite strange :??). The hard disk is
UDMA5, so it should provide the data at 52x. This is the info for the
hard disk:

/dev/root:

 Model=ST340016A, FwRev=3.05, SerialNo=3HS040AC
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4 5

    As you can see, the udma5 mode is active, and this is a test from
hdparm on the same disk:

/dev/root:
 Timing buffered disk reads:  64 MB in  1.58 seconds = 40.51 MB/sec

    Am I doing something wrong, like not tuning correctly something
in the disk? I am using a DIY box with Linux 2.4.21, CPU Duron 850,
and no processes are running while burning in order to not disturb
the writing process. I'm afraid that DMA is not working properly or
maybe the motherboard is damaged or something like that :??

    Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
