Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbTA1RfW>; Tue, 28 Jan 2003 12:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTA1Rdr>; Tue, 28 Jan 2003 12:33:47 -0500
Received: from f85.sea2.hotmail.com ([207.68.165.85]:3599 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267484AbTA1Rdo>;
	Tue, 28 Jan 2003 12:33:44 -0500
X-Originating-IP: [218.154.19.20]
From: "tester7 A." <benew666@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Hangs with SW RAID5 and 2l.4.21-pre3aa1 patch
Date: Wed, 29 Jan 2003 02:42:59 +0900
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F85MjT3XOYR00HgHKkR00003b05@hotmail.com>
X-OriginalArrivalTime: 28 Jan 2003 17:42:59.0686 (UTC) FILETIME=[B2FA4060:01C2C6F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Motherboard: Intel SDS2
CPU: P-III 1.4
RAM: 1024MB
IDE Controller: 3Ware 7500-8

I am trying to test S/W Raid5 with 2.4.21-pre3aa1 patch
After making the raidtab and doing 'mkraid' and mount xfs FS on /dev/md1,
it was keeep showing something about 'buffer size changed from 4096 --> 512' 
and back and forth and hangs.
After reset, it would not boot due to Raid failure.

After booting with 2.4.20 kernel and remove the raidtab and boot to the 
2.4.21-pre3aa1 again and repeat the same, 'mkraid' halts and ps -aux shows 
raid5d and raid5syncd is in RW and DW, respectively.

Is it known bug in 2.4.21-pre33aa1 kernel?

Thanks in advance.


_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE* 
http://join.msn.com/?page=features/virus

