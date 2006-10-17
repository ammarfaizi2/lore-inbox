Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422903AbWJQEMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422903AbWJQEMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 00:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWJQEMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 00:12:47 -0400
Received: from rex.snapgear.com ([203.143.235.140]:2785 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S1161088AbWJQEMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 00:12:46 -0400
Message-ID: <45345807.5070007@snapgear.com>
Date: Tue, 17 Oct 2006 14:11:51 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.18-uc0 (MMU-less updates)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

An update of the uClinux (MMU-less) code against 2.6.18.
There is just a hand full of fixes in here, and it is
mostly m68knommu related.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.18-uc0.patch.gz


Change log:

. m68knommu Kconfig cleanups                    Greg Ungerer
. m68knommu printk cleanups                     Greg Ungerer
. fix setup.c initrd compile problem            Adrian Bunk
. add m68knommu missing syscalls                Geert Uytterhoeven
. add m68knommu shmem support                   David Wu
. fix m532x ColdFire timer                      Greg Ungerer
. fix ROMEND marker for 68360 platforms         Greg Ungerer
. support 5272 coldfire serial fraction div     Andrea Tarani
. fix coldfire master clock definition          Greg Ungerer
. make ucontext FPU agnostic                    Gavin Lambert
. fix mmaping of open directory                 Mike Frysinger
. fix small cache size                          David McCullough


Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a division of Secure Computing  PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com


