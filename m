Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289317AbSAOLyS>; Tue, 15 Jan 2002 06:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289319AbSAOLyI>; Tue, 15 Jan 2002 06:54:08 -0500
Received: from oe55.law9.hotmail.com ([64.4.8.63]:19981 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S289317AbSAOLyD>;
	Tue, 15 Jan 2002 06:54:03 -0500
X-Originating-IP: [24.29.113.54]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <esr@thyrsus.com>
In-Reply-To: <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Date: Tue, 15 Jan 2002 06:53:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE553yz0UJqlG99TTOE0001578f@hotmail.com>
X-OriginalArrivalTime: 15 Jan 2002 11:53:57.0656 (UTC) FILETIME=[50689180:01C19DBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Eric S. Raymond" <esr@thyrsus.com>
To: <arjan@fenrus.demon.nl>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, January 14, 2002 2:50 PM
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
the elegant solution)


> arjan@fenrus.demon.nl <arjan@fenrus.demon.nl>:
> > Of course there are other settings that do have impact (CPU type mostly,
> > maybe memory layout) but other than that... distros already ship several
> > binary versions (last I counted Red Hat ships 11 or so with RHL72) to
> > account for CPU type and amount etc.
>
> OK.  Scenario #2:
>
> Tillie's nephew Melvin is a junior-grade geek.  He's working his way
> through college doing website administration for small businesses.  He
> doesn't know C, but he can hack his way around Perl and a little PHP,
> and he can type "configure; make".  He's been known to wear a penguin
> T-shirt.
>>> SNIP <<<
> Autoconfigure saves the day.  Possibly it even helps Melvin get laid.
> --
> <a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
>

    I see!!!  I see the light now!!!  I see it all now!!!  I have been
saved!!!  If your super doper kernel autoconfigurator goes into the kernel
source tree then all of geekdom will have a possibility of getting laid.
Marvelous.  Absolutely marvelous.  I always knew coding would be able to
overcome any kind of obstacle for us, even this one.  Horrah.  8-D

    8-D  Of course wantabe geek (if there is such a thing) Melvin could
always do it the hard way.  The experience might come in handy for the next
"internet" bubble to arise.  With the knowledge he gains he can make enough
paper money to take care of the getting laid problem once and for all (or at
least until the next crash).  Besides his current target seams way too easy
if he has a chance at her just because he entered "configure".  8-D

    Well anyway seams CML2 is becoming a literal everything and the kitchen
sink.  Wow.  8-D  So far my new kernel is going to require Python to
configure it, will include an super doper hardware detector so that it can
customize my spiffy new kernel specifically to my hardware, will include
special kernel access for regular users to be able to read my hardware
configuration because its so evil to configure my kernel as root even though
I will have to be root to install it and probably be root to untar/ungzip it
into /usr/src and not to mention removing the old /usr/src/linux, did I read
new driver model for autoconfiguring kernel somewhere too?, and the kernel
will even included a spiffy X Windows, KDE, or gnome (hey why skimp now)
program that installs itself as an icon on the user desktop (no matter what
the distribution, linux-kernel will support all) which the user can then
click on to fire up the kernel self-configuration, self-compiler,
self-installer, and auto boot loader configurator so that Aunt Tilly or the
slutty girl El Geeko has his eyes on can see a "Click here to launch new
kernel" button on their screen after their first reboot, oh and of course we
can't forget that the kernel must know that its either succeeded or failed
so that it could tell the user that and either restore the previous boot
configuration or install itself as the user's new default kernel thus
voiding the plebeian's support contract.  But no problem, I'm sure the new
kernel can take care of that too.  Just give it time.  8-D

    Hilarities aside, I wouldn't mind having a program to automatically
configure a kernel for a system via Windows-like hardware autoconfiguration.
However do have a couple of quick points.

    1. Don't see any reason for the kernel hardware autoconfigurator to be
included in the kernel.

    2. Don't see any reason the kernel hardware autoconfigurator cannot be
run as root.  Actually see one very good reason why it shouldn't be able to
be run as a regular user.  Probing certain hardware is inherently dangerous.
Machine can hang.  Hardware could be probed to death.  Heck a clever coder
could even make use of the user level access required to allow user hardware
autoconfiguration.  Wiping disks, destroying flash roms, finding system
backdoors, etc, etc.

    3. ISA is pretty much dead outside of certain standard PC equipment.
And of the remaining ISA out there, most in any machine than can still run a
Linux kernel effectively is most likely PNP ISA.  Plus there are a few
fairly common ISA cards that can also be found easily.  It seams that the
vast majority of Aunt Tillies will be served with just PCI autoconfiguration
and maybe PNP ISA configuration.
