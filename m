Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130142AbQLNPWV>; Thu, 14 Dec 2000 10:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbQLNPWC>; Thu, 14 Dec 2000 10:22:02 -0500
Received: from main.cornernet.com ([209.98.65.1]:56589 "EHLO
	main.cornernet.com") by vger.kernel.org with ESMTP
	id <S130142AbQLNPVx>; Thu, 14 Dec 2000 10:21:53 -0500
Date: Thu, 14 Dec 2000 08:51:42 -0600 (CST)
From: Chad Schwartz <cwslist@main.cornernet.com>
To: Igmar Palsenberg <maillist@chello.nl>
cc: Mark Orr <markorr@intersurf.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Dropping chars on 16550
In-Reply-To: <Pine.LNX.4.21.0012141529580.2159-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.4.30.0012140833520.14206-100000@main.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is where a 654 or an 854 (I'm only listing startech design chips.
> > there are others that would do the job.)  come in handy. They can pause
> > their transmitter WITH bytes in their fifo. (Automated hardware/software
> > flow control.)
>
> Indeed. Most chips I've seen are 1 16550, or pretend to be. Probably an
> issue of cost (At least, I think :))

Yeah. most of this crap is manufactured as all-in-1 chips. (IDE, FDC, SER,
PAR, etc.) and right along with that, you get 2 16550AFN's. Now. they
hyped the heck out of 16550's when they came out, because "You can use
your 28.8kbps modem without overruns!". Yeah. clocking it at 38400 or
57600 on a system doing NOTHING ELSE BUT SERIAL.

For a little extra cost - approx. $2.50 (this number could skew a bit,
depending on in what quantity they buy), they could put 16652's in there.

Not much support for it on an enduser system yet (our serial.c does, but
the MS folks dont support 'em in their generic driver, I dont think) so I
think this has some weight in why it doesn't become defacto standard,
either.

> Well.. Why is the i386 the defacto standard ? There architectures that are
> a lot better. Reason it is that the some big company used it, and it got
> populair.

Heh. Well, serial doesn't even have anything to do with architecture. As
long as the machine supports addressable I/O, its capable of running a
UART.

And what kind of serial ports do you find on your Alpha?  16550's!  Your
PowerPC?  16550's!  Your PA-RISC box? 16550's!  Hey! Even RS/6000's use
16550's!

So while i concur with your statement,  it still doesn't explain why the
business hasn't chosen to move on yet.

NOTE: The same can also be stated about FLOPPY DRIVES.  Why on EARTH would
we want 1.44mb media - on a drive that costs $15, and media that costs
$.10/ea - when there are things like Zipdrives, where you can get
100mb internal drives for $50, and media for $4? (Thats what FLOPPY DRIVES
used to cost!!  $60 for the drive, $1-2/ea for the media.)

> Indeed.. Why do they save $15 bucks on a modem chipset, and replace it
> with a buggy software driven solution... Making things as cheap as
> possible, to make sure the're chaper then their compatitor.

Good point.  But in this particular model, it obviously explains why
electronics technology expands in the particular way that it does.

In the year 1970, everyone thought that we'd have transporter beams and
spaceships and computers named Hal in the year 2000.  What do we *REALLY*
have?  Technology that makes things more CONVENIENT for people.  They also
CATER to people who don't want to spend any money.

Celphones. Pagers. Microwaves.

Hey. we even have Web-based grocery delivery guys that
arrive in pretty vans. and all you had to do was click!

Our computers use parts that were designed 10 years previous, because
nobody wants to spend the money on newer and better stuff.

Chad


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
