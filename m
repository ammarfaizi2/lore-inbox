Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRBQBGa>; Fri, 16 Feb 2001 20:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131409AbRBQBGV>; Fri, 16 Feb 2001 20:06:21 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:44039 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129854AbRBQBGS>; Fri, 16 Feb 2001 20:06:18 -0500
Message-ID: <3A8DCE7D.3747DB41@t-online.de>
Date: Sat, 17 Feb 2001 02:06:05 +0100
From: wal_teichmann@t-online.de (Wolfgang Teichmann)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.0/1/1-ac15 and ncr53c810a
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have problems using my scanner (HP C6270A connected to ncr53c810a)
with xsane.

I always get the error message:

error during read: Error during device I/O


Feb 15 23:57:27 localhost kernel: Attached scsi generic sg2 at scsi0,
channel 0, id 4, lun 0, type 3
Feb 15 23:57:27 localhost kernel: ncr53c810a-0-<4,*>: target did not
report SYNC.
Feb 15 23:58:01 localhost kernel: scsi : aborting command due to timeout
: pid 0, scsi0, channel 0, id 4, lun 0 Read (6) 00 00 7b 66 00
Feb 15 23:58:01 localhost kernel: ncr53c8xx_abort: pid=0
serial_number=1099 serial_number_at_timeout=1099
Feb 15 23:58:04 localhost kernel: SCSI host 0 abort (pid 0) timed out -
resetting
Feb 15 23:58:04 localhost kernel: SCSI bus is being reset for host 0
channel 0.
Feb 15 23:58:04 localhost kernel: ncr53c8xx_reset: pid=0 reset_flags=2
serial_number=1099 serial_number_at_timeout=1099
Feb 15 23:58:04 localhost kernel: ncr53c810a-0: restart (scsi reset).

With kernel 2.2.x I have no problems accessing the scanner with xsane.

Any idea?




