Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263143AbVBDHLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbVBDHLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbVBDHLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:11:51 -0500
Received: from [211.58.254.17] ([211.58.254.17]:30121 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263191AbVBDHLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:11:21 -0500
Message-ID: <42032014.1020606@home-tj.org>
Date: Fri, 04 Feb 2005 16:11:16 +0900
From: Tejun Heo <tj@home-tj.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc2] ide_pci: cleanup ide pci drivers and merges .h
 files into .c files
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello, Bartlomiej.

 These patches are the split versions of 05_ide_merge_pci_driver_hc.

 I removed crappy/unused macros from aec62xx, pdc202xx_old and
serverworks drivers in respective *_cleanup patches and merged
.h into .c files in *_merge patches.

[ Start of patch descriptions ]

01_ide_pci_aec62xx_cleanup.patch
	: Remove lousy macros from aec62xx.

	Removes SPLIT_BYTE, MAKE_WORD and BUSCLOCK macros which are
	just better off directly coded from ide/pci/aec62xx driver.

02_ide_pci_aec62xx_merge.patch
	: Merges aec62xx.h into aec62xx.c

	Merges ide/pci/aec62xx.h into aec62xx.c.

03_ide_pci_cmd64x_merge.patch
	: Merges cmd64x.h into cmd64x.c

	Merges ide/pci/cmd64x.h into cmd64x.c.

04_ide_pci_cy82c693_merge.patch
	: Merges cy82c693.h into cy82c693.c

	Merges ide/pci/cy82c693.h into cy82c693.c.

05_ide_pci_generic_merge.patch
	: Merges generic.h into generic.c

	Merges ide/pci/generic.h into generic.c.

06_ide_pci_hpt366_merge.patch
	: Merges hpt366.h into hpt366.c

	Merges ide/pci/hpt366.h into hpt366.c.

07_ide_pci_it8172_merge.patch
	: Merges it8172.h into it8172.c

	Merges ide/pci/it8172.h into it8172.c.

08_ide_pci_opti621_merge.patch
	: Merges opti621.h into opti621.c

	Merges ide/pci/opti621.h into opti621.c.

09_ide_pci_pdc202xx_new_merge.patch
	: Merges pdc202xx_new.h into pdc202xx_new.c

	Merges ide/pci/pdc202xx_new.h into pdc202xx_new.c.

10_ide_pci_pdc202xx_old_cleanup.patch
	: Removes SPLIT_BYTE macro from pdc202xx_old

	Removes SPLIT_BYTE macro from ide/pci/pdc202xx_old driver.

11_ide_pci_pdc202xx_old_merge.patch
	: Merges pdc202xx_old.h into pdc202xx_old.c

	Merges ide/pci/pdc202xx_old.h into pdc202xx_old.c.

12_ide_pci_piix_merge.patch
	: Merges piix.h into piix.c

	Merges ide/pci/piix.h into piix.c.

13_ide_pci_serverworks_cleanup.patch
	: Removes unused SVWKS_DEBUG_DRIVE_INFO

	Removes unused SVWKS_DEBUG_DRIVE_INFO from ide/pci/serverworks
	driver.

14_ide_pci_serverworks_merge.patch
	: Merges serverworks.h into serverworks.c

	Merges ide/pci/serverworks.h into serverworks.c.

[ End of patch descriptions ]

 Thanks.

-- 
tejun

