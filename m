Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbRBESKn>; Mon, 5 Feb 2001 13:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbRBESKe>; Mon, 5 Feb 2001 13:10:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60335 "EHLO
	VL-MS-MR003.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S129041AbRBESK2>; Mon, 5 Feb 2001 13:10:28 -0500
Message-ID: <3A7EEAE1.FFE48BDB@videotron.ca>
Date: Mon, 05 Feb 2001 13:03:13 -0500
From: Martin Laberge <mlsoft@videotron.ca>
Organization: MLSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kenneth Yeung <kkyeung@expert.cc.purdue.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: digiboard support in linux
In-Reply-To: <Pine.GSO.3.96.1010205092911.25633A-100000@expert.cc.purdue.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth Yeung wrote:

> Martin,
>
>         From reading the info on Digi's site, they say that for PC/x the
> driver is already built into the kernel.  Am I still supposed to load the
> drivers up?  If so, then i'm in trouble because I don't have any drivers
> for the PC/X on Redhat.  I've been reading the install instructions from:
> http://support.digi.com/support/techsupport/unix/linux/pcx.html
>
> Thanks for your help!
> -Ken
>
> On Sat, 3 Feb 2001, Martin Laberge wrote:
>
> > Kenneth Yeung wrote:
> >
> > > Hello Martin
> > >
> > >         Thanks for the info, I'm having a little trouble getting the ports
> > > configured.  On my system, it looks like half the ports are on irq 2 and
> > > the other half are on irq 5.  and looks like they have been configured the
> > > right way?  But i can't seem to get them to run getty so that I can test
> > > the connection.
> > >
> > > Thanks!
> > > -Ken
> > >
> > > On Tue, 30 Jan 2001, Martin Laberge wrote:
> > >
> > > > Kenneth Yeung wrote:
> > > >
> > > > > Hello all
> > > > >
> > > > > Can anyone tell me where I can find infomation on digiboard support in
> > > > > linux specifically the PC/X model?
> > > > >
> > > > > THanks
> > > > > -Ken
> > > > >
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > Please read the FAQ at http://www.tux.org/lkml/
> > > >
> > > > yes i used it often in my installations and no problem with that
> > > > since 2.0.x
> > > >
> > > > 2.2.x works good too
> > > >
> > > > never tried with linux 2.4.x
> > > >
> > > >
> > > > driver is supported by digiboard itself   and by linux
> > > >
> > > > you have the choice of 2 drivers for these boards....
> > > >
> > > > i used for my part the PC/8e  PC/16e and PC/32e   In ISA versions
> > > > and never had any problems... (except figuring out how to install for the
> > > > first time)
> > > > but it is very simple if you know how to read install instructions
> > > >
> > > >
> > > > Martin Laberge
> > > > mlsoft@videotron.ca
> > > >
> > > >
> > > >
> >
> > could you send me the configuration logs and system boot messages about the
> > digiboard...
> >
> > for my part i used agetty on these ports and the board use only one interrupt
> > (exept if you have many boards...
> > in that case one interrupt by board ... )
> >
> > did you executed the DigiLoad command in your boot scripts like instructed in
> > documentations...
> > did you put the board drivers (?????.bin) in the right places...
> >
> > they have to be loaded for the board to work...
> >
> > Martin Laberge
> > mlsoft@videotron.ca
> >
> >
> >

By the way.. i Forgot...    Did you disabled the corresponding COM1 or COM2 port in
your BIOS? You should have...
The standard ports using the same interrupt should be disables by hardware... or if
on external cards, removed physically for the best...
I often had been stopped by crazy hardware conflicts... Make your life simpler...
Never put conflicting hardware in a system
this will help you a lot... Some hardware share interrupts, some hardware is reputed
to do it, but in my experience , I never be able
to sahre interrupts correctly between hardware, without serious side effects... (I
mean SERIOUS)

This is a case where theory is beaten by reality...

This is this way i designed my systems, and was very succesful with this approach...
Simple hardware, Known to work well, Not mixed with esoteric boards...
This made me choose Digiboards in my setups in the old times... (I now use
Networking... A little PC act as a terminal or Xterminal
on the local network...) this simplifies wiring , configuring, and all the management
of these little posts)

My job now consist in removing multiboards from existing installations (from 2 years
+ old) and installing PC where
we had terminals... Now users have a GUI , 10Mbps speed in place of 9600 bauds, and
internet access thru masquerading,
while continuing to use the same old text base administration software with Xterm or
telnet...

For sure you have a good reason to install digiboard with many serial ports in your
setup, but check/consider to use a more flexible setup
could be a PLUS for your applications. In my case, the price, 600$/terminal
800$/PC, was so slim i choosed to upgrade to a network
solution in most of my installations.

Hope my experiences with the case could help you...

Martin Laberge
mlsoft@videotron.ca


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
