Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTHGQNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270237AbTHGQNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:13:04 -0400
Received: from flintstone.ichilton.net ([212.13.198.46]:8462 "EHLO
	flintstone.ichilton.net") by vger.kernel.org with ESMTP
	id S265591AbTHGQJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:09:42 -0400
Date: Thu, 7 Aug 2003 17:09:38 +0100
From: Ian Chilton <ian@ichilton.co.uk>
To: linux-kernel@vger.kernel.org
Subject: DMA problem with 2.4.21 and 2.4.22-rc1
Message-ID: <20030807160938.GC31296@roadrunner.ichilton.net>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[Please cc me in on any replies]


I am having problems getting a box into DMA mode with 2.4.21 and
2.4.22-rc1:

[root@baloo:~]# hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)


Relevent dmesg stuff:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hda: C/H/S=19158/16/255 from BIOS ignored
hda: WDC WD400JB-00ENA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/8192KiB Cache, CHS=77545/16/63


Any ideas?


Thanks!

--ian

