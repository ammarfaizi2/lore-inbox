Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130132AbRAQWXO>; Wed, 17 Jan 2001 17:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130191AbRAQWXF>; Wed, 17 Jan 2001 17:23:05 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:14034 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S130132AbRAQWWz>; Wed, 17 Jan 2001 17:22:55 -0500
Message-ID: <3A661B21.6BC31670@Home.net>
Date: Wed, 17 Jan 2001 17:22:26 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [DISCUSSION]: 2.4.1-pre8: Detection of CD-ROM/CD-R/CD-RW drives
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.1-pre8, this info appears in dmesg:

SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: YAMAHA    Model: CRW2100E          Rev: 1.0H
  Type:   CD-ROM                             ANSI SCSI revision: 02

hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive

This model isn't DVD ;)

It's a CD-ROM/CD-R/RW drive 8MB cache 40x read, as detected by the
standard ATAPI drivers. the SCSI emulation doesnt appear to detect the
right kind of drive (its assuming its a CD-ROM only?)

Shawn.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
