Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbRFYTI5>; Mon, 25 Jun 2001 15:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264303AbRFYTIr>; Mon, 25 Jun 2001 15:08:47 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:57613 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265786AbRFYTIe>; Mon, 25 Jun 2001 15:08:34 -0400
Date: 25 Jun 2001 21:23:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
cc: penguicon-comphist@lists.sourceforge.net
Message-ID: <83WVxfbXw-B@khms.westfalen.de>
In-Reply-To: <01062310075401.00696@localhost.localdomain>
Subject: Re: Microsoft and Xenix.
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E15DZbq-0008D8-00@roo.home> <E15DZbq-0008D8-00@roo.home> <01062310075401.00696@localhost.localdomain>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

landley@webofficenow.com (Rob Landley)  wrote on 23.06.01 in <01062310075401.00696@localhost.localdomain>:

> on April 2, 1987.  (models 50, 60, and 80.)  The SAA/SNA push also extended
> through the System/370 and AS400 stuff too.  (I think 370's the mainframe
> and AS400 is the minicomputer, but I'd have to look it up.  One of them
> (AS400?) had a database built into the OS.  Interestingly, this is where SQL
> originated (my notes say SQL came from the System/370 but I have to
> double-check that, I thought the AS400 was the one with the built in
> database?).

The AS/400 is still going strong. It's a virtual machine based on a  
relational database (among other things), mostly programmed in COBOL (I  
think the C compiler has sizeof(void*) == 16 or something like that, so  
you can put a database position in that pointer), it doesn't know the  
difference between disk and memory (memory is *really* only a cache), and  
these days it's usually running on PowerPC hardware.

ISTR there's a gcc port for the AS/400. Oh, and it does have normal BSD  
Sockets. These days, it's often sold as a web server.

Main customer base seems to be medium large businesses and banks.

> Lotus-Intel-Microsoft Expanded Memory Specification), and "DOSShell" which
> conformed to the SAA graphical user interface guidelines.

Nope, the text user interface guidelines, a related but not the same  
beast. That's where F1 == Help is from, by the way.

In fact, the user interface part of SAA was (is?) called CUA. And many IBM  
text mode interfaces more or less follow it, including OS/400 (the os of  
the AS/400). Once upon a time, I had the specs for CUA.

> The PS/2 model 70/80 (desktop/tower versions of same thing) were IBM's first
> 386 based PC boxes, which came with either DOS 3.3, DOS 4.0, OS/2 (1.0), or
> AIX.

The first 386 PCs where not from IBM, by the way. Was it Compaq?

> AIX was NOT fully SAA/SNA compliant,

AFAICT, nothing ever was fully SAA compliant, though some systems were  
more compliant than others.

> Hmmm...  Notes on the history of shareware (pc-write/bob wallace/quiicksoft,
> pc-file/pc-calc/jim button/buttonware, pc-talk/andrew flugelman, apparently
> the chronological order is andrew-jim-bob, and bob came up with the name
> "shareware" because "freeware" was a trademark of Headlands Press, Inc...)

That may be, but I believe the *concept* was invented in 1980 by Bill  
Basham, with the Apple ][ DOS replacement Diversi-DOS (which was the most  
popular of many versions to increase disk speed by about a factor of 5). I  
still remember discussions how copying this stuff was actually the right  
thing to do. Seems he's still in business as "Diversified Software  
Research", http://www.divtune.com/.

> running AIX.  The engineers (in Austin) whent on for the second generation
> Risc System 6000 (the RS/6000) with AIX version 3, launched February 15
> 1990. The acronym "POWER" stands for Performance Optimized WIth Enhanced
> Risc.

The PowerPC was split off from the POWER architecture, and then the POWER  
stuff was turned into the high end above PowerPC (with system prices about  
a factor of ten higher as the lower bound).

IBM developed a version of OS/2 2.0 for the PowerPC, but *never* marketed  
it - you could buy it if you knew the right number, but they never spent a  
single cent on advertizing - by the time it was done, IBM had given up on  
OS/2. Most OS/2 fans agreed that it was killed by IBM with extremely bad  
marketing.

These days, of course Apple builds the most PowerPC machines; Motorola and  
IBM produce the chips.

> Ummm...  GEM was the Geos stuff?

No. GEM, I believe, originally came from CP/M. Most popular as the  
windowing system of the Atari ST; given that someone did a quick-hack MS- 
DOS clone to support it on the 68K, it seems fairly obvious that by that  
time, it had already been ported to MS-DOS. (GEM-DOS is the only os I know  
of that was actually worse than MS-DOS.)

Friends of mine (Gereon Steffens and Stefan Eissing) wrote a command-line  
shell and desktop replacement for the Atari that was fairly successful  
shareware for a while ... now how was it called? The CLI was Mupfel  
(German for shell is Muschel, and there was a kid's TV character who  
pronounced Muschel as Mupfel), and I think the desktop was Gemini. Another  
(Julian Reschke) wrote *the* German Atari ST book. This was a fairly  
prominent Atari ST area for a while, but somehow I never had one.

> Using 3d accelerator cards to play MPEG video streams is only now becoming
> feasable to do under X.  And it SHOULD be possible to do that through a
> 100baseT network, let alone gigabit, but the layering's all wrong...)

One might say it's time for X12, except the installed base of X11 has  
become too large.

MfG Kai
