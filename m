Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbUKLPp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbUKLPp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 10:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbUKLPoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 10:44:10 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:19340 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP id S262552AbUKLPnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 10:43:53 -0500
Date: Fri, 12 Nov 2004 16:43:50 +0100
Message-Id: <683524495@web.de>
MIME-Version: 1.0
From: "Enrico Bartky" <DOSProfi@web.de>
To: linux-kernel@vger.kernel.org
Subject: RE: PROMISE Ultra133 TX2 (PDC20269)
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mysterios, .. now it says udma4 but with 7 MB/s

schrottkiste:~# hdparm -I /dev/hde

/dev/hde:

ATA device, with non-removable media
        Model Number:       FUJITSU MPD3084AT
        Serial Number:      01064533
        Firmware Revision:  DD-03-44
Standards:
        Supported: 4 3 2 1
        Likely used: 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   16514064
        device size with M = 1024*1024:        8063 MBytes
        device size with M = 1000*1000:        8455 MBytes (8 GB)
Capabilities:
        LBA, IORDY(cannot be disabled)
        Buffer size: 512.0kB    bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 16  Current = ?
        Advanced power management level: unknown setting (0x0000)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
                READ BUFFER cmd
                WRITE BUFFER cmd
                Host Protected Area feature set
           *    Look-ahead
           *    Write cache
                Power Management feature set
                Security Mode feature set
                SMART feature set
                Advanced Power Management feature set
Security:
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        24min for SECURITY ERASE UNIT.
schrottkiste:~# hdparm -t /dev/hde

/dev/hde:
 Timing buffered disk reads:   26 MB in  3.45 seconds =   7.53 MB/sec
schrottkiste:~#




__________________________________________________________
Mit WEB.DE FreePhone mit hoechster Qualitaet ab 0 Ct./Min.
weltweit telefonieren! http://freephone.web.de/?mc=021201

