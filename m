Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUGMJHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUGMJHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 05:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUGMJHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 05:07:46 -0400
Received: from smtpout3.compass.net.nz ([203.97.97.135]:195 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S264650AbUGMJHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 05:07:45 -0400
Date: Tue, 13 Jul 2004 21:07:55 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@linuxcd
Reply-To: haiquy@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.27-rc3 __alloc_pages: 3-order allocation failed (gfp=0x20/0)
Message-ID: <Pine.LNX.4.53.0407132101340.437@linuxcd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I got a lot such errors log when run dmesg and the rpogram cdda2wav seems stop
extracting audio cds

Some others log like:

scsi : aborting command due to timeout : pid 3260, scsi0, channel 0, id 1, lun 0 0x00 00 00 00 00 00
scsi : aborting command due to timeout : pid 3260, scsi0, channel 0, id 1, lun 0 0x00 00 00 00 00 00
SCSI host 0 abort (pid 3260) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 3260) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 3256, scsi0, channel 0, id 1, lun 0 0xbe 04 00 00 00 00 00 00 4b 10 00 00
hdd: lost interrupt

I use ide-scsi for ide cdrom as cdda2wav requires this. If I use normal ide-cd
and use cdparanoia it works as normal.


What should I do to help debuging this problem?

Regards,

Steve Kieu
