Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVCBUfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVCBUfY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVCBUfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:35:23 -0500
Received: from bender.bawue.de ([193.7.176.20]:36792 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S262452AbVCBUfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:35:01 -0500
Date: Wed, 2 Mar 2005 21:34:51 +0100
From: Joerg Sommrey <jo@sommrey.de>
Message-Id: <200503022034.j22KYppm010967@bear.sommrey.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [SATA] libata-dev queue updated
References: <3Ds62-5AS-3@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>BK users:

>	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

>Patch:
>http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-rc5-bk4-libata-dev1.patch.bz2

Still not usable here.  The same errors as before when backing up:

Mar  2 21:09:50 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }Mar  2 21:09:51 bear kernel: ata1: called with no error (51)!
Mar  2 21:09:51 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }Mar  2 21:09:51 bear kernel: ata1: called with no error (51)!
Mar  2 21:09:51 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }Mar  2 21:09:51 bear kernel: ata1: called with no error (51)!
Mar  2 21:09:51 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }Mar  2 21:09:51 bear kernel: ata1: called with no error (51)!
Mar  2 21:09:51 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }Mar  2 21:09:51 bear kernel: ata1: called with no error (51)!
Mar  2 21:09:51 bear kernel: SCSI error : <1 0 0 0> return code = 0x8000002
Mar  2 21:09:51 bear kernel: sdb: Current: sense key: Medium Error
Mar  2 21:09:51 bear kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Mar  2 21:09:51 bear kernel: end_request: I/O error, dev sdb, sector 43099350
Mar  2 21:09:51 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }Mar  2 21:09:51 bear kernel: ata1: called with no error (51)!
Mar  2 21:09:52 bear kernel: SCSI error : <1 0 0 0> return code = 0x8000002
Mar  2 21:09:52 bear kernel: sdb: Current: sense key: Medium Error
Mar  2 21:09:52 bear kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Mar  2 21:09:52 bear kernel: end_request: I/O error, dev sdb, sector 43099358
Mar  2 21:09:52 bear kernel: raid1: Disk failure on sdb2, disabling device.
Mar  2 21:09:52 bear kernel: ^IOperation continuing on 1 devices
Mar  2 21:09:52 bear kernel: raid1: sdb2: rescheduling sector 2904720
Mar  2 21:09:52 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }Mar  2 21:09:52 bear kernel: ata1: called with no error (51)!
Mar  2 21:09:52 bear kernel: SCSI error : <1 0 0 0> return code = 0x8000002
Mar  2 21:09:52 bear kernel: sdb: Current: sense key: Medium Error
Mar  2 21:09:52 bear kernel:     Additional sense: Unrecovered read error - auto reallocate failed

Using Promise SATA150 TX4 / md-raid1 / lvm / reiserfs

-jo
-- 
-rw-r--r--  1 jo users 63 2005-03-02 21:14 /home/jo/.signature
