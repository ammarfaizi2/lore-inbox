Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbUB0PMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 10:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbUB0PMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 10:12:32 -0500
Received: from mail1.allneo.com ([216.185.99.210]:39662 "EHLO mail1.allneo.com")
	by vger.kernel.org with ESMTP id S262991AbUB0PMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 10:12:30 -0500
From: "Brad Cramer" <bcramer@callahanfuneralhome.com>
To: <root@chaos.analogic.com>
Cc: "'Guennadi Liakhovetski'" <g.liakhovetski@gmx.de>,
       "'Linux kernel'" <linux-kernel@vger.kernel.org>,
       <linux-scsi-owner@vger.kernel.org>
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
Date: Fri, 27 Feb 2004 10:12:22 -0500
Message-ID: <008d01c3fd44$1d5ec760$6501a8c0@office>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.53.0402270955240.7189@chaos>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, yes I did rmmod the sym53c8xx driver before modprobeing the
sym53c8xx_2
Brad

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent: Friday, February 27, 2004 9:59 AM
To: Brad Cramer
Cc: 'Guennadi Liakhovetski'; Linux kernel; linux-scsi-owner@vger.kernel.org
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x

On Fri, 27 Feb 2004, Brad Cramer wrote:

> OK, it took me some time, but here is what I did.
> I installed a debian kernel image (kernel_image-2.4.24-1-k7) to tell if
this
> was just a problem with the driver or because of the upgrade to kernel
2.6.x
> I the sym53c8xx and sym53c8xx_2 drivers are modules and this is what I
got.
>
> bigdaddy:~# modprobe sym53c8xx
> PCI: Found IRQ 11 for device 00:0f.0
> PCI: Sharing IRQ 11 with 00:0d.0
> PCI: Sharing IRQ 11 with 00:0d.1
[SNIPPED...everything was fine]

>
> and everything works fine, then when I do :
>

Did you `rmmod` the previos driver???  If not, you have
two drivers pounding on the same board, attempting to
handle the same disk(s). All bets are off.

> bigdaddy:~# modprobe sym53c8xx_2
[SNIPPED...]

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.




