Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262181AbSJaOzg>; Thu, 31 Oct 2002 09:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbSJaOzg>; Thu, 31 Oct 2002 09:55:36 -0500
Received: from mta04bw.bigpond.com ([139.134.6.87]:50133 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S262181AbSJaOze>; Thu, 31 Oct 2002 09:55:34 -0500
Message-ID: <3DC14635.1000308@snapgear.com>
Date: Fri, 01 Nov 2002 01:03:17 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.45-uc1 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Heres another go at a linux-2.5.45 patch for MMU-less support :-)
This time not using the bogus 2.5.45 tar ball.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc1.patch.gz

Changelog:

1. patch against 2.5.45    (me)
2. m68knommu Kconfig       (me)
    (Miles: you will need to do the v850 Kconfig changes...)


Smaller specific patches:

. FEC ColdFire 5272 and 68360 ethernet drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc1-fec.patch.gz

. m68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44-uc1-serial.patch.gz

. 68328 frame buffer
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc1-fb.patch.gz

. binfmt_flat loader
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc1-binflat.patch.gz

. m68knommu architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc1-m68knommu.patch.gz

. v850 architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc1-v850.patch.gz

. mm (MMU-less) only patch
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc1-mm.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com









