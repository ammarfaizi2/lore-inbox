Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271352AbTHDBFO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 21:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271353AbTHDBFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 21:05:14 -0400
Received: from [202.20.92.128] ([202.20.92.128]:41152 "EHLO quattro.co.nz")
	by vger.kernel.org with ESMTP id S271352AbTHDBFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 21:05:09 -0400
Message-ID: <006601c35a24$748372c0$0401a8c0@SIMON>
From: "Simon Garner" <sgarner@expio.co.nz>
To: <linux-kernel@vger.kernel.org>
Cc: <taroon-beta-list@redhat.com>
Subject: MSI K8D-Master - GART error 3
Date: Mon, 4 Aug 2003 13:05:05 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lists,

(please cc me on any replies as I am not currently subscribed to lkml)

I have recently installed Red Hat Enterprise Linux 2.9.5 Beta (Taroon)
x86-64 on an MSI K8D-Master (MSI-9131) motherboard with Dual Opteron 240
processors.

While the system is running, every 30 seconds I get the following on
system console and in /var/log/messages:

Aug  4 12:52:41 terra kernel: Northbridge status 9405c00000000a13
Aug  4 12:52:41 terra kernel: GART error 3
Aug  4 12:52:41 terra kernel: Lost an northbridge error
Aug  4 12:52:41 terra kernel: NB error address 00000000002e0310
Aug  4 12:53:11 terra kernel: Northbridge status 9405c00000000a13
Aug  4 12:53:11 terra kernel: GART error 3
Aug  4 12:53:11 terra kernel: Lost an northbridge error
Aug  4 12:53:11 terra kernel: NB error address 0000000004432320

and so forth. This also occurred under SuSE Linux 8.2 Beta x86_64 and it
even occurs while running the Red Hat installer (isolinux).

Otherwise the system seems to run fine. Can anyone shed some light on
what this means, and how concerned should I be? Is it fixable?

I thought GART referred to the AGP aperture - this system doesn't
actually have an AGP port, could that be the cause of this? (It has an
onboard ATI Rage XL chip)

# uname -a
Linux terra 2.4.21-1.1931.2.349.2.2.entsmp #1 SMP Fri Jul 18 00:06:19
EDT 2003 x86_64 x86_64 x86_64 GNU/Linux

The system also has an Adaptec 2120S scsi raid card.

cheers,

-Simon

