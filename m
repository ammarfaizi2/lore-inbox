Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135950AbRAMDsg>; Fri, 12 Jan 2001 22:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135954AbRAMDsQ>; Fri, 12 Jan 2001 22:48:16 -0500
Received: from web1001.mail.yahoo.com ([128.11.23.91]:33286 "HELO
	web1001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S135950AbRAMDsL>; Fri, 12 Jan 2001 22:48:11 -0500
Message-ID: <20010113034809.28919.qmail@web1001.mail.yahoo.com>
Date: Fri, 12 Jan 2001 19:48:09 -0800 (PST)
From: Ron Calderon <ronnnyc@yahoo.com>
Subject: sparc10 with 512M of RAM hangs on boot
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

every kernel after 2.4.0-test5 hangs my sparc10
at the same spot. Has anyone looked into this?
here is screen output:

SPARCstation 10  (1 X 390Z50), No Keyboard
ROM Rev. 2.12, 512 MB memory installed, Serial
#6299671.
Ethernet address 

Boot device: /iommu/sbus/espdma/esp/sd@3,0:c   File
and args:         
SILO boot: 
Uncompressing image...
PROMLIB: obio_ranges 5
bootmem_init: Scan sp_banks, 
init_bootmem(spfn[121],bpfn[121],mlpfn[c000])
free_bootmem: base[0] size[c000000]
reserve_bootmem: base[0] size[121000]
reserve_bootmem: base[121000] size[1800]

the last kernel I tried was cvs'ed from vger last
night. I beleive it was 2.4.1-pre2.

ron

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
