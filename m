Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271725AbRHUQLb>; Tue, 21 Aug 2001 12:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271728AbRHUQLX>; Tue, 21 Aug 2001 12:11:23 -0400
Received: from mail.cdlsystems.com ([207.228.116.20]:54289 "EHLO
	cdlsystems.com") by vger.kernel.org with ESMTP id <S271725AbRHUQLN>;
	Tue, 21 Aug 2001 12:11:13 -0400
Message-ID: <027001c12a5b$e5d29be0$160e10ac@hades>
From: "Mark Cuss" <mcuss@cdlsystems.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel Startup Delay
Date: Tue, 21 Aug 2001 10:11:12 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Return-Path: mcuss@cdlsystems.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: mcuss@cdlsystems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am setting up a server with 4 SCSI hard disks, two of which I will jumper
to have a delayed spin up as to not bake the power supply.  These two drives
will contain a striping RAID.  I am concerned that the kernel will load off
of the other drives and attempt to start this RAID before the disks have
even spun up - is there a way to have the kernel delay its startup for a
certain number of seconds while all the drives spin up?

Any hints are greatly appreciated.

Mark



