Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130110AbRA3UFM>; Tue, 30 Jan 2001 15:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbRA3UFD>; Tue, 30 Jan 2001 15:05:03 -0500
Received: from mail.cambridge.com ([208.148.185.5]:14579 "EHLO
	newmail.cambridge.com") by vger.kernel.org with ESMTP
	id <S130110AbRA3UEs>; Tue, 30 Jan 2001 15:04:48 -0500
From: "Douglas W. Marcey" <dougm@cambridge.com>
To: <linux-kernel@vger.kernel.org>
Subject: Megaraid updates for 2.4?
Date: Tue, 30 Jan 2001 15:08:21 -0500
Message-ID: <NNELJLEHNPOMNALEOJAIOEDECBAA.dougm@cambridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this question has been answered already, or if this is the wrong
venue for it but I have done a lot of searching and haven't been able to
find much.

What is the status of the megaraid driver in 2.4.x? I am a little confused
as to what versions are what so I will summarize what I know:

	The latest version of the driver from AMI's web site is 1e08 they say that
it works with 2.2 and 2.4 kernels (which I guess it does) but it does not
seem to properly recognize my AMI Enterprise 1600 Raid controller under
either kernel.

	As of 2.2.19pre7 the latest version of the driver seems to be 1.11. The
comments at the top of linux/drivers/scsi/megaraid.c seem to conflict. They
say that the driver is version 1b08b but they have change log entries up
through 1.11, so I assume the current version is 1.11 and that the Version:
as the top of the file is just out of date. Anyway this version of the
driver recognizes my card perfectly and seems to be working well with it.

	The current version in 2.4.1 seems to be 1.07 which seems very old in
comparison to 2.2.19pre7. It does not recognize my card and will not work.
This is annoying because the Enterprise 1600 is a 64bit PCI card and my
understanding is that the performance for such a bus is better under 2.4.x
than under 2.2.x and the server it is running on is primarily a file server
using NFS and SMB and I understand the NFS performance under 2.4.x is better
too (most of my clients for NFS are Irix systems).

	So my question is... are there plans to bring the 2.4.x driver up to date,
I would try it myself but my expertise in this area is very much lacking.

	Any information is greatly appreciated,

				--Doug.

--
Doug Marcey
Systems Administrator
Cambridge Research Associates

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
