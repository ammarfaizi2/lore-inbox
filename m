Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272074AbRIEKqF>; Wed, 5 Sep 2001 06:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272076AbRIEKp4>; Wed, 5 Sep 2001 06:45:56 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:17171 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272074AbRIEKpo>; Wed, 5 Sep 2001 06:45:44 -0400
Message-ID: <3B960208.7121318@t-online.de>
Date: Wed, 05 Sep 2001 12:44:24 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Antonio Miguel Trindade <trindade@dei.uc.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors
In-Reply-To: <200109050621.f856LAK00824@ambassador.mathewson.int> <3B95DB22.866EDCA3@mediascape.de> <3B95EA8F.93B27304@t-online.de> <200109051027.f85ARmM10012@polaris.dei.uc.pt>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Miguel Trindade schrieb:
> 
> Em Quarta 05 Setembro 2001 10:04, Frank Schneider escreveu:
> > Olaf Zaplinski schrieb:
> >
> > I had this effect too here (RH7.1, Kernel 2.4.3), but i put it on a
> > wrong termination of the LVD Bus...be careful if you have LVD-Drives
> > with a "Termination"-Jumper...(e.g. IBM DGHS18V)...this Termination is
> > only usable if you use the drive as Single Ended SCSI-UW, *not* if you
> > use the drive i a true LVD-environment !
> >
> > I learnt this the hard way, because i used this "Termination"-jumper and
> > the system bootet without problems and ran about 2 weeks...then the
> > above errors occured, followed by system crashes....after reading the
> > original ibm-docs, and not the oem-reseller-crap, the reason was clear.
> >
> 
>    According to IBM specs, _no LVD drive has terminators built-in_... I have
> several servers with LVD drives (all IBM) and none of them has terminators,
> even in SE mode. You always have to use an external terminator...

That was it what i thought too...but if you get a copied sheet from your
vendor, and there a jumper is named "Termination on" and the sheet also
says you can use this, then you probably think the disk has a
LVD-Terminator build-in...although such a terminator is quite simple,
some resistors, perhaps a small chip, not more...it would be possible to
integrate it in the drive logic...

But as said, my DGHS-Disk has a build-in terminator for use with
UW-buses...the bad thing is, that if you "terminate" the LVD-bus with
this, it seems to work...for some time...i had "/" on it and a part of
my /home-RAID5, and it run 2 weeks....

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
