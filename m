Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbUKMTGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUKMTGg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 14:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUKMTGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 14:06:35 -0500
Received: from outbound04.telus.net ([199.185.220.223]:14295 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S261151AbUKMTGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 14:06:34 -0500
Subject: hda: lost interrupt on 2.6.10-rc
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 13 Nov 2004 12:06:38 -0700
Message-Id: <1100372798.3746.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I just built 2.6.10-rc1-bk23 (under Fedora Core 3).  When I boot
the kernel I get:
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: 40020624 sectors (20490 MB) w/512KiB Cache, CHS=39703/16/63, UDMA
(66) hda:(4)hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x64
hda: DMA interrupt recovery
hda: lost interrupt
 hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA
(100) hdb:(4)hdb: lost interrupt
...
I don't have any parameters on the kernel boot line except "ro
root=/dev/hda3"  
(without the quotes)
Please mail me as I'm not on the list.
Thanks,
Bob
-- 
Bob Gill <gillb4@telusplanet.net>

