Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSGUQn3>; Sun, 21 Jul 2002 12:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSGUQn3>; Sun, 21 Jul 2002 12:43:29 -0400
Received: from vivi.uptime.at ([62.116.87.11]:33930 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id <S316775AbSGUQn2>;
	Sun, 21 Jul 2002 12:43:28 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <linux-kernel@vger.kernel.org>
Subject: Time problem with 2.5.27 on Intel (and kernel freezes...)
Date: Sun, 21 Jul 2002 18:45:22 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <001001c230d6$04de0930$1211a8c0@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3D3ADC3E.9050307@milliways.de>
X-MailScanner: Nothing found, baby
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Something seems to be wrong with my time... Is it the kernel, is
it my real time clock (I don't guess so...). Here is the
strange log... (Please have a look at the timestamps).

Jul 21 16:54:24 test kernel: Console: colour VGA+ 80x25
       ^^^^^^^^
Jul 21 16:53:58 test rc.sysinit: Mounting proc filesystem:  succeeded
       ^^^^^^^^
Jul 21 16:54:24 test random: Initializing random number generator:
succeeded
Jul 21 16:54:24 test kernel: Calibrating delay loop... 591.87 BogoMIPS
Jul 21 16:53:58 test rc.sysinit: Unmounting initrd:  succeeded
Jul 21 16:54:25 test kernel: Memory: 127524k/131060k available (1060k
kernel code, 3148k reserved, 299k data, 208k init, 0k highmem)
Jul 21 16:53:58 test sysctl: net.ipv4.ip_forward = 0
Jul 21 16:54:25 test kernel: Security Scaffold v1.0.0 initialized
Jul 21 16:53:58 test sysctl: net.ipv4.conf.default.rp_filter = 1
Jul 21 16:54:25 test kernel: Dentry-cache hash table entries: 16384
(order: 5, 131072 bytes)
Jul 21 16:53:58 test sysctl: kernel.core_uses_pid = 1
Jul 21 16:54:25 test kernel: Inode-cache hash table entries: 8192
(order: 4, 65536 bytes)
Jul 21 16:53:58 test rc.sysinit: Configuring kernel parameters:
succeeded
Jul 21 16:54:25 test kernel: Mount-cache hash table entries: 512 (order:
0, 4096 bytes)
Jul 21 16:53:58 test date: Sun Jul 21 16:53:51 CEST 2002
Jul 21 16:54:26 test netfs: Mounting other filesystems:  succeeded

!?

I also had the problem that my kernel seems to boot fine, but near the
end of initlevel
3 the kernel hangs. No panic, no log, it's just frozen.

Greetz,
 Oliver


