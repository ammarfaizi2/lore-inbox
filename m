Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSJPPnT>; Wed, 16 Oct 2002 11:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265117AbSJPPnT>; Wed, 16 Oct 2002 11:43:19 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:58313 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S265114AbSJPPnR>; Wed, 16 Oct 2002 11:43:17 -0400
Message-ID: <3DAD8AA7.1030305@snapgear.com>
Date: Thu, 17 Oct 2002 01:49:59 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.42uc1 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An updated uClinux patch is available at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.43uc0.patch.gz

Changelog:

1. patched against 2.5.43
2. removed v850 gdb stuff
3. change CONFIG_NO_MMU_LARGE_ALLOCS to CONFIG_LARGE_ALLOCS
4. remove unused CONFIG_CONTIGUOUS_PAGE_ALLOC code
5. reformated config.in files
6. removed unused MAX_SHARED_LIBS in flat.h
7. modified vmlinux.ld.S to include appropriate linker scripts
8. moved set_page_refs() back into page_alloc.c


Smaller specific patches:

. FEC ColdFire 5272 ethernet driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.43uc0-fec.patch.gz

. m68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.43uc0-serial.patch.gz

. 68328 frame buffer
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.43uc0-fb.patch.gz

. binfmt_flat loader
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.43uc0-binflat.patch.gz

. m68knommu architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.43uc0-m68knommu.patch.gz

. v850 architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.43uc0-v850.patch.gz

. mm (MMU-less) only patch
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.43uc0-mm.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com





