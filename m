Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131520AbRBQM6w>; Sat, 17 Feb 2001 07:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbRBQM6K>; Sat, 17 Feb 2001 07:58:10 -0500
Received: from limes.hometree.net ([194.231.17.49]:47912 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S131442AbRBQM54>; Sat, 17 Feb 2001 07:57:56 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 17 Feb 2001 12:37:50 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <96lrau$dcd$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <5.0.0.25.0.20010216170349.01efc030@mail.etinc.com>, <E14TtEx-0004Lr-00@the-village.bc.nu>
Reply-To: hps@tanstaafl.de
Subject: [LONG RANT] Re: Linux stifles innovation...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:

>> For example, if there were six different companies that marketed ethernet 
>> drivers for the eepro100, you'd have a choice of which one to buy..perhaps 
>> with different "features" that were of value to you. Instead, you have 
>> crappy GPL code that locks up under load, and its not worth spending 

>Umm I find the driver very reliable. And actually I have choice of two
>eepro100 drivers eepro100.c and e100.c so you cant even pick an example.

>Of course your keenness to let people write alternative free drivers for
>your etinc pci card is extremely well known. Fortunately despite your best
>efforts there is now a choice in 2.4

Alan,

the point was (IMHO): "I don't want to compile, check and test". And
yes, this is the point of most commercial companies who want to _use_
an OS and not to develop it. They want to _buy_ a distribution and use
it.  And if it does not work, they want support.

This is fully possible today. Companies that do this kind of business
are all around (Starting with RH, SuSE and Caldera, down to small,
vertical market consulting companies like mine. ;-) )

_BUT_ all these people that want to use Linux ask sometimes for help
outside their vendor contracts, they get told exactly this: "Go away
where. You're not using the "one true source from kernel.org". They're
more locked it with their "open software" than people that use
windows. Because if they ask for help in a M$ support forum, they get
help. Sometimes (most of the times) they have to pay for it but
they're willing to pay. That's the point. They're willing to pay for
help and they don't want to hear "fuck off and get xxx Linux instead
of yyy Linux". Or "fuck off and use zmailer, only idiots still use
sendmail". 

Or "Recompile your kernel. Check out kernel v2.3.99pre7-ac8 with the
latest patch from Andrea Arcangeli" (And most of the times they as
themselves, who is this Andrea-gal anyway? ;-) (SCNR))"

If someone comes to a "free software" group and is even proposing
<other unix> - Linux heterogenous environments or (gods beware)
Windows <-> Linux environments, they're flamed down with the wrath of
god by the self-appointed "Free Software Advocats" and part time
CS-hackers. "Use open source" may be even the most friendly answer
that you get. 

Look at the ECN discussion. Look at the NFS discussion. Look at the IP
fragmentation discussion. Most non-technical people don't want to hear
"you can't connect from your company proxy to hotmail because they're
braindead with their firewalls and don't wanna listen". They hear this
once, they hear this twice, they fire their consultant and get M$
Proxy Server. At least they can now _sometimes_ connect to Hotmail (if
the proxy is not down. ;-) )

I mean, look: This is a "community" where people fight over
distributions of _one_ operation system like over the way to
salvation.  Look at the "comments" about the RH shipped compiler or
the SuSE / RH patched kernels. I can quote you mails that I got about
"RedHat lusers" just because people use the shipped stuff. This is
"community"?

And what did we get? Face it:

The state of the drivers in the linux kernel is abysmal. How many of
the drivers are really vendor-supported? Some vendors got flamed for
giving parts of their code or even their whole driver code away
instead of being helped by the community (Intel, Lucent, to name a
few).

And if a company takes a bold step and releases the source to one of
their core products (Netscape), what happens? Open Source developers
run away once they realize, _how_ complex planned and engineered (and
unfortunately grown) multiplatform source really is. 

I would think, only a very small percentage of the so open source
developers has yet seen a product (Yes, a single system. Not a
collection of lots of small programs like a Linux distribution) with
more than 1 GByte Source code in four different languages (with by the
way controls real world hardware like nuclear power stations) and had
to maintain such code. How much source is the linux kernel if you
subtract the drivers and take only one architecture. 5 MBytes? 10?
We're talking an order of magnitudes bigger here.

Take printing and font rendering (which is one of my most favourite
pet peeves because here, Linux is _so far_ behind Windows that it
doesn't even start to see their tail lights in the distance):

The state of driver for printing or font rendering on the desktop is
terrible. You may rant about M$ all the time, but if I buy a new
printer, I get a driver which produces printouts like on my screen and
like my last printer. I get all the nifty features supported that this
printer has.

Why are there no driver for all this stuff for Linux? I'm sure,
companies would love to hire people to write these drivers. 

Answer (IMHO):

Programmer that can do so is tangled in the "it must be open, free,
GPL" idea. Company wants to make at least some bucks with their
products and the driver is part of the product. So they may want to
release a driver which is "closed source". Uh. I can see the flame
wars in the newsgroups "stay away from brand XX, they're publishing
evil closed source drivers". Better buy brand YY, they have no drivers
at all but you can use Ghostscript to get an inferior and worse
looking printout but have the warm feeling of "all open source".

You can be sure, that Company XX will not repeat their "drivers for
Linux" experiment with such media exposure.

The Linux community must grow. It must grow soon and it must grow
mature. People, even the most narrow minded open source advocates must
accept, that there are people out there, that happliy use
"proprietary", "closed source" and "open source" all along. Yes, you
have to obey the licenses. Yes, you have to point mistakes in
licensing and incompatible licensing out to companies, that make
mistakes. But at least I would be happy if there would be a printing
engine that is entirely open source and all the printer vendors can
write a small, closed source stub that drives their printer over
parallel port, ethernet or USB and give us all the features, that the
Linux _USERS_ (and these are the people that count) want. But even if
there is such an engine written for Gnome or KDE, some really
ingenious "free software advocate" will slap a "must not be used with
any kind of non-GPL driver" on it and all the printer vendors will
give you the finger.

And Billg is the one that wins.

The whole Linux community is using closed-source/open-source all along
for years: Netscape. Star Office. To name a few. Why is it so hard to
accept, that at least some people or companies are willing to offer
support for their products but not with their source? I charge these
companies for my support but I have no problem with their tools. I
even buy them (and get ripped off like with Cygnus Source Navigator :-( ).

And if you really read till here: No, I'm not an M$ advocate. I use M$
products for four things: Word, Excel, Powerpoint and my finance
software. I have to use M$ because there are no alternatives for Linux
that are acceptable in a professional, cross-company environment. If I
tell a customer "I can't open that document in Star Writer", they
start laughing.

But I spent some of my earlier years in a community which was soooo
much like the Linux community today: The Amiga environment. And it saw
it wither and die just because of this kind of in-fighting which
programming language to use to write the Word-Killer (C or Modula)
instead of _WRITING_ the Word-Killer.

I'm using Linux since seven years now. I don't want to lose it. But
then again, Linux must grow. I'm too old to switch to Windows now. ;-)

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
