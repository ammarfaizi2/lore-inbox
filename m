Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282093AbRK1Jwt>; Wed, 28 Nov 2001 04:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282103AbRK1Jwa>; Wed, 28 Nov 2001 04:52:30 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:20609 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S282093AbRK1JwS>; Wed, 28 Nov 2001 04:52:18 -0500
Message-ID: <034001c177f2$61051ac0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Wouter van Bommel" <wvanbommel@jasongeo.com>,
        "'szonyi calin'" <caszonyi@yahoo.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <002101c177ef$6600ebb0$950000c0@jason.nl>
Subject: Re: 'spurious 8259A interrupt: IRQ7'
Date: Wed, 28 Nov 2001 10:52:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Wouter van Bommel" <wvanbommel@jasongeo.com>
To: "'szonyi calin'" <caszonyi@yahoo.com>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 28, 2001 10:31 AM
Subject: RE: 'spurious 8259A interrupt: IRQ7'


> I also see this messages on various machines each with different hardware.
> I see it on 1 cpu Athlon machines, but also on 2 CPU pentium III machines.

Now here is a strange thing: I see it in my brothers ADSL linux router
syslog *before* they moved it to another place in their room two weeks ago.
Now it never appears, and before it appeared about once a day. They are
using 2.4.13 with ext3.

I'm starting to believe it has something to do with the parallel port being
unconnected, thus sending random signals to the mobo causing an interrupt?
If this is the case it is very possible that it has to do with correct
grounding also...

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden

> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of szonyi calin
> > Sent: Wednesday November 28, 2001 9:59 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: Re: 'spurious 8259A interrupt: IRQ7'
> >
> >
> > Hi
> > Cx 486,  no pci, no network card, same message.
> > >From my experience in PC hardware i know that irq 7 is
> > usually asigned to the parallel port.
> > I know a windoze box which didn't print until i set up
> > in bios that paralel port has irq7.
> >
> > Bye


