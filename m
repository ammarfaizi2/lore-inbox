Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVKQSwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVKQSwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVKQSv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:51:59 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:15626 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932472AbVKQSv7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:51:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 17 Nov 2005 18:51:57.0950 (UTC) FILETIME=[FC9339E0:01C5EBA7]
Content-class: urn:content-classes:message
Subject: Compaq Presario "reboot" problems
Date: Thu, 17 Nov 2005 13:51:58 -0500
Message-ID: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compaq Presario "reboot" problems
Thread-Index: AcXrp/yvwHREzfcGRyakJ2jL/Q35FA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



With Linux-2.4.26 I reported that if a Compaq gets rebooted while
running Linux-2.4.26, it will not be able to restart Windows 2000.
It cam restart Linux fine. Today, I tried the same thing with
Linux-2.6.13.4. It fails, too.

The symptoms are that you just "reboot" Linux. When the GRUB loader
comes up, I select my Windows-2000/professional. That M$ Crap comes
up to where it's just about to start the high-resolution screen.
Then it stops forever, no interrupts, no nothing. I need to disconnect
power and remove the battery to recover.

It appears as though Linux is still restarting as a "warm boot",
rather than a cold boot (in other words, putting magic in the
shutdown byte of CMOS) so the hardware doesn't get properly
initialized. Would somebody please check this out. When changing
operating systems, you need a cold-boot.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
