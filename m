Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbSI1W6d>; Sat, 28 Sep 2002 18:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262345AbSI1W6d>; Sat, 28 Sep 2002 18:58:33 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:14062 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S262344AbSI1W6c>; Sat, 28 Sep 2002 18:58:32 -0400
Message-ID: <3D9635E3.5000502@snapgear.com>
Date: Sun, 29 Sep 2002 09:06:11 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.39uc0 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

The latest MMU-less support patch is up at the usual place:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.39uc0.patch.gz

This is the all-in-one patch, separate patch links below for
self-contained small patches.

Change log:

1. patched against 2.5.39
2. v850 architecture support (thanks to Miles Bader <miles@gnu.org>)
3. binfmt_flat now uses kernel zlib

Smaller patches:

. FEC ColdFire 5272 ethernet driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.39uc0-fec.patch.gz

. m68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.39uc0-serial.patch.gz

. 68328 frame buffer
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.39uc0-fb.patch.gz

. binfmt_flat loader
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.39uc0-binflat.patch.gz

. m68knommu architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.39uc0-m68knommu.patch.gz

. v850 architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.39uc0-v850.patch.gz

. mmnommu (MMU-less) only patch
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.39uc0-mmnommu.patch.gz

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com


