Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUISVMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUISVMK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUISVMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:12:10 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:50377 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S264098AbUISVLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:11:22 -0400
Date: Sun, 19 Sep 2004 23:11:21 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: vesafb with special resolution?
Message-ID: <20040919211121.GF17777@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 16:10 screen on my laptop (1280x768). vesafb runs OK with a
1024x768 resolution, but is 1280x768 also possible?

$ dmesg|grep vesa
Kernel command line: BOOT_IMAGE=LinuxOLD ro root=303 noapic video=vesafb:ywrap,mtrr
vesafb: framebuffer at 0xf8000000, mapped to 0xe0880000, size 6144k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at c000:e9b0
vesafb: pmi: set display start = c00ce9e6, set palette = c00cea50
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort CBF                                   AIM.  ralfpostfix
