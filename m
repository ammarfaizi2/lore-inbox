Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbSBKCOE>; Sun, 10 Feb 2002 21:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSBKCNn>; Sun, 10 Feb 2002 21:13:43 -0500
Received: from oe46.law9.hotmail.com ([64.4.8.18]:28426 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286303AbSBKCNe>;
	Sun, 10 Feb 2002 21:13:34 -0500
X-Originating-IP: [24.29.113.54]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Problem with I2O block Driver in 2.4.17 and 2.4.18-pre9
Date: Sun, 10 Feb 2002 21:13:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE46xJO7Z6KTi1P6SM500013d46@hotmail.com>
X-OriginalArrivalTime: 11 Feb 2002 02:13:28.0595 (UTC) FILETIME=[B1D2DE30:01C1B2A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I have a rackmount system with an Intel RAID controller doing RAID 1
mirroring.  This controller uses the I2O drivers.  I've compiled 2.4.17 and
1.4.18-pre9 with the I2O drivers linked into the kernel.  However both these
kernels would then oops (looks like on initializing the I2O block driver)
when the kernel boots up.  This problem does not appear to be present in the
RedHat 2.9.7 kernel and the Linus 2.4.5 kernels.  However in my tests with
both those kernels the I2O drivers were loaded as modules, if that makes any
difference.  Unfortunately because of where this system is located I was
unable and will be unable in the near future to generate an Ooops report.

    Is there a known bug in the I2O drivers (probably block) included in the
current 2.4.17 and 2.4.18-pre9 kernels?

    Are the latest I2O drivers or patches located anywhere?

    Thanks in advance for any help.
