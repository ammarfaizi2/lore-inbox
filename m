Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbTL3KoD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 05:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265738AbTL3KoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 05:44:03 -0500
Received: from as1-6-4.ld.bonet.se ([194.236.130.199]:1152 "HELO mail.nicke.nu")
	by vger.kernel.org with SMTP id S265736AbTL3KoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 05:44:01 -0500
From: "Nicklas Bondesson" <nicke@nicke.nu>
To: <linux-kernel@vger.kernel.org>
Subject: IDE-RAID Drive Performance
Date: Tue, 30 Dec 2003 11:44:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcPOwYZX1THKwd2pRtWQ28xphNmQfgAADE8w
Message-Id: <S265736AbTL3KoB/20031230104401Z+18387@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I think i'm getting really bad values from my disks. It's two Western
Digital WD800JB-00DUA3 (Special Edition 8 MB cache) disks connected to a
Promise TX2000 (PDC20271) card (RAID1 using ataraid under Linux 2.4.23).

The disks are setup with hdparm at boot time:

/sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hda 
/sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hdc

When running hdparm -tT I get the following:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
 Timing buffered disk reads:  64 MB in  2.46 seconds = 26.02 MB/sec

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
 Timing buffered disk reads:  64 MB in  2.47 seconds = 25.91 MB/sec

Are these normal values? I don't think so. Please advise.

/Nicke


