Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262357AbSJJABB>; Wed, 9 Oct 2002 20:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbSJJABB>; Wed, 9 Oct 2002 20:01:01 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:24288 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262105AbSJJAAw>; Wed, 9 Oct 2002 20:00:52 -0400
Message-ID: <3DA4C511.5070905@snapgear.com>
Date: Thu, 10 Oct 2002 10:08:49 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.41uc0 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

The latest set of MMU-less support patches are up. You can
get the all-in-one patch at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc0.patch.gz

Change log:

1. patched against 2.5.41
2. reworked build system (support new kbuild changes)
3. switch to workqueue's in serial and ethernet drivers
4. started import Christop Hellwigs MM changes
     - now CONFIG_MMU and CONFIG_SWAP defines
     - more patches still to merge


You can get smaller patches here:

. FEC (5272) ethernet driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc0-fec.patch.gz

. 68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc0-serial.patch.gz

. 68328 frame buffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc0-fb.patch.gz

. FLAT file loader
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc0-binflat.patch.gz

. m68knommu architecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc0-m68knommu.patch.gz

. v850 architecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc0-v850.patch.gz

. no VM memory support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc0-mmnommu.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com


