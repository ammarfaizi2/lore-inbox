Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261885AbSIYDnR>; Tue, 24 Sep 2002 23:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbSIYDnR>; Tue, 24 Sep 2002 23:43:17 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:740 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S261885AbSIYDnQ>; Tue, 24 Sep 2002 23:43:16 -0400
Message-ID: <3D913223.6060801@snapgear.com>
Date: Wed, 25 Sep 2002 13:48:51 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: 2.5.38uc1 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

A new iteration of the uClinux MMU-less support patches.
The all-in-one patch is at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc1.patch.gz

And new this time around I have broken this up into a number
of smaller self-contained patches. Each is a nice logical unit
(like a driver, or framebuffer, etc). This should greatly
simplify any merging into the mainline code :-)

So the here they are:

. Motorola 5272 ethernet driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc1-fec.patch.gz

. Motorola 68328 and ColdFire serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc1-serial.patch.gz

. MTD driver patches for uClinux supported platforms
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc1-mtd.patch.gz

. Motorola 68328 framebuffer
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc1-fb.patch.gz

. uClinux FLAT file format exe loader
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc1-binflat.patch.gz

. MMU-less support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc1-mmnommu.patch.gz

. Motorola embedded m68k/ColdFire architecture support
   (support for 68328, 68360, 5206, 5206e, 5249, 5272, 5307, 5407)
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc1-m68knommu.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

