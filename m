Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUIWVsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUIWVsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUIWVpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:45:42 -0400
Received: from [193.29.205.125] ([193.29.205.125]:30168 "EHLO s1.conecto.pl")
	by vger.kernel.org with ESMTP id S267417AbUIWVoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:44:44 -0400
From: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Windows Logical Disk Manager error
Date: Thu, 23 Sep 2004 23:44:33 +0200
User-Agent: KMail/1.7
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <200409231254.12287@senat> <1095938455.22371.41.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1095938455.22371.41.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409232344.36339@senat>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you compile in ldm debugging support and then send the full debug
> output at boot time?

Here it goes:

SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
SCSI device sda: drive cache: write back
 sda:<7>ldm_validate_partition_table(): Found W2K dynamic disk partition type.
ldm_parse_privhead(): Parsed PRIVHEAD successfully.
ldm_parse_privhead(): Parsed PRIVHEAD successfully.
ldm_parse_privhead(): Parsed PRIVHEAD successfully.
ldm_validate_privheads(): Validated PRIVHEADs successfully.
ldm_parse_tocblock(): Parsed TOCBLOCK successfully.
ldm_parse_tocblock(): Parsed TOCBLOCK successfully.
ldm_parse_tocblock(): Parsed TOCBLOCK successfully.
ldm_parse_tocblock(): Parsed TOCBLOCK successfully.
ldm_validate_tocblocks(): Validated TOCBLOCKs successfully.
ldm_parse_vmdb(): Parsed VMDB successfully.
ldm_validate_vmdb(): VMDB and TOCBLOCK don't agree on the database size.
ldm_parse_vblk(): Parsed VBLK 0x401 (type: 0x45) ok.
ldm_parse_vblk(): Parsed VBLK 0x406 (type: 0x51) ok.
ldm_parse_vblk(): Parsed VBLK 0x403 (type: 0x34) ok.
ldm_parse_vblk(): Parsed VBLK 0x408 (type: 0x32) ok.
ldm_parse_vblk(): Parsed VBLK 0x40a (type: 0x33) ok.
ldm_parse_vblk(): Parsed VBLK 0x500 (type: 0x51) ok.
ldm_parse_vblk(): Parsed VBLK 0x504 (type: 0x33) ok.
ldm_parse_vblk(): Parsed VBLK 0x448 (type: 0x33) ok.
ldm_parse_vblk(): Parsed VBLK 0x44a (type: 0x33) ok.
ldm_parse_vblk(): Parsed VBLK 0x506 (type: 0x33) ok.
ldm_parse_vblk(): Parsed VBLK 0x502 (type: 0x32) ok.
ldm_parse_vblk(): Parsed VBLK 0x527 (type: 0x33) ok.
ldm_parse_vblk(): Parsed VBLK 0x523 (type: 0x51) ok.
ldm_parse_vblk(): Parsed VBLK 0x525 (type: 0x32) ok.
ldm_parse_vblk(): Parsed VBLK 0x444 (type: 0x51) ok.
ldm_parse_vblk(): Parsed VBLK 0x446 (type: 0x32) ok.
ldm_parse_vblk(): Parsed VBLK 0x415 (type: 0x34) ok.
 [LDM] sda1 sda2 sda3 sda4
ldm_partition(): Parsed LDM database successfully.

> Also can you download the ldm tools
> (http://linux-ntfs.sourceforge.net/downloads.html) and copy the ldm
> database to a file and make it available to me?

I've sent it on your e-mail.

-- 
mg
