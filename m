Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131054AbQLYWEJ>; Mon, 25 Dec 2000 17:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbQLYWD6>; Mon, 25 Dec 2000 17:03:58 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:5986
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S131054AbQLYWDq>; Mon, 25 Dec 2000 17:03:46 -0500
Date: Mon, 25 Dec 2000 13:33:19 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4-test5 mkisofs corruption
Message-ID: <20001225133319.A522@work.bitmover.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not yet tested later versions, but 2.4-test5 corrupts my jpegs.  I
made an iso image and mounted it in loopback and they are corrupted;  it
is not loopback doing it, I burned a CD and they were corrupted the same
way.  I downgraded to 2.2.18 and that works fine.

If this is a known problem and/or has been addressed, great.  If not, please
ping me and I'll try the latest 2.4 test and see if the problem has gone 
away.

Config:
    900Mhz K7 on ASUS A7V MB
    PC100 mem w/ ECC (I don't think the board supports that; it's not enabled)
IDE devices:
    /dev/hda is a Maxtor 91303D6, 12427MB w/512kB Cache, CHS=25249/16/63
    /dev/hdb is a ATAPI 40X CD-ROM drive, 128kB Cache
    /dev/hdc is a IBM-DTLA-307045, 43979MB w/1916kB Cache, CHS=5606/255/63
    /dev/hdd is a IBM-DTLA-307045, 43979MB w/1916kB Cache, CHS=5606/255/63
SCSI devices:
    /dev/sr0 is a MATSHITA CD-ROM, model CD-R   CW-7502
4 ethernet interfaces
    eth0: 3Com 3c905B Cyclone 100baseTx
    eth1: 3Com 3c905B Cyclone 100baseTx
    eth2: 3Com 3c905B Cyclone 100baseTx
    eth3: 3Com 3c905 Boomerang 100baseTx
PCI bus devices:
    Host bridge: VIA Technologies Unknown device (rev 2).
    PCI bridge: VIA Technologies Unknown device (rev 0).
    ISA bridge: VIA Technologies Unknown device (rev 34).
    IDE interface: VIA Technologies VT 82C586 Apollo IDE (rev 16).
    Host bridge: VIA Technologies Unknown device (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    SCSI storage controller: Adaptec AIC-7850 (rev 3).
    Ethernet controller: 3Com 3C905 100bTX (rev 0).
    Unknown mass storage controller: Promise Technology Unknown device (rev 2).
    VGA compatible controller: Matrox Matrox G200 AGP (rev 1).
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
