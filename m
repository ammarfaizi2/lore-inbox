Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbRFGSXT>; Thu, 7 Jun 2001 14:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbRFGSXJ>; Thu, 7 Jun 2001 14:23:09 -0400
Received: from penguins-world.pcsystems.de ([212.63.44.200]:33006 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S262715AbRFGSW6>;
	Thu, 7 Jun 2001 14:22:58 -0400
Message-ID: <3B1FC660.D958CB6C@pcsystems.de>
Date: Thu, 07 Jun 2001 20:22:25 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Khalid Aziz <khalid@fc.hp.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de> <3B1FAF79.DF86DA0A@fc.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >  I/O error: dev 08:01, sector 127304
> > SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
> > [valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
> > ASC=47 ASCQ= 0
> > Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >  I/O error: dev 08:01, sector 127312
> > SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
> > [valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
> > ASC=47 ASCQ= 0
>
> You are seeing lots of parity errors (ASC=47 ASCQ=0). I would suggest
> checking cabling and terminator.

There is in fact no terminator, the scsi disc should terminate the bus
itself. It is directly connected to the onboard aix7880 scsi controller.
I will use another cable in about half an hour (when my friend arrives..)

Thanks for the hint!

Nico

