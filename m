Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUBKOaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUBKOaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:30:20 -0500
Received: from pop.gmx.de ([213.165.64.20]:35020 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264392AbUBKOaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:30:12 -0500
Date: Wed, 11 Feb 2004 15:30:10 +0100 (MET)
From: "Roman Jordan" <RomanJordan@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: kernel panic after reboot
X-Priority: 3 (Normal)
X-Authenticated: #532004
Message-ID: <29653.1076509810@www26.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i have an absolut strange behaviour. I use suse kernel 2.4.18 and a VIA
based motherboard. There is one HD which is a part of a software raid in the
system. I start the system with only one disk from this array. The raid driver
notices that there is only one disk and the system starts. I can repeat this as
often i want.
But if i change the motherboard (which should be the same type) i can only
boot one time. The second boot will result in the following message:

kernel panic: Unable to mount root fs 9:00

Some time before i got: Unable to read superblock

The result is, that the kernel can't access any partition (the same error
message for all partitions). If i insert the "wrong" disk into an other linux
pc, i can't mount it. I got the same message about invalid superblocks.
I can repeat this behaviour. The result is always the same.

The only visible differences between this two boards are the BIOS Version
and the southbridge VT82C686 chip identifier. I have swapped the bios chips
between the two boards, but nothing changes.
The identifier of the via VT82C686 chip on the running board is 13C7K2674
and on the "strange" board it is 13C7K2676 (newer type).

If i use a second board of the newer type (chip id 13C7K2676) the same error
occurs. At the moment all boards using the VT82C686 - 13C7K2676 chip
destroys the partition on the hard disk.

Any ideas?

Best regards,
Roman Jordan

-- 
GMX ProMail (250 MB Mailbox, 50 FreeSMS, Virenschutz, 2,99 EUR/Monat...)
jetzt 3 Monate GRATIS + 3x DER SPIEGEL +++ http://www.gmx.net/derspiegel +++

