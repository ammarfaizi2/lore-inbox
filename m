Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSK1Inb>; Thu, 28 Nov 2002 03:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSK1Inb>; Thu, 28 Nov 2002 03:43:31 -0500
Received: from proxy.firewall-by-call.de ([62.116.172.146]:36487 "EHLO
	ibis.city-map.de") by vger.kernel.org with ESMTP id <S265276AbSK1Ina>;
	Thu, 28 Nov 2002 03:43:30 -0500
Message-ID: <077201c296bb$43b4ac40$6600a8c0@topconcepts.net>
From: "Sonke Ruempler" <ruempler@topconcepts.com>
To: "Oleg Drokin" <green@namesys.com>
Cc: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
References: <072801c296b8$2cb01000$6600a8c0@topconcepts.net> <20021128114755.A2724@namesys.com>
Subject: Re: reiserfs bug
Date: Thu, 28 Nov 2002 09:50:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There should be another message in your logs prior to above,
> can you please tell us what was that message?

Nov 28 09:00:12 blah kernel: reiserfs: checking transaction log (device
08:01) ...
Nov 28 09:00:15 blah kernel: reiserfs: replayed 19 transactions in 3 seconds
Nov 28 09:00:15 blah kernel: Using r5 hash to sort names
Nov 28 09:00:15 blah kernel: ReiserFS version 3.6.25
Nov 28 09:00:51 blah kernel: smb_proc_readdir_long:
name=\topconcepts.net\www\pub\doc\_php_manual_ger\www.php.net\SEARC~-N.PHP\*
, result=-2, rcls=1, err=2
Nov 28 09:00:51 blah kernel: smb_proc_readdir_long:
name=\topconcepts.net\www\pub\doc\_php_manual_ger\www.php.net\SOURC~W#.PHP\*
, result=-2, rcls=1, err=2
Nov 28 09:05:15 blah kernel: SCSI disk error : host 2 channel 0 id 1 lun 0
return code = 10000
Nov 28 09:05:15 blah kernel:  I/O error: dev 08:11, sector 283064
Nov 28 09:05:15 blah kernel: SCSI disk error : host 2 channel 0 id 1 lun 0
return code = 10000
Nov 28 09:05:15 blah kernel:  I/O error: dev 08:11, sector 283064
Nov 28 09:05:15 blah kernel: zam-7001: io error in reiserfs_find_entry
Nov 28 09:05:15 blah kernel: SCSI disk error : host 2 channel 0 id 1 lun 0
return code = 10000
Nov 28 09:05:15 blah kernel:  I/O error: dev 08:11, sector 283064
Nov 28 09:05:15 blah kernel: vs-13050: reiserfs_update_sd: i/o failure
occurred trying to update [2 58464 0x0 SD] stat dataSCSI disk error : host 2
channel 0 id 1 lun 0 return code = 10000
Nov 28 09:05:15 blah kernel:  I/O error: dev 08:11, sector 283064
Nov 28 09:05:20 blah kernel: vs-13050: reiserfs_update_sd: i/o failure
occurred trying to update [2 58464 0x0 SD] stat dataSCSI disk error : host 2
channel 0 id 1 lun 0 return code = 10000
Nov 28 09:05:20 blah kernel:  I/O error: dev 08:11, sector 11496
Nov 28 09:05:20 blah kernel: SCSI disk error : host 2 channel 0 id 1 lun 0
return code = 10000
Nov 28 09:05:20 blah kernel:  I/O error: dev 08:11, sector 11504
Nov 28 09:05:20 blah kernel: journal-601, buffer write failed
Nov 28 09:05:20 blah kernel: kernel BUG at prints.c:334!
Nov 28 09:05:20 blah kernel: invalid operand: 0000
Nov 28 09:05:20 blah kernel: CPU:    0

[...]

If you need more logs, just mail me.

