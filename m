Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSHFGtd>; Tue, 6 Aug 2002 02:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSHFGtd>; Tue, 6 Aug 2002 02:49:33 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:13072 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S315276AbSHFGtc>; Tue, 6 Aug 2002 02:49:32 -0400
Date: Tue, 6 Aug 2002 08:53:08 +0200
To: linux-kernel@vger.kernel.org
Subject: Problem reading CDRW in IDE drive
Message-ID: <20020806065308.GA23256@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have the following problem: I write a iso9660 fs to a cdrw, I can
read it in the cdrw drive, but I cannot read it in the dvd-rom drive,
which normally CAN read it. I tried to make a complete blank of the 
disc before writing, no change. I tried kernel version 2.4.19, 2.4.19-jam0.

I always get the following errors:
kernel: hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: cdrom_decode_status: error=0x30
kernel: hdc: command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: command error: error=0x51
kernel: end_request: I/O error, dev 16:00 (hdc), sector 1636
kernel: hdc: command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: command error: error=0x51
kernel: end_request: I/O error, dev 16:00 (hdc), sector 1640

cdrw = hdd via ide-scsi
dvd/cd = hdc via ide


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
