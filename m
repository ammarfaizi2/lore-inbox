Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSHLSkE>; Mon, 12 Aug 2002 14:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318777AbSHLSkE>; Mon, 12 Aug 2002 14:40:04 -0400
Received: from WARSL402PIP5.highway.telekom.at ([195.3.96.79]:47128 "HELO
	email04.aon.at") by vger.kernel.org with SMTP id <S317508AbSHLSkE>;
	Mon, 12 Aug 2002 14:40:04 -0400
Message-ID: <000501c24230$8a29bdd0$8c00000a@sledgehammer>
From: "Peter Klotz" <peter.klotz@aon.at>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.19 and 2.4.20-pre1 don't boot
Date: Mon, 12 Aug 2002 20:46:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Up to 2.4.19-rc1 my system worked fine but 2.4.19 and 2.4.20-pre1 produce
the following message at startup:

Mounting root filesystem
ide-floppy driver 0.99.newide
kmod: failed to exec /sbin/modprobe -s -k ide-cd, errno = 2
hda: driver not present
mount: error 6 mounting ext3
pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
Freeing unused kernel memory: 108k freed
Kernel panic: No init found. Try passing init= option to kernel.

I have no idea what causes the problem since I did not change the kernel
configuration.

The system configuration is as follows:
Athlon XP 1600+
Asus A7V266-E (VIA KT266A)
512MB RAM
hda, hdc are IDE Harddisks

Any suggestions welcome.

