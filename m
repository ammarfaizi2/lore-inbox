Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbQKJRq5>; Fri, 10 Nov 2000 12:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130364AbQKJRqq>; Fri, 10 Nov 2000 12:46:46 -0500
Received: from pmcl.ph.utexas.edu ([128.83.155.100]:9734 "EHLO
	pmcl.ph.utexas.edu") by vger.kernel.org with ESMTP
	id <S130231AbQKJRqa>; Fri, 10 Nov 2000 12:46:30 -0500
Date: Fri, 10 Nov 2000 11:00:24 -0600 (EST)
From: <michael@pmcl.ph.utexas.edu>
To: linux-kernel@vger.kernel.org
Subject: intel etherpro100 on 2.2.18p21 vs 2.2.18p17
Message-ID: <Pine.LNX.4.10.10011101052400.16982-100000@pmcl.ph.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have several Supermicro 370DL3 boards (scsi, built into epro100, dual
pentium iii) - which are giving the following ethernet card error on
2.2.18p21, but not on 2.2.18p17.  This error has happened on 3 out of 4
boards with this configuration.

Oct 18 12:17:34 db1 kernel: eth0: card reports no RX buffers. 
The above message repeats itself and the ethernet card does not work.

On bootup:
Oct 18 12:17:34 db1 kernel: scsi : detected 1 SCSI disk total.
Oct 18 12:17:34 db1 kernel: SCSI device sda: hdwr sector= 512 bytes.
Sectors= 35843671 [17501 MB] [17.5 GB]
Oct 18 12:17:34 db1 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro10$
Oct 18 12:17:34 db1 kernel: eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31
Modified by Andrey V. Savochkin <saw@saw.sw.c$
Oct 18 12:17:34 db1 kernel: eth0: Intel PCI EtherExpress Pro100 82557,
00:30:48:21:2F:9E, I/O at 0xd400, IRQ 31.
Oct 18 12:17:34 db1 kernel:   Board assembly 000000-000, Physical
connectors present: RJ45
Oct 18 12:17:34 db1 kernel:   Primary interface chip i82555 PHY #1.
Oct 18 12:17:34 db1 kernel:   General self-test: passed.
Oct 18 12:17:34 db1 kernel:   Serial sub-system self-test: passed.
Oct 18 12:17:34 db1 kernel:   Internal registers self-test: passed.
Oct 18 12:17:34 db1 kernel:   ROM checksum self-test: passed (0x04f4518b).
Oct 18 12:17:34 db1 kernel:   Receiver lock-up workaround activated.
Oct 18 12:17:34 db1 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Oct 18 12:17:34 db1 kernel: eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and o$
Oct 18 12:17:34 db1 kernel: Partition check:
Oct 18 12:17:34 db1 kernel:  sda: sda1 sda2 < sda5 sda6 sda7 >
Oct 18 12:17:34 db1 kernel: VFS: Mounted root (ext2 filesystem) readonly.
Oct 18 12:17:34 db1 kernel: Freeing unused kernel memory: 52k freed
Oct 18 12:17:34 db1 kernel: Adding Swap: 136512k swap-space (priority -1)
Oct 18 12:17:34 db1 kernel: eth0: card reports no RX buffers. 


I believe this has been an ongoing issue for these intel nics?

--Michael


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
