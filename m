Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318959AbSHFBj1>; Mon, 5 Aug 2002 21:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318963AbSHFBj1>; Mon, 5 Aug 2002 21:39:27 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:15085 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S318959AbSHFBj0>; Mon, 5 Aug 2002 21:39:26 -0400
Message-ID: <3D4F29D9.60604@snapgear.com>
Date: Tue, 06 Aug 2002 11:43:53 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.30uc1 mmu-less patches
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

I have put a new set of uClinux (MMU-less) patches at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.30uc1.patch.gz

A lot of cleanups in this one:

1.  master Makefile patch simplified
2.  silly config entries removed from arch/m68knommu/config.in
3.  68328 frame buffer integrated into drivers/video
4.  MTD patches simplifed (removal of MAGIC_ROM_PTR stuff)

The mm/mmnommu cleanup goes on. I am looking at merging
these to just have mm.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

