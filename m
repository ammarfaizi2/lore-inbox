Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWJVJxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWJVJxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 05:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWJVJxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 05:53:37 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:7322 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932317AbWJVJxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 05:53:37 -0400
Date: Sun, 22 Oct 2006 11:53:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: scsi i/o error message
Message-ID: <Pine.LNX.4.61.0610221152450.3696@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


During some hd tests, I picked this up in dmesg after a test copy 
operation took longer than usual. Sign of disk failure?

sd 0:0:8:0: SCSI error: return code = 0x100ff
end_request: I/O error, dev sdb, sector 273328
sd 0:0:8:0: SCSI error: return code = 0x100ff
end_request: I/O error, dev sdb, sector 273344
sd 0:0:8:0: SCSI error: return code = 0x100ff
end_request: I/O error, dev sdb, sector 273360
sd 0:0:8:0: SCSI error: return code = 0x100ff
end_request: I/O error, dev sdb, sector 273376
sd 0:0:8:0: SCSI error: return code = 0x100ff
end_request: I/O error, dev sdb, sector 273392
sd 0:0:8:0: ABORT operation started.
sym0: SCSI BUS reset detected.
sd 0:0:8:0: ABORT operation complete.
sym0: SCSI BUS has been reset.
sd 0:0:8:0: ABORT operation started.
sd 0:0:8:0: ABORT operation failed.
sd 0:0:8:0: DEVICE RESET operation started.
sd 0:0:8:0: DEVICE RESET operation complete.
 target0:0:8: control msgout: c.
sym0: TARGET 8 has been reset.
 target0:0:8: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)


	-`J'
-- 
