Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261626AbSJJPyc>; Thu, 10 Oct 2002 11:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbSJJPyc>; Thu, 10 Oct 2002 11:54:32 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:6356 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261626AbSJJPya>; Thu, 10 Oct 2002 11:54:30 -0400
Message-ID: <3DA5A42F.6030001@snapgear.com>
Date: Fri, 11 Oct 2002 02:00:47 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.41uc1 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An updated uClinux patch is available at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1.patch.gz

This one has the long awaited merge of the mmnommu and mm directories.
Went pretty smoothly really. The patches are not too bad, but there is
still some cleaning to do. A couple of files are still heavily #ifdef'ed
(like mm/mmap.c, mm/swap_state.c and mm/swapfile.c) but I think these
can ironed out a bit.


Changelog:

1. minor v850 fixes
2. merge of mmnommu and mm dirctories
3. cleanup stubbed system calls in archiecture system call tables


Smaller patches:

. FEC ColdFire 5272 ethernet driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1-fec.patch.gz

. m68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1-serial.patch.gz

. 68328 frame buffer
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1-fb.patch.gz

. binfmt_flat loader
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1-binflat.patch.gz

. m68knommu architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1-m68knommu.patch.gz

. v850 architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1-v850.patch.gz

. mm (MMU-less) only patch
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1-mm.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com


