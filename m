Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSFROIg>; Tue, 18 Jun 2002 10:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317416AbSFROIf>; Tue, 18 Jun 2002 10:08:35 -0400
Received: from relay03.valueweb.net ([216.219.253.237]:1806 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S317415AbSFROIe>; Tue, 18 Jun 2002 10:08:34 -0400
Message-ID: <005d01c216d1$53fc8830$8201a8c0@arcoi0s17j2t0x>
From: "Garet Cammer" <arcolin@arcoide.com>
To: "Martin Dalecki" <dalecki@evision-ventures.com>
Cc: "Andre Hedrick" <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Need Taskfile Access
Date: Tue, 18 Jun 2002 10:06:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some time now we have been writing user applications that send ATAPI
commands to the IDE bus to initialize and configure our hardware RAID 1
controllers. This has been working well, thanks to Andre's patch that gave
us taskfile access through the ioctl API. We were counting on it to be a
permanent part of the 2.5/2.6 kernel, since there is a lot of hardware in
the field using these apps.
Imagine our surprise when we discovered that taskfile access was being
abandoned completely!
Although we understand that the kernel may need to filter some commands, why
can't applications access at least the Smart commands? Help!
Regards,
Garet Cammer
Software Development
Arco Computer Products
(954) 925-2688

