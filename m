Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288971AbSBKNFo>; Mon, 11 Feb 2002 08:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288981AbSBKNFe>; Mon, 11 Feb 2002 08:05:34 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:51121 "EHLO
	sparsus.humilis.net") by vger.kernel.org with ESMTP
	id <S288971AbSBKNFW>; Mon, 11 Feb 2002 08:05:22 -0500
Date: Mon, 11 Feb 2002 14:05:20 +0100
From: Ookhoi <ookhoi@humilis.net>
To: linux@3ware.com
Cc: linux-kernel@vger.kernel.org
Subject: 3ware: SCSI device sda: 1562951681 512-byte hdwr sectors (-299279 MB)
Message-ID: <20020211140519.B10896@humilis>
Reply-To: ookhoi@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Uptime: 20:31:32 up 21 days,  6:31, 19 users,  load average: 0.08, 0.05, 0.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Not sure if this is a 3ware driver 'bug'. This is a 3ware 7810 with 8
100GB disks, configured hw raid0.

part of dmesg:

SCSI subsystem driver Revision: 1.00
3ware Storage Controller device driver for Linux v1.02.00.010.
scsi0 : Found a 3ware Storage Controller at 0x1090, IRQ: 5, P-chip: 1.3
scsi0 : 3ware Storage Controller
  Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 1562951681 512-byte hdwr sectors (-299279 MB)
 sda: unknown partition table


It should say something like 800GB, but says -299279 MB.

This is with the xfs 2.4.17 kernel. The raid works fine, it seemes just
cosmetic, but thought I'd better report it anyway.

        Ookhoi
