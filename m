Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbSLNPMf>; Sat, 14 Dec 2002 10:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbSLNPMf>; Sat, 14 Dec 2002 10:12:35 -0500
Received: from 44.Red-80-59-166.pooles.rima-tde.net ([80.59.166.44]:28291 "EHLO
	gatsu.novasec.es") by vger.kernel.org with ESMTP id <S267624AbSLNPMe>;
	Sat, 14 Dec 2002 10:12:34 -0500
From: "bladi" <bladi-sec@novasec.es>
To: linux-kernel@vger.kernel.org
Subject: Problem with 2.4.21-pre1 Promise PDC20276
Date: Sat, 14 Dec 2002 16:20:08 +0100
Message-Id: <20021214152008.M92869@novasec.es>
X-Mailer: Open WebMail 1.81 20021127
X-OriginatingIP: 213.97.200.36 (bladi-sec)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

i have PDC20276 BIOS ver 2.20.1020.13 promise device

And with kernel 2.4.21-pre1 the kernel recognize correctly the promise card
but not the IDE devices. With 2.4.20 it work correctly using the same .config
file.


--------- 2.4.21-pre1 -----------------
PDC20276: IDE controller at PCI slot 00:0f.0                                 
PDC20276: chipset revision 1                                               
PDC20276: not 100% native mode: will probe irqs later                    
PDC20276: neither IDE port enabled (BIOS)                              
        

I try to load as kernel module too and pdc202xx_new.o give me the same error.
/proc/ide/pdcnew
                                MBFastTrak 133 Lite Chipset.                    



---------- 2.4.20 -----------
PDC20276: IDE controller on PCI bus 00 dev 78                               
PDC20276: chipset revision 1                                               
PDC20276: not 100% native mode: will probe irqs later                    
PDC20276: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.       ide2: BM-DMA at 0xd000-0xd007, BIOS settings: hde:pio, hdf:pio   
            ide3: BM-DMA at 0xd008-0xd00f, BIOS settings: hdg:pio, hdh:pio 
            

/proc/ide/pdc202xx
PROMISE Ultra series driver Ver 1.20.0.7 2002-05-23 Adapter: Ultra Series
--------------- Primary Channel ---------------- Secondary Channel
-------------                enabled                          enabled 
66 Clocking     enabled                          enabled 
Mode            MASTER                           MASTER
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1
------DMA enabled:    no               no              yes               no 
UDMA Mode:      0                0               2                 0
PIO Mode:       0                0               4                 0


--
NovaSec Servicios de Seguridad
http://www.novasec.es

C\ Evaristo San Miguel 4 2º6 (Princesa)
28008 Madrid (España)

Tel:  91 547 30 51
Fax: 91 559 41 75
