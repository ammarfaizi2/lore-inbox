Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272614AbRHaFzt>; Fri, 31 Aug 2001 01:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272613AbRHaFzj>; Fri, 31 Aug 2001 01:55:39 -0400
Received: from mx9.port.ru ([194.67.57.19]:17539 "EHLO mx9.port.ru")
	by vger.kernel.org with ESMTP id <S272612AbRHaFzb>;
	Fri, 31 Aug 2001 01:55:31 -0400
Date: Fri, 31 Aug 2001 09:45:16 +0400
From: Dmitry Volkoff <vdb@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10pre2 dma timeouts
Message-ID: <20010831094516.L419@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see a lot of dma timeouts after upgrading to 2.4.10pre2. 
2.4.9 was OK. cm=cmpci sound driver, hdb=atapi cdrom

2001-08-29 23:40:39.806389500 <7>cm: dma timed out??
2001-08-30 10:13:23.720094500 <7>cm: dma timed out??
2001-08-30 10:15:10.251135500 <7>VFS: Disk change detected on device ide0(3,64)
2001-08-30 10:15:13.011415500 <7>ISO 9660 Extensions: Microsoft Joliet Level 1
2001-08-30 10:15:13.045301500 <7>scanning for RockRidge behind XA attributes
2001-08-30 10:15:13.045308500 <7>ISOFS: changing to secondary root
2001-08-30 10:37:05.226148500 <7>cm: dma timed out??
2001-08-30 12:30:01.546233500 <7>cm: dma timed out??
2001-08-30 13:41:05.725593500 <7>VFS: Disk change detected on device ide0(3,64)
2001-08-30 13:41:08.182700500 <7>ISO 9660 Extensions: Microsoft Joliet Level 1
2001-08-30 13:41:08.237010500 <7>scanning for RockRidge behind XA attributes
2001-08-30 13:41:08.237018500 <7>ISOFS: changing to secondary root
2001-08-30 15:04:01.756184500 <7>cm: dma timed out??
2001-08-30 16:59:05.326265500 <7>cm: dma timed out??
2001-08-30 17:30:23.851025500 <4>hdb: timeout waiting for DMA
2001-08-30 17:30:23.851034500 <4>ide_dmaproc: chipset supported ide_dma_timeout func only: 14
2001-08-30 17:30:23.851038500 <4>hdb: status timeout: status=0xd0 { Busy }
2001-08-30 17:30:23.851041500 <4>hdb: drive not ready for command
2001-08-30 17:30:23.901618500 <4>hdb: ATAPI reset complete
2001-08-31 04:28:09.295761500 <7>cm: dma timed out??
2001-08-31 04:49:18.611390500 <7>cm: dma timed out??
2001-08-31 04:53:07.753687500 <7>VFS: Disk change detected on device ide0(3,64)
2001-08-31 04:53:07.753696500 <4>VFS: busy inodes on changed media.
2001-08-31 08:57:02.196599500 <7>cm: dma timed out??

cdrom was blocked after the last message. I cannot eject the cd-disc.
Only reboot helps. I've never seen such problem with any previous kernels.

-- 

    DV
