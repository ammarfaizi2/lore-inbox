Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936486AbWLANEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936486AbWLANEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936489AbWLANEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:04:40 -0500
Received: from vscan05.westnet.com.au ([203.10.1.139]:22428 "EHLO
	vscan05.westnet.com.au") by vger.kernel.org with ESMTP
	id S936486AbWLANEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:04:39 -0500
Message-ID: <45702865.4020604@snapgear.com>
Date: Fri, 01 Dec 2006 23:04:37 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.19-uc0 (MMU-less updates)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus: Scanned with PMX 5.2.1.279297
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) code against 2.6.19.
I have quite a few things outstanding here to push up.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.19-uc0.patch.gz


Change log:

. m68knommu Kconfig cleanups                    Greg Ungerer
. m68knommu printk cleanups                     Greg Ungerer
. fix setup.c initrd compile problem            Adrian Bunk
. add m68knommu shmem support                   David Wu
. fix m532x ColdFire timer                      Greg Ungerer
. fix ROMEND marker for 68360 platforms         Greg Ungerer
. support 5272 coldfire serial fraction div     Andrea Tarani
. fix coldfire master clock definition          Greg Ungerer
. make ucontext FPU agnostic                    Gavin Lambert
. fix mmaping of open directory                 Mike Frysinger
. rework uclinux MTD map driver                 David McCullough
. autodetect mem size on m520x                  Michael Broughton
. fix scatterlist.h missing bracket             Mariusz Kozlowski
. m68knommu use generic rtc code                Greg Ungerer
. new style coldfire serial driver              Greg Ungerer

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a division of Secure Computing  PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com

