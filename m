Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270647AbTGUUKU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270674AbTGUUKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:10:20 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:36057 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S270647AbTGUUKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:10:15 -0400
Message-ID: <3F1C4AE8.9020906@hotpop.com>
Date: Tue, 22 Jul 2003 01:49:52 +0530
From: dacin <dacin@hotpop.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Interrupt lost { .... }
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ello Freinds

I am facing this problem with kernel 2.4.21 any suggestion.

hdb: dma_timer_expiry: dma status == 0x64
hdb: lost interrupt
hdb: dma_intr: bad DMA status (dma_stat=70)
hdb: dma_intr: status=0x50 { DriveReady SeekComplete }

lspci -v | grep IDE
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12) (prog-if 80 
[Master])

hdparm -I /dev/hdb
/dev/hdb:

ATA device, with non-removable media
    Model Number:       ST340823A                               
    Serial Number:      7EF2AWX7            
    Firmware Revision:  3.11    
Standards:
    Supported: 5 4 3 2
    Likely used: 6
Configuration:
    Logical        max    current
    cylinders    16383    16383
    heads        16    16
    sectors/track    63    63
    --
    CHS current addressable sectors:   16514064
    LBA    user addressable sectors:   78165360
    device size with M = 1024*1024:       38166 MBytes
    device size with M = 1000*1000:       40020 MBytes (40 GB)
Capabilities:
    LBA, IORDY(can be disabled)
    Queue depth: 1
    Standby timer values: spec'd by Standard
    R/W multiple sector transfer: Max = 16    Current = 16
    Recommended acoustic management value: 128, current value: 128
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
         Cycle time: min=120ns recommended=120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
    Enabled    Supported:
       *    READ BUFFER cmd
       *    WRITE BUFFER cmd
       *    Host Protected Area feature set
       *    Look-ahead
       *    Write cache
       *    Power Management feature set
        Security Mode feature set
       *    SMART feature set
       *    Automatic Acoustic Management feature set
        SET MAX security extension
       *    DOWNLOAD MICROCODE cmd
Security:
    Master password revision code = 65534
        supported
    not    enabled
    not    locked
        frozen
    not    expired: security count
    not    supported: enhanced erase
HW reset results:
    CBLID- above Vih
    Device num = 1
Checksum: correct



