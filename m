Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbRFZUSO>; Tue, 26 Jun 2001 16:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263031AbRFZUR4>; Tue, 26 Jun 2001 16:17:56 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:20353 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264738AbRFZURe>; Tue, 26 Jun 2001 16:17:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
Subject: Re: Microsoft and Xenix.
Date: Tue, 26 Jun 2001 11:16:27 -0400
X-Mailer: KMail [version 1.2]
Cc: penguicon-comphist@lists.sourceforge.net
In-Reply-To: <E15DZbq-0008D8-00@roo.home> <01062310075401.00696@localhost.localdomain> <83WVxfbXw-B@khms.westfalen.de>
In-Reply-To: <83WVxfbXw-B@khms.westfalen.de>
MIME-Version: 1.0
Message-Id: <01062611162702.12583@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 June 2001 15:23, Kai Henningsen wrote:

> The AS/400 is still going strong. It's a virtual machine based on a
> relational database (among other things), mostly programmed in COBOL (I
> think the C compiler has sizeof(void*) == 16 or something like that, so
> you can put a database position in that pointer), it doesn't know the
> difference between disk and memory (memory is *really* only a cache), and
> these days it's usually running on PowerPC hardware.
>
> ISTR there's a gcc port for the AS/400. Oh, and it does have normal BSD
> Sockets. These days, it's often sold as a web server.
>
> Main customer base seems to be medium large businesses and banks.

The AS400 seems to be based out of Austin.  We hear a lot about it around 
here...

> > Lotus-Intel-Microsoft Expanded Memory Specification), and "DOSShell"
> > which conformed to the SAA graphical user interface guidelines.
>
> Nope, the text user interface guidelines, a related but not the same
> beast. That's where F1 == Help is from, by the way.

Same overall push.  I think the distinction there is a bit nit-picking to put 
in the book, but I'll have to look it up to make sure...

> In fact, the user interface part of SAA was (is?) called CUA. And many IBM
> text mode interfaces more or less follow it, including OS/400 (the os of
> the AS/400). Once upon a time, I had the specs for CUA.

When I worked at IBM I had to program for CUA.  Ouch.  Painful memories...

How did any of this related to the "Common Desktop Environment", by the way?

> > The PS/2 model 70/80 (desktop/tower versions of same thing) were IBM's
> > first 386 based PC boxes, which came with either DOS 3.3, DOS 4.0, OS/2
> > (1.0), or AIX.
>
> The first 386 PCs where not from IBM, by the way. Was it Compaq?

It was compaq.  The "Desqpro" or some such.  That was actually an important 
turning point, Compaq basically stuck a 32 bit processor in a machine that 
was otherwise designed for a 16 bit one.  It had a 16 bit ISA bus, 8 bit 30 
pin simms that had been paired off now needed to be used in groups of 4...  
It was a painful hack from a hardware perspective.

IBM was busy trying to upgrade the memory system and bus and stuff to be a 
better platform for the 386, but the waited to long and compaq just came out 
with "a quick hack now", and everybody else started copying compaq 
(especially when IBM's alternative was patented and thus not easily 
clonable...)

With the PS/2 IBM succeeded in preventing the clones from copying them.  
Their mistake was in thinking that this was a good thing.

> > AIX was NOT fully SAA/SNA compliant,
>
> AFAICT, nothing ever was fully SAA compliant, though some systems were
> more compliant than others.

Yeah, but AIX didn't even pretend to be.  And that sidelined it within IBM in 
the late 80's in a big way.  (Up until Gerster took over and overturned 
everything.)

> > Hmmm...  Notes on the history of shareware (pc-write/bob
> > wallace/quiicksoft, pc-file/pc-calc/jim button/buttonware, pc-talk/andrew
> > flugelman, apparently the chronological order is andrew-jim-bob, and bob
> > came up with the name "shareware" because "freeware" was a trademark of
> > Headlands Press, Inc...)
>
> That may be, but I believe the *concept* was invented in 1980 by Bill

The "concept" of freeware had been around as public domain software forever.  
The homebrew club thought that way naturally about micros, and the MIT 
hackers thought that way also.

If you're saying basham invented shareware...  Maybe.  I'll have to look into 
it.  I'm just tracing back the origin of the word...

