Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132068AbQKZQg6>; Sun, 26 Nov 2000 11:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132144AbQKZQgs>; Sun, 26 Nov 2000 11:36:48 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:26384 "EHLO
        filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
        id <S132068AbQKZQgo>; Sun, 26 Nov 2000 11:36:44 -0500
Date: Sun, 26 Nov 2000 08:06:39 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Paul Jakma <paulj@itg.ie>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: problem with hp C1537A tape drives
In-Reply-To: <Pine.LNX.4.30.0011261547010.892-100000@rossi.itg.ie>
Message-ID: <Pine.LNX.4.30.0011260754010.1949-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Paul ,  Is the tape drive the only drive on that controller ?

 -	If it is the only drive then , I have just one suggestion
	-verify- all cables are seated correctly & -verify- that there
	is proper termination on the bus .

 -	If it is Not the only drive then ,
	Try grabbing an pci scsi card of known goodness & place the tape
	drive on that all by itself (just as a test) , making sure of
	proper termination .
	If that works then reveiw the configurations of the other
	drives/tapes/... that are on the bus causing problems .
		Hth ,  JimL

On Sun, 26 Nov 2000, Paul Jakma wrote:
> Ooops.. yes.. that info might have been useful. :)
> The box is a Compaq PL3000. Chipset is the onboard Sym 53c876, driven
> by the ncr53c8xx driver. Drive is external.
> Kernel is RH6.2 default 2.2.14-5.0smp.

> On Sun, 26 Nov 2000, Mr. James W. Laferriere wrote:
> > 	Hello Paul ,  Could you add a little more info like which scsi
> > 	chipset you are using & what the driver version is & what kernel
> > 	version you are running also (One more )& how you have the drive
> > 	chained to the scsi-bus .  Someplace there is a pointer on howto
> > 	reset the scsi-bus from the /proc system , BUT the method is
> > 	highly not recommended .  Hth ,  JimL
       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
