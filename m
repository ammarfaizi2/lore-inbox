Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129590AbRB0GeB>; Tue, 27 Feb 2001 01:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129594AbRB0Gdv>; Tue, 27 Feb 2001 01:33:51 -0500
Received: from [213.95.12.190] ([213.95.12.190]:12 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S129590AbRB0Gdj> convert rfc822-to-8bit;
	Tue, 27 Feb 2001 01:33:39 -0500
From: "Daniela Engert" <dani@ngrt.de>
To: "Jason Rappleye" <rappleye@cse.Buffalo.EDU>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "jonesm@ccr.buffalo.edu" <jonesm@ccr.buffalo.edu>
Date: Tue, 27 Feb 2001 07:35:50 +0100 (CET)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.00
In-Reply-To: <Pine.GSO.4.21.0102261526330.15135-100000@pollux.cse.Buffalo.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: timeout waiting for DMA
Message-Id: <20010227063147.3F8674F06@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason!

On Mon, 26 Feb 2001 15:41:04 -0500 (EST), Jason Rappleye wrote:

>I'm running kernel 2.4.2 on an SGI 1100 (dual PIIIs) with a Serverworks
>III LE based motherboard. The disk is a Seagate ST330630A. The disk has
>DMA enabled at boot time :

>hda: ST330630A, ATA DISK drive
>hda: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=3720/255/63, UDMA(33)

>but after a while (eg partway through running bonnie with a 1GB file) I
>get the following errors:

>Feb 24 22:51:02 nash2 kernel: hda: timeout waiting for DMA 
>Feb 24 22:51:02 nash2 kernel: ide_dmaproc: chipset supported ide_dma_timeout 
>func only: 14 
>Feb 24 22:51:02 nash2 kernel: hda: irq timeout: status=0x58 { DriveReady
>SeekComplete DataRequest }
><repeats a few times>
>Feb 24 22:51:32 nash2 kernel: hda: DMA disabled

>I can reenable DMA without any problems, but after some additional disk
>activity (eg running bonnie again), the error occurs again. 

>Additional information on my hardware is given below. Any suggestions on
>how this can be resolved?

Reduce the IDE channel speed to UltraDMA mode 1 or less.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


