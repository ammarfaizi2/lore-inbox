Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVIEQYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVIEQYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVIEQYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:24:03 -0400
Received: from lisa.usl6.toscana.it ([159.213.44.2]:12512 "EHLO
	lisa.nord.usl6.toscana.it") by vger.kernel.org with ESMTP
	id S932218AbVIEQYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:24:00 -0400
Message-ID: <007b01c5b236$5b6019d0$1f01a8c0@Ric>
Reply-To: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
From: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
To: <linux-kernel@vger.kernel.org>
Subject: EXT3-fs error (device hda8): ext3_free_blocks: Freeing blocks not in datazone 
Date: Mon, 5 Sep 2005 18:24:58 +0200
Organization: Azienda USL 6 - Livorno
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using FC3 with Kernel 2.6.12-1.1376.
After few hours file system on /dev/hda8 EXT3 partition has a problem so it 
remounted in only read mode.
I tried several times to run fsck on this partition and I also tried to 
remount fs in a new partition, but it happened nothing !
I have this message:

Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8): ext3_free_blocks: 
Freeing blocks not in datazone - block = 134217728, count = 1
Sep  5 17:34:40 mrtg kernel: Aborting journal on device hda8.
Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8) in 
ext3_reserve_inode_write: Journal has aborted
Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8) in ext3_truncate: 
Journal has aborted
Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8) in 
ext3_reserve_inode_write: Journal has aborted
Sep  5 17:34:40 mrtg kernel: ext3_abort called.
Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8): 
ext3_journal_start_sb: Detected aborted journal
Sep  5 17:34:40 mrtg kernel: Remounting filesystem read-only
Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8) in ext3_orphan_del: 
Journal has aborted
Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8) in 
ext3_reserve_inode_write: Journal has aborted

Riccardo

