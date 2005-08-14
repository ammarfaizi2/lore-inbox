Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVHNX7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVHNX7s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 19:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVHNX7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 19:59:48 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:65001 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932364AbVHNX7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 19:59:47 -0400
Date: Mon, 15 Aug 2005 09:59:27 +1000
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Drake <dsd@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: IT8212/ITE RAID
Message-ID: <20050814235927.GC27824@zip.com.au>
References: <20050814053017.GA27824@zip.com.au> <42FF263A.8080009@gentoo.org> <20050814114733.GB27824@zip.com.au> <42FF3CBA.1030900@gentoo.org> <1124026385.14138.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124026385.14138.37.camel@localhost.localdomain>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 02:33:05PM +0100, Alan Cox wrote:
> What does a full identify data set for the drive look like ?

Here it is for the two drives. Please note that multisect was turned on
manually as well as the security freeze.


/dev/hda:

ATA device, with non-removable media
        Model Number:       ST3200822A                              
        Serial Number:      3LJ22Y8F
        Firmware Revision:  3.01    
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 2 
        Supported: 6 5 4 3 
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  390721968
        device size with M = 1024*1024:      190782 MBytes
        device size with M = 1000*1000:      200049 MBytes (200 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command 
           *    48-bit Address feature set 
                SET MAX security extension
Security: 
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by CSEL
Checksum: correct

/dev/hdc:

ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.
        Model Number:       IC35L060AVV207-0                        
        Serial Number:      VNVB01G2RAK8XH
        Firmware Revision:  V22OA63A
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 3a 
        Supported: 6 5 4 3 
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  120103200
        LBA48  user addressable sectors:  120103200
        device size with M = 1024*1024:       58644 MBytes
        device size with M = 1000*1000:       61492 MBytes (61 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 52     Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
                Release interrupt
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command 
           *    48-bit Address feature set 
                Automatic Acoustic Management feature set 
                SET MAX security extension
                Address Offset Reserved Area Boot
                SET FEATURES subcommand required to spinup after power up
                Power-Up In Standby feature set
                Advanced Power Management feature set
           *    General Purpose Logging feature set
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
        30min for SECURITY ERASE UNIT. 
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
