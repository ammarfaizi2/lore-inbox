Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUKSDIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUKSDIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 22:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbUKSDIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 22:08:00 -0500
Received: from sol.linkinnovations.com ([203.94.173.142]:1410 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261258AbUKSDHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 22:07:52 -0500
Date: Fri, 19 Nov 2004 14:07:41 +1100
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac10
Message-ID: <20041119030741.GC1231@zip.com.au>
References: <1100789415.6005.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100789415.6005.1.camel@localhost.localdomain>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:50:16PM +0000, Alan Cox wrote:
> The it8212 still doesn't default to DMA on - that is on the TODO list. The

Are you sure?

# hdparm  -v /dev/hdg

/dev/hdg:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 24321/255/63, sectors = 390721968, start = 0
 busstate     =  1 (on)

IT8212: IDE controller at PCI slot 0000:03:05.0
IT8212: chipset revision 17
IT8212: 100% native mode on irq 29
    ide2: BM-DMA at 0x4420-0x4427, BIOS settings: hde:pio, hdf:pio
it8212: controller in pass through mode.
    ide3: BM-DMA at 0x4428-0x442f, BIOS settings: hdg:DMA, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
hdg: WDC WD2000JB-00FUA0, ATA DISK drive
ide3 at 0x4410-0x4417,0x441a on irq 29
hdg: max request size: 1024KiB
hdg: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63,
UDMA(100)
hdg: cache flushes supported
 hdg: hdg1

-- 
    Red herrings strewn hither and yon.
