Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264687AbSJ3OKD>; Wed, 30 Oct 2002 09:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264685AbSJ3OKD>; Wed, 30 Oct 2002 09:10:03 -0500
Received: from [80.247.74.2] ([80.247.74.2]:17828 "EHLO foradada.isolaweb.it")
	by vger.kernel.org with ESMTP id <S264684AbSJ3OJy>;
	Wed, 30 Oct 2002 09:09:54 -0500
Message-Id: <5.1.1.6.0.20021030151220.03830ec0@mail.isolaweb.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 30 Oct 2002 15:14:50 +0100
To: root@chaos.analogic.com
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: SDT-9000 Problem [was Re: your mail]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1021030090019.5487A-100000@chaos.analogic.co
 m>
References: <5.1.1.6.0.20021030132848.03a12ec0@mail.isolaweb.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-scanner: scanned by Antivirus Service IsolaWeb Agency - (http://www.isolaweb.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09.04 30/10/02 -0500, you wrote:
>On Wed, 30 Oct 2002, Roberto Fichera wrote:
>
> > I've a problem with a DAT on a Compaq Proliant ML350 with PIII 1GHz,
> > 1Gb RAM, RAID controller Smart Array 451 with 3 x HDD 9Gb RAID 5
> > and an internal SCSI controller Adaptec 7899 Ultra160 where is connected
> > only a DAT 12/24 Gb. Current installed distribution is RH7.3 with its 
> kernel
> > 2.4.18-10 but I've tryed the standard 2.4.19 with the same problem.
> > The problem is that the DAT don't work any more with Linux. This DAT work
> > well on Win2K :-(! Below  there is some logs and a 'ps fax' showing a 
> tar in
> > D state.
> >
> > Does anyone know a solution ?
>
> >
> > Adaptec AIC7xxx driver version: 6.2.6
> > aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> > Corrupted Serial EEPROM
>^^^^^^^^^^^^^^^^^^^^^^^^^
>
>I think your controller has fallen-back into survival mode
>because it lost it's mind. You may want to upgrade the
>controller BIOS to fix this problem. Then, see if it handles
>tapes okay.

Grrr!!! I haven't see this one! I must look better the dmesg output ;-)
Thanks I'll try to upgrade the controller BIOS to see if this fix the
problem.



>Cheers,
>Dick Johnson
>Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
>    Bush : The Fourth Reich of America
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

Roberto Fichera.


______________________________________
E-mail protetta dal servizio antivirus di IsolaWeb Agency & ISP
http://wwww.isolaweb.it
