Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269100AbRHYULa>; Sat, 25 Aug 2001 16:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269437AbRHYULV>; Sat, 25 Aug 2001 16:11:21 -0400
Received: from mx3.port.ru ([194.67.57.13]:42758 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S269100AbRHYULH>;
	Sat, 25 Aug 2001 16:11:07 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: hahn@coffee.psychology.mcmaster.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Howl of soul...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.212]
Date: Sat, 25 Aug 2001 20:11:23 +0000 (GMT)
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15ajm7-00033e-00@f9.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Does anyone know what this bug actually is, and > > whether there's a possible
> > > workaround without disabling udma entirely?
> >    so if i will disable udma and switch to
> >   -X34 == multiword dma2, then corruptions will go away????
> >
> >    i have a VX chipset/Zida 5DVX with PIIX3...
>
> there's nothing wrong with the chipset/controller; isn't this thread
> about the well-known DTLA problem?  if so, then what mode you use
> is completely irrelevant, since the physical media is degrading.

     i feel like the media isn`t downgrading because
 the badblocks _arent_ physical: low-level drive
 reformat doesnt show anything.
     how i think it may be related to chipset/controller?
 when data is transferred in udma mode, there may be
 checksumming errors, and the wrong crc is being wrote
 to the disk.
     so when data is being accessed, bah - you are in
 shit...

 although, this is only a theory...

---


cheers,


   Samium Gromoff
