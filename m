Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319059AbSHSUWr>; Mon, 19 Aug 2002 16:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319060AbSHSUWq>; Mon, 19 Aug 2002 16:22:46 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29057 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S319059AbSHSUWm>; Mon, 19 Aug 2002 16:22:42 -0400
Subject: Re: IDE?
From: "Timothy D. Witham" <wookie@osdl.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, stp@osdl.org
In-Reply-To: <Pine.LNX.4.10.10208181626580.23171-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10208181626580.23171-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 13:23:14 -0700
Message-Id: <1029788594.1667.70.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 16:38, Andre Hedrick wrote:
> 
> OSDL does not support IDE.
> 
  Well, some of the test systems only have IDE but no we
aren't in the "try all of the IDE chip set" support business.

> See, I asked some time ago about testing raid arrays and a possible thread
> driver.  All you will find there is onboard hosts, and I do not believe
> they stock the all the junk systems out there.
> 

  I'm always open to proposals but I've only really seen requests of
"I would like to test vendor A's hardware".  In my mind that is
a Vendor A problem not a generic OS or driver issue.  Now after
saying that if there is a class of issues that require a configuration
I'm happy to look at providing that.

> 150 systems is a not a large enough sample.
> 

  Agreed even if they are all different chip sets and controllers.

  On a side note:

	I am impressed with the serial ATA and the couple of products
that I've seen so far.  I think that this could remove the last barrier
for ATA drives in larger systems and wait to see what products people
come up with in the near future. 



> 500 ++ w/ various add-in cards * (the number of drive models per vendor) *
> the number vendors  eek stop ....
> 
> Add in ATAPI devices, CFA, etc ...
> 
> You see the combination are of a scale unchecked.
> 
> I started at one point trying to have a single drive vendor with at least
> 1000 or more systems in one lab to test their product over the host
> hardware base, to run kernel checks.  The task was beyond scale.
> 
> All it takes is a bus analyzer and a few systems known to be good to
> perfect the driver.  Then you deal with all the exceptions of the crap
> combinations.
> 
> That is how I do it, since I have a code base that has been run over a
> bus analyzer I know it works.
> 
> Cheers,
> 
> 
> On Sun, 18 Aug 2002, Adam J. Richter wrote:
> 
> > On 2002-08-17, Alan Cox wrote:
> > >Volunteers willing to run Cerberus test sets on 2.4 boxes with IDE
> > >controllers would also be much appreciated. That way we can get good
> > >coverage tests and catch badness immediately
> > 
> > 	From visiting the osdl.org booth a LinuxWorld, I understand
> > that they have a farm of 150 deliberately differently configured
> > computers on which you are supposed to be able to run your own
> > kernel tests on your own kernels.
> > 
> > 	They have a procedure for adding new tests described at
> > http://www.osdl.org/stp/HOWTO.Port_Tests.html.
> > 
> > 	I think it would be informative to run 2.4 ported code and
> > Martin's stack against IDE tests on this system.  With this, you could
> > not only spot problems, but see problems happening in a certain pattern
> > which could sometimes simplify finding a bug.
> > 
> > Adam J. Richter     __     ______________   575 Oroville Road
> > adam@yggdrasil.com     \ /                  Milpitas, California 95035
> > +1 408 309-6081         | g g d r a s i l   United States of America
> >                          "Free Software For The Rest Of Us."
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

