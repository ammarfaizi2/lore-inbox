Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272101AbRIELWB>; Wed, 5 Sep 2001 07:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272099AbRIELVv>; Wed, 5 Sep 2001 07:21:51 -0400
Received: from pD9532FCA.dip.t-dialin.net ([217.83.47.202]:58892 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S272093AbRIELVs>; Wed, 5 Sep 2001 07:21:48 -0400
Date: Wed, 5 Sep 2001 11:21:27 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Frank Schneider <SPATZ1@t-online.de>
Cc: Antonio Miguel Trindade <trindade@dei.uc.pt>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors
Message-ID: <20010905112127.A21405@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Frank Schneider <SPATZ1@t-online.de>,
	Antonio Miguel Trindade <trindade@dei.uc.pt>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200109050621.f856LAK00824@ambassador.mathewson.int> <3B95DB22.866EDCA3@mediascape.de> <3B95EA8F.93B27304@t-online.de> <200109051027.f85ARmM10012@polaris.dei.uc.pt> <3B960208.7121318@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B960208.7121318@t-online.de>; from SPATZ1@t-online.de on Wed, Sep 05, 2001 at 12:44:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2001 at 12:44:24PM +0200, Frank Schneider wrote:
> Antonio Miguel Trindade schrieb:
> > Em Quarta 05 Setembro 2001 10:04, Frank Schneider escreveu:
> > > Olaf Zaplinski schrieb:
> > >
> > > I had this effect too here (RH7.1, Kernel 2.4.3), but i put it on a
> > > wrong termination of the LVD Bus...be careful if you have LVD-Drives
> > > with a "Termination"-Jumper...(e.g. IBM DGHS18V)...this Termination is
> > > only usable if you use the drive as Single Ended SCSI-UW, *not* if you
> > > use the drive i a true LVD-environment !
> > >
> > 
> >    According to IBM specs, _no LVD drive has terminators built-in_... I have

There are definitely some that have this SE-Termination jumper.

> 
> But as said, my DGHS-Disk has a build-in terminator for use with
> UW-buses...the bad thing is, that if you "terminate" the LVD-bus with
> this, it seems to work...for some time...i had "/" on it and a part of
> my /home-RAID5, and it run 2 weeks....

Usually when a single device in a LVD chain is operated in SE mode all LVD
devices also switch to SE mode automatically. The use of a SE terminator
such as the one on your harddisk qualifies for SE operation.

But in SE mode you are tied to the much stricter specifications like length
of cable etc. compared to LVD mode. 

So maybe you just exceeded specifications too much.
 

Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
