Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSHRXpW>; Sun, 18 Aug 2002 19:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSHRXpW>; Sun, 18 Aug 2002 19:45:22 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:38162
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316538AbSHRXpV>; Sun, 18 Aug 2002 19:45:21 -0400
Date: Sun, 18 Aug 2002 16:38:42 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, stp@osdl.org
Subject: Re: IDE?
In-Reply-To: <200208182249.PAA01041@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.10.10208181626580.23171-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OSDL does not support IDE.

See, I asked some time ago about testing raid arrays and a possible thread
driver.  All you will find there is onboard hosts, and I do not believe
they stock the all the junk systems out there.

150 systems is a not a large enough sample.

500 ++ w/ various add-in cards * (the number of drive models per vendor) *
the number vendors  eek stop ....

Add in ATAPI devices, CFA, etc ...

You see the combination are of a scale unchecked.

I started at one point trying to have a single drive vendor with at least
1000 or more systems in one lab to test their product over the host
hardware base, to run kernel checks.  The task was beyond scale.

All it takes is a bus analyzer and a few systems known to be good to
perfect the driver.  Then you deal with all the exceptions of the crap
combinations.

That is how I do it, since I have a code base that has been run over a
bus analyzer I know it works.

Cheers,


On Sun, 18 Aug 2002, Adam J. Richter wrote:

> On 2002-08-17, Alan Cox wrote:
> >Volunteers willing to run Cerberus test sets on 2.4 boxes with IDE
> >controllers would also be much appreciated. That way we can get good
> >coverage tests and catch badness immediately
> 
> 	From visiting the osdl.org booth a LinuxWorld, I understand
> that they have a farm of 150 deliberately differently configured
> computers on which you are supposed to be able to run your own
> kernel tests on your own kernels.
> 
> 	They have a procedure for adding new tests described at
> http://www.osdl.org/stp/HOWTO.Port_Tests.html.
> 
> 	I think it would be informative to run 2.4 ported code and
> Martin's stack against IDE tests on this system.  With this, you could
> not only spot problems, but see problems happening in a certain pattern
> which could sometimes simplify finding a bug.
> 
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

