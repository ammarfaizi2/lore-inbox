Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLXI2E>; Sun, 24 Dec 2000 03:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLXI1y>; Sun, 24 Dec 2000 03:27:54 -0500
Received: from web1002.mail.yahoo.com ([128.11.23.92]:45584 "HELO
	web1002.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129319AbQLXI1s>; Sun, 24 Dec 2000 03:27:48 -0500
Message-ID: <20001224075721.26703.qmail@web1002.mail.yahoo.com>
Date: Sat, 23 Dec 2000 23:57:21 -0800 (PST)
From: Ron Calderon <ronnnyc@yahoo.com>
Subject: sparc 10 w/512 megs hangs during boot
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My sparc 10 seems to hang with any 2.4.0-test12+
kernel
if I add mem=128M it boots fine, but anything above
128M wont boot it just hangs. Is there something I've
missed? here is screen output.

Resetting ... 

SPARCstation 10  (1 X 390Z50), No Keyboard
ROM Rev. 2.12, 512 MB memory installed, Serial
#6299671.
Ethernet address 8:0:20:11:fe:10, Host ID: 72602017.


Boot device: /iommu/sbus/espdma/esp/sd@3,0:c   File
and args:         
SILO boot: 
Uncompressing image...
PROMLIB: obio_ranges 5
bootmem_init: Scan sp_banks, 
init_bootmem(spfn[1c9],bpfn[1c9],mlpfn[c000])
free_bootmem: base[0] size[c000000]
reserve_bootmem: base[0] size[1c9000]
reserve_bootmem: base[1c9000] size[1800]



then it just hangs here....
any info would be great

ron

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
