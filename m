Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267436AbUBROq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267443AbUBROq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:46:26 -0500
Received: from mail2.allneo.com ([216.185.99.212]:63717 "EHLO mail1.allneo.com")
	by vger.kernel.org with ESMTP id S267436AbUBROoZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:44:25 -0500
From: "Brad Cramer" <bcramer@callahanfuneralhome.com>
To: "'Guennadi Liakhovetski'" <g.liakhovetski@gmx.de>,
       "'Brad Cramer'" <bcramer@callahanfuneralhome.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
Date: Wed, 18 Feb 2004 09:44:09 -0500
Message-ID: <00c301c3f62d$ae3e8540$6501a8c0@office>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <Pine.LNX.4.44.0402180030570.2588-100000@poirot.grange>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes that is my drive, but after it scans the scsi bus and finds all the
devices it will not mount any of the partitions. And I know it is not
corrupted partitions because they mount fine under 2.4.18 using the
sym53c8xx driver.
I don't have the exact message in front of me, but when I try to manually
mount the partitions under 2.6.2 I get errors something about parity errors,
again I could get the exact message when I get home tonight.
Brad

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Guennadi
Liakhovetski
Sent: Tuesday, February 17, 2004 6:43 PM
To: Brad Cramer
Cc: 'Guennadi Liakhovetski'; linux-kernel@vger.kernel.org
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x

On Tue, 17 Feb 2004, Brad Cramer wrote:

> sym0: <895> rev 0x1 at pci 0000:00:0f.0 irq 11
> sym0: Tekram NVRAM, ID 7, Fast-40, SE, NO parity
> sym0: SCSI BUS has been reset.
> sym0: SCSI BUS mode change from SE to SE.
> sym0: SCSI BUS has been reset.
> scsi0 : sym-2.1.18f
>   Vendor: SEAGATE   Model: SX4234514         Rev: 9E21
>   Type:   Direct-Access                      ANSI SCSI revision: 02

Isn't this your drive?

> sym0:0:0: tagged command queuing enabled, command queue depth 4.
>   Vendor: PIONEER   Model: DVD-ROM DVD-303R  Rev: 2.00
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: IOMEGA    Model: ZIP 100           Rev: J.02
>   Type:   Direct-Access                      ANSI SCSI revision: 02
>   Vendor: SONY      Model: SDT-5000          Rev: 3.26
>   Type:   Sequential-Access                  ANSI SCSI revision: 02

If not, could you also post the relevant part of your 2.4 boot log for
comparison? If it is, maybe just the enumeration has changed, so, that now
you have to mount it under a different letter?

Guennadi
---
Guennadi Liakhovetski


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


