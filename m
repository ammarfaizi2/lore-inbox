Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWFLWUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWFLWUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWFLWUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:20:15 -0400
Received: from main.gmane.org ([80.91.229.2]:43136 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932619AbWFLWUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:20:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.16-rc6-mm2
Date: Mon, 12 Jun 2006 17:09:52 -0500
Organization: IBM
Message-ID: <pan.2006.06.12.22.09.47.855327@us.ibm.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: rchp4.rochester.ibm.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2006 21:40:24 -0700, Andrew Morton wrote:


> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/

Boot fails on a ppc64 machine.

[snip]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:04.1
AMD8111: chipset revision 3
AMD8111: 0000:00:04.1 (rev 03) UDMA133 controller
AMD8111: 100% native mode on irq 32
    ide0: BM-DMA at 0x7c00-0x7c07<3>AMD8111: -- Error, unable to allocate DMA table.
    ide1: BM-DMA at 0x7c08-0x7c0f<3>AMD8111: -- Error, unable to allocate DMA table.
hda: TOSHIBA MK4019GAXB, ATA DISK drive
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc000000000301240
cpu 0x1: Vector: 300 (Data Access) at [c000000002a13600]
    pc: c000000000301240: .ide_config_drive_speed+0x228/0x624
    lr: c0000000002f6c34: .amd_set_drive+0x7c/0x538
    sp: c000000002a13880
   msr: 8000000000009032
   dar: 0
 dsisr: 40000000
  current = 0xc00000000ffd6820
  paca    = 0xc000000000590080
    pid   = 1, comm = idle

-- 
Steve Fox
IBM Linux Technology Center


