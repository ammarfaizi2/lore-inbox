Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTKEDHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 22:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTKEDHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 22:07:30 -0500
Received: from drifthost.com ([66.28.242.251]:39564 "EHLO drifthost.com")
	by vger.kernel.org with ESMTP id S262740AbTKEDH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 22:07:28 -0500
Message-ID: <1805.61.88.244.7.1068001546.squirrel@mail.drifthost.com>
Date: Wed, 5 Nov 2003 14:05:46 +1100 (EST)
Subject: hda: no DRQ after issuing WRITE
From: <steve@drifthost.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200311042029.38749.andy@asjohnson.com>
References: <200311042029.38749.andy@asjohnson.com>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.9)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

i keep getting things like this in my dmesg

============================================
hda: status timeout: status=0xd0 { Busy }

hda: no DRQ after issuing WRITE
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }

hda: no DRQ after issuing WRITE
ide0: reset: success
=============================================

>From hdparm
============================================
/dev/hda:

 Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4CBRJLA
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
 BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=160836480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5
=================================================

Ive searched high and low to try find out what this means, all ive found
it people keep saying its all different kinds of things..

I was wondering if this means my hdd is drying or is ti a setting?

Thanks guys,
Steve


