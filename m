Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbUCEQz4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbUCEQz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:55:56 -0500
Received: from smtp.citb.bull.net ([192.90.76.5]:19726 "EHLO
	loupiac.citb.bull.net") by vger.kernel.org with ESMTP
	id S262651AbUCEQyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:54:36 -0500
Subject: kernel 2.6.3 hdparm : HDIO_SET_DMA failed: Operation not permitted
From: =?ISO-8859-1?Q?Fran=E7ois?= Chenais <francois@chenais.net>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-d4BWR7AfxjUWgcTD+A2W"
Message-Id: <1078506007.2210.84.camel@tanna>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 18:00:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d4BWR7AfxjUWgcTD+A2W
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hello, 

Since I use kernel 2.6.3, my disk has very low performance 
If I do nothing during about 30 sec, the system takes about 3 sec before
reaction because the disk seems awakened.

So I asked around me how to tune it using hdparm but 
i have the following errors when setting on dma (logs bellow). 

Some persons around me have the same feeling of lowest performances.


Perhaps my kernel .config has some bad values because I have no
experience in disk tuning (see attached file).

I use 
   - debian sid on a NEC VERSA L320 laptop with a 'home built' kernel. 
   - preemptive mode 
   - ACPI
   

	Thanks a lot in Advance if you can help me
	Hope that can help linux development.
	Sorry if I've done a mistake in my kernel conf 
        or if I've chosen the bad mailing list. 

		François


-----------------------------------------------------------------------
hdparm -d1 /dev/hda
-----------------------------------------------------------------------
/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

-----------------------------------------------------------------------
   My Disk's informations
-----------------------------------------------------------------------
/dev/hda:

ATA device, with non-removable media
        Model Number:       TOSHIBA MK3017GAP                       
        Serial Number:      224A3455T           
        Firmware Revision:  A0.04 A 
Standards:
        Supported: 5 4 3 2 
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   58605120
        device size with M = 1024*1024:       28615 MBytes
        device size with M = 1000*1000:       30005 MBytes (30 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 46     Queue depth: 1
        Standby timer values: spec'd by Vendor, no device specific
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0080)
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3
*udma4 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
                Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
                SET MAX security extension
           *    Advanced Power Management feature set
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        36min for SECURITY ERASE UNIT. 
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct
-----------------------------------------------------------------------







-- 
Debian SID
Linux tanna 2.6.3 #1 Tue Feb 24 03:06:51 CET 2004 i686 GNU/Linux
Linux Counter #59413
PGP fingerprint : 9AFA 15EC 96C9 F607 EBC1  DD41 70C5 F0E0 25A5 105B

--=-d4BWR7AfxjUWgcTD+A2W
Content-Disposition: attachment; filename=config-2.6.3.gz
Content-Type: application/x-gzip; name=config-2.6.3.gz
Content-Transfer-Encoding: base64

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
rPMow40J3oWlnEXgYP4/JY2NdeyWAAA=

--=-d4BWR7AfxjUWgcTD+A2W--

