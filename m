Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262923AbRF0PAc>; Wed, 27 Jun 2001 11:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbRF0PAX>; Wed, 27 Jun 2001 11:00:23 -0400
Received: from mail2.megatrends.com ([155.229.80.11]:10514 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S262923AbRF0PAG> convert rfc822-to-8bit; Wed, 27 Jun 2001 11:00:06 -0400
Message-ID: <1355693A51C0D211B55A00105ACCFE6402D25E79@ATL_MS1>
From: "Atul Mukker." <Atulm@ami.com>
To: "'Kelly Martin'" <kellym@fb00.fb.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: random failures with megaraid driver on 2.4.4 SMP
Date: Wed, 27 Jun 2001 10:54:39 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This issue has been acknowledged on 1M/2M controllers with firmware H.01.07
and H.01.08.

Atul Mukker
Supervising Software Engineer
RAID R&D
American Megatrends Inc.
6145-F Northbelt Parkway Norcross GA-30071
E-mail: atulm@ami.com
HTTP: www.ami.com



> -----Original Message-----
> From:	Kelly Martin [SMTP:kellym@fb00.fb.org]
> Sent:	Wednesday, June 27, 2001 9:26 AM
> To:	Kelly Martin; 'linux-kernel@vger.kernel.org'
> Subject:	RE: random failures with megaraid driver on 2.4.4 SMP
> 
> FYI, patching megaraid.c to disable 64-bit mode avoids the problem.
> Apparently, the firmware provided by HP for this card is buggy in 64 bit
> mode.  System has run stably for two weeks after applying the patch.
> Contact me if you want the patch.  Thanks to Martti Hyppänen for the
> patch.
> 
> (Posted because I've received followup inquiries; please cc: replies.)
> 
> Kelly Martin
> American Farm Bureau Federation
> kellym@fb.org
> 
> > -----Original Message-----
> > From:	Kelly Martin 
> > Sent:	Thursday, June 07, 2001 12:40 PM
> > To:	'linux-kernel@vger.kernel.org'
> > Subject:	random failures with megaraid driver on 2.4.4 SMP
> > 
> > I have an HP Netserver 1000r (dual Pentium 3) with a HP NetRAID-1M card
> > running Linux 2.4.4 with the megaraid driver included in 2.4.4 that has
> > twice now experienced kernel panics related to file system damage which
> > appear to be caused by the megaraid driver going mad and scribbling
> > randomly on the drive.  We have using this same driver with 2.2.x
> kernels
> > on other uniprocessor machines with the same NetRAID card for over a
> year
> > with no failures, so it seems likely that this is either a 2.4.x problem
> > or an SMP problem with this driver.  
> > 
> > This machine is slated to become a production system and I do not have a
> > similiarly-configured spare machine, so I am not going to pursue this
> > problem at this time.  This card works fine under 2.2.x so we are going
> to
> > use 2.2.19 on this machine for now.  However, doing so makes our second
> > processor little more than a space heater.  I have not tried using other
> > versions of the megaraid driver or kernels other than 2.4.4; I simply
> > cannot spare the time right now.
> > 
> > I am not subscribed to the mailing list; please cc: replies.
> > 
> > Kelly Martin
> > American Farm Bureau Federation
> > kellym@fb.org
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
