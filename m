Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130946AbRCFFlz>; Tue, 6 Mar 2001 00:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130948AbRCFFlq>; Tue, 6 Mar 2001 00:41:46 -0500
Received: from mail005.syd.optusnet.com.au ([203.2.75.229]:6805 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S130946AbRCFFlf>; Tue, 6 Mar 2001 00:41:35 -0500
Message-ID: <003901c0a600$1a5d3220$0200a8c0@dingoblue.net.au>
From: "Adrian Levi" <a_levi@dingoblue.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: Possible Bug? 2.2.18
Date: Tue, 6 Mar 2001 15:41:31 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

running 2.2.18 on a AMD486DX4 - 120 with 34Mb Ram running RH6.2 I obtained
these errors while trying to copy files from a burnt CD.

Mar  6 10:13:33 lefty kernel: hdb: command error: status=0x51 { DriveReady
SeekComplete Error }
Mar  6 10:13:33 lefty kernel: hdb: command error: error=0x54
Mar  6 10:13:33 lefty kernel: end_request: I/O error, dev 03:40 (hdb),
sector 140520
Mar  6 10:13:33 lefty kernel: ATAPI device hdb:
Mar  6 10:13:34 lefty kernel:   Error: Illegal request -- (Sense key=0x05)
Mar  6 10:13:34 lefty kernel:   Illegal mode for this track or incompatible
medium -- (asc=0x64, ascq=0x00)
Mar  6 10:40:57 lefty kernel: hdb: command error: status=0x51 { DriveReady
SeekComplete Error }
Mar  6 10:40:57 lefty kernel: hdb: command error: error=0x54
Mar  6 10:40:57 lefty kernel: ATAPI device hdb:
Mar  6 10:40:57 lefty kernel:   Error: Illegal request -- (Sense key=0x05)
Mar  6 10:40:57 lefty kernel:   Illegal mode for this track or incompatible
medium -- (asc=0x64, ascq=0x00)

The system locked hard with the drive light on, not accepting commands via
telnet. I plugged in a Keyboard and Monitor and line after line of:

hdb: Missed Interupt   (As close as i can get via memory).

Holding Ctrl+Alt+SysRq responded in what looked like the screen switching
between a login screen and the afformentioned error messages.

Please cc replies to a_levi@dingoblue.net.au

Adrian Levi.



