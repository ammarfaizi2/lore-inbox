Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbTAWOMH>; Thu, 23 Jan 2003 09:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbTAWOMH>; Thu, 23 Jan 2003 09:12:07 -0500
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:7732 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S265238AbTAWOMF>;
	Thu, 23 Jan 2003 09:12:05 -0500
Subject: Re: Can any one please help me..
From: Adam Voigt <adam@cryptocomm.com>
To: Santosh Kumar Cheekatmalla <pyara_indian@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F130l8HvNuSNGDQ6on70000056f@hotmail.com>
References: <F130l8HvNuSNGDQ6on70000056f@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Jan 2003 09:21:13 -0500
Message-Id: <1043331674.1664.7.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 23 Jan 2003 14:21:16.0332 (UTC) FILETIME=[B0C03EC0:01C2C2EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A. You must be logged in as root.
B. Your device is /dev/hda for your first hard drive.

Enjoy!

On Thu, 2003-01-23 at 09:09, Santosh Kumar Cheekatmalla wrote:
    Hi Everyone,
    
    Can you please help me enable DMA on my machine.
    
    I am new to linux , so can you be little elaborate in your reply
    thanks..
    
    I am using RED HAT Linux 7.3 ...
    
    when i tried to set DMA on
    
    # /sbin/hdparm -d 1 /hda/hdb
    
    I get following message.
    
    /dev/hdb:
    setting using_dma to 1 (on)
    HDIO_SET_DMA failed: Operation not permitted
    using_dma    =  0 (off)
    
    I am using Intelchipset motherborad, and Maxtor hard
    drive
    
    # /sbin/hdparm -iv /dev/hdb
    
    /dev/hdb:
    multcount    = 16 (on)
    I/O support  =  3 (32-bit w/sync)
    unmaskirq    =  0 (off)
    using_dma    =  0 (off)
    keepsettings =  0 (off)
    nowerr       =  0 (off)
    readonly     =  0 (off)
    readahead    =  8 (on)
    geometry     = 79656/16/63, sectors = 80293248, start
    = 0
    
    Model=Maxtor 2F040J0, FwRev=VAM51JJ0,
    SerialNo=F12WD7TE
    Config={ Fixed }
    RawCHS=16383/16/63, TrkSize=0, SectSize=0,ECCbytes=57
    BuffType=DualPortCache, BuffSize=2048kB,MaxMultSect=16, MultSect=16
    CurCHS=16383/16/63, CurSects=16514064, LBA=yes,LBAsects=80293248
    IORDY=on/off, tPIO={min:120,w/IORDY:120},tDMA={min:120,rec:120}
    PIO modes: pio0 pio1 pio2 pio3 pio4
    DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3udma4 *udma5
    udma6
    AdvancedPM=yes: disabled (255) WriteCache=enabled
    Drive Supports : ataATA-1 ATA-2 ATA-3 ATA-4 ATA-5ATA-6 ATA-7
    
    busstate     =  1 (on)
    
    
    Can you please tell me what should i do to enable DMA
    support.
    
    
    
    Thanks
    Santosh
    
    _________________________________________________________________
    The new MSN 8: advanced junk mail protection and 2 months FREE*  
    http://join.msn.com/?page=features/junkmail
    
    -
    To unsubscribe from this list: send the line "unsubscribe
    linux-kernel" in
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html
    Please read the FAQ at  http://www.tux.org/lkml/

-- 
Adam Voigt (adam@cryptocomm.com)
The Cryptocomm Group
My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc

