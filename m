Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277276AbRJJPe6>; Wed, 10 Oct 2001 11:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277275AbRJJPes>; Wed, 10 Oct 2001 11:34:48 -0400
Received: from mail.nep.net ([12.23.44.24]:55556 "HELO nep.net")
	by vger.kernel.org with SMTP id <S277277AbRJJPei>;
	Wed, 10 Oct 2001 11:34:38 -0400
Message-ID: <19AB8F9FA07FB0409732402B4817D75A038B80@FILESERVER.SRF.srfarms.com>
From: "Ryan C. Bonham" <Ryan@srfarms.com>
To: jkniiv@hushmail.com
Cc: "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>,
        "Deanna Bonds (E-mail)" <Deanna_Bonds@adaptec.com>
Subject: RE: RE: Dilemma: Replace Escalade with Adaptec 2400A or Promise S
	uper trak66?
Date: Wed, 10 Oct 2001 11:36:36 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Does it run stably? Have you had any issues with drives 
> failing and going offline without any real reason? Any 
> compatibility issues with certain makes of drives (mine are 
> Maxtor DiamondMax Plus 60, configured as 4x60GB in RAID10)? 

I am running IBM Deskstar.. 3X60 Raid 5.. 
I have had no problems with the card or drives. The Array has been up sence
July.

> And what about those Adaptec utilities (raidutil), are they 
> handling the new driver OK?

Hmm Good question, i dont think i am running the Raid Utils, i set up the
array and sort of forgot about it.. :)
Deanna do RaidUtils work??

Hope this helps in your decission.. 

Ryan

> 
> Oh, I happened to stumble on the Open Source Newsletter at 
> opensource.adaptec.com and was indeed hinted that the 2400A 
> is a full member of the Adaptec I2O clan, but it was so 
> vaguely put I wasn't sure really.
> 
> Thanks for your input,
> 
>   // Jarkko
> 
> On Wed, 10 Oct 2001 10:25:39 -0400, "Ryan C. Bonham" 
> <Ryan@srfarms.com> wrote:
> >All the Adaptec I2O RAID products use the same driver, including the
> >ATA(Adaptec 2400A) based one.  The ATA drives/arrays will 
> appear to the OS
> >as a scsi
> >device.  The driver was in the last Linus release also (2.4.10). I am
> >running the adaptec 2400A on a 2.4.6 kernel which i patch 
> with adaptecs
> >dirvers, with no problems..
> >
> >Ryan
> >
> >
> >
> >> -----Original Message-----
> >> From: jkniiv@hushmail.com [mailto:jkniiv@hushmail.com]
> >> Sent: Wednesday, October 10, 2001 10:08 AM
> >> To: linux-kernel@vger.kernel.org
> >> Subject: Dilemma: Replace Escalade with Adaptec 2400A or Promise
> >> Supertrak66?
> >>
> >>

> >> The Adaptec 2400A is presumably very much like the 2100S SCSI
> >> model. Adaptec has released some binary only drivers and
> >> utilities but none for the 2.4 kernel line. There are however
> >> some beta stage drivers (dpt_i2o) available as source for the
> >> SCSI models. Now, I happened to list the symbols of the
> >> binary only driver for the 2400A (dpt_i2o.o) and came to the
> >> conclusion that they are the very same as in the SCSI driver
> >> source! Any differences ought to be small. Now, I'm wondering
> >> whether anybody has already tested the driver with a 2400A? Alan?
> >>
> >> Yours,
> >>

> 
> 