> Basham, with the Apple ][ DOS replacement Diversi-DOS (which was the most
> popular of many versions to increase disk speed by about a factor of 5). I
> still remember discussions how copying this stuff was actually the right
> thing to do. Seems he's still in business as "Diversified Software
> Research", http://www.divtune.com/.

Adding link to link pile...

> > running AIX.  The engineers (in Austin) whent on for the second
> > generation Risc System 6000 (the RS/6000) with AIX version 3, launched
> > February 15 1990. The acronym "POWER" stands for Performance Optimized
> > WIth Enhanced Risc.
>
> The PowerPC was split off from the POWER architecture, and then the POWER
> stuff was turned into the high end above PowerPC (with system prices about
> a factor of ten higher as the lower bound).

Yeah, I have to research that bit still.  I know the vague bits (the 
IBM/apple/motorola hegemony to unseat Intel with risc, conceived before Intel 
came out with the Pentium, of course...)

> IBM developed a version of OS/2 2.0 for the PowerPC, but *never* marketed
> it - you could buy it if you knew the right number, but they never spent a
> single cent on advertizing - by the time it was done, IBM had given up on
> OS/2. Most OS/2 fans agreed that it was killed by IBM with extremely bad
> marketing.

My first job out of college was working at IBM in Boca Raton florida on the 
install system for OS/2 for the power PC.  (The monster that became Feature 
Install in version 4.0 because I ported it back to Intel and cleaned it up 
until it at least ran.  It actually would have been easier to start over from 
scratch, the code base I inherited sucked to an UNBELIEVABLE degree.)

I know ALL the dirt about that project.  The CD actually had Compuserve 
Information Manager as one of the things it could install.  The whole "bonus 
pack" from 3.0 was there too.  The idea was to port the sucker to a 
microkernel ("Workplace OS") and then port that back to Intel.  Of course the 
microkernel kept changing on a weekly basis right up until the end, so no 
code on top of it was ever actually finished...  And our hardware prototypes 
changed a bit too (pineapple, etc).  And the performance of all of them just 
SUCKED compared to Intel stuff...  (We had a watcom cross-compiler that 
produced these OBSCENELY large executables...)

Don't get me started on that.

And IBM didn't give up on OS/2 until they'd done one more Intel version 
(4.0), which was unfortunately far too late to make any difference.  OS/2 for 
PPC "shipped to the shelf" (a mercy killing) at the same time IBM 
consolidated the boca site to austin texas.  (That's how I wound up in 
austin, 4 months after I arrived in boca they announced they would pay me to 
move to austin, and 4 months after THAT we did it.)

Then in Austin we did 4.0, which was kind of unpleasant because they'd 
decided on the ship schedule for it BEFORE deciding to do the site 
consolidation, and from day one we were trying to make up 4 months out of a 1 
year schedule that was pretty ambitious to begin with.  I worked my first 90 
hour week doing that.  They gave me a pager and used it between midnight and 
2 am three times in the same week.  And of course none of us were being paid 
overtime, but we were all locked in (for either 1 year or 2 years) because 
we'd have to pay back the move money otherwise (quite generous incentives, 
actually), and IBM knew it.  But a lot of people quite anyway (or took "early 
retirement" incentives, long story...)

But when the 1 year or 2 year period was up, the OS/2 development team was 
just GONE.  Bang, flush, empty parkings lot in the 900 buildings.  EVERYBODY 
left.  Most of them quit IBM.

The IBM push to Java actually started in late 1995 (during the falcon 
shutdown), and was in full swing for OS/2 4.0.  They were really trying to 
transition the OS/2 base into Java users who might not stay with OS/2 but at 
least wouldn't be locked into the Windows monopoly.  The AIX guys were doing 
the same thing, as were the AS400 and 360 guys.  IBM even produced a version 
of Java for windows 3.1, for a while.  (Because Microsoft wouldn't.)

> These days, of course Apple builds the most PowerPC machines; Motorola and
> IBM produce the chips.
>
> > Ummm...  GEM was the Geos stuff?
>
> No. GEM, I believe, originally came from CP/M. Most popular as the
> windowing system of the Atari ST; given that someone did a quick-hack MS-
> DOS clone to support it on the 68K, it seems fairly obvious that by that
> time, it had already been ported to MS-DOS. (GEM-DOS is the only os I know
> of that was actually worse than MS-DOS.)

The atari history site has a lot of info on this.  So does the CP/M museum.  
(I'll probably be putting up a links list on a web page over the next few 
days...)

> Friends of mine (Gereon Steffens and Stefan Eissing) wrote a command-line
> shell and desktop replacement for the Atari that was fairly successful
> shareware for a while ... now how was it called? The CLI was Mupfel
> (German for shell is Muschel, and there was a kid's TV character who
> pronounced Muschel as Mupfel), and I think the desktop was Gemini. Another
> (Julian Reschke) wrote *the* German Atari ST book. This was a fairly
> prominent Atari ST area for a while, but somehow I never had one.

Germany was big into the commodore 64, OS/2, the amiga, and the atari ST.  
Basically they were "anything but microsoft" even back in the 80's.  (Sheesh, 
-I- didn't start to hate Microsoft until about 1989.  Admittedly I didn't own 
my own PC until 1990.  Amiga and commodore 64 before then.  Used friends' 
PCs, though.  WWIV mods are the reason I learned C in the first place...)

> > Using 3d accelerator cards to play MPEG video streams is only now
> > becoming feasable to do under X.  And it SHOULD be possible to do that
> > through a 100baseT network, let alone gigabit, but the layering's all
> > wrong...)
>
> One might say it's time for X12, except the installed base of X11 has
> become too large.

The installed base of X11 goes through xlib, and half of it REALLY goes 
through either GTK or QT.

They're porting GTK and QT to a frame buffer.

An open-source installed base really isn't as much of a compatability 
nightmare as you'd think.  Sure you need to keep support for old APIs, but 
recompiling with "compatability" libries that translate from one APi to 
another is relatively normal and gradually porting code from one API set to 
another is a fact of life...

> MfG Kai

Rob
