Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129808AbRB0Ttl>; Tue, 27 Feb 2001 14:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129799AbRB0TtX>; Tue, 27 Feb 2001 14:49:23 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:47614 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S129798AbRB0TtH> convert rfc822-to-8bit; Tue, 27 Feb 2001 14:49:07 -0500
Message-Id: <5.0.2.1.2.20010227114430.026f9008@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 27 Feb 2001 11:47:11 -0800
To: "Daniela Engert" <dani@ngrt.de>,
        "Jason Rappleye" <rappleye@cse.Buffalo.EDU>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Re: timeout waiting for DMA
Cc: "jonesm@ccr.buffalo.edu" <jonesm@ccr.buffalo.edu>
In-Reply-To: <20010227063147.3F8674F06@mail.medav.de>
In-Reply-To: <Pine.GSO.4.21.0102261526330.15135-100000@pollux.cse.Buffalo.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Iv'e seen this on a system with 36" IDE ata/100 cables.  I have the same 
exact system using 24" IDE ultra ata/100 cables and I get no such 
errors.  These two systems are exactly the same and are using the same 
drivers, same hardware.
The only difference is the type of cable used.  Could this be due to bad 
cables as well?  (I know tha CRC errors are caused by bad cables, but this 
is the only difference in the two boxes that I have).

Keep the cables as short as possible, 18" is supposed to be the limit.

And please post again if you successfully troubleshoot this problem.

Jasmeet.

At 07:35 AM 2/27/2001 +0100, Daniela Engert wrote:
>Hi Jason!
>
>On Mon, 26 Feb 2001 15:41:04 -0500 (EST), Jason Rappleye wrote:
>
> >I'm running kernel 2.4.2 on an SGI 1100 (dual PIIIs) with a Serverworks
> >III LE based motherboard. The disk is a Seagate ST330630A. The disk has
> >DMA enabled at boot time :
>
> >hda: ST330630A, ATA DISK drive
> >hda: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=3720/255/63, UDMA(33)
>
> >but after a while (eg partway through running bonnie with a 1GB file) I
> >get the following errors:
>
> >Feb 24 22:51:02 nash2 kernel: hda: timeout waiting for DMA
> >Feb 24 22:51:02 nash2 kernel: ide_dmaproc: chipset supported 
> ide_dma_timeout
> >func only: 14
> >Feb 24 22:51:02 nash2 kernel: hda: irq timeout: status=0x58 { DriveReady
> >SeekComplete DataRequest }
> ><repeats a few times>
> >Feb 24 22:51:32 nash2 kernel: hda: DMA disabled
>
> >I can reenable DMA without any problems, but after some additional disk
> >activity (eg running bonnie again), the error occurs again.
>
> >Additional information on my hardware is given below. Any suggestions on
> >how this can be resolved?
>
>Reduce the IDE channel speed to UltraDMA mode 1 or less.
>
>Ciao,
>   Dani
>
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>Daniela Engert, systems engineer at MEDAV GmbH
>Gräfenberger Str. 34, 91080 Uttenreuth, Germany
>Phone ++49-9131-583-348, Fax ++49-9131-583-11
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


- - -
Jasmeet Sidhu
Unix Systems Administrator
ArrayComm, Inc.
jsidhu@arraycomm.com
www.arraycomm.com


