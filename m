Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265291AbRFUXWn>; Thu, 21 Jun 2001 19:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265292AbRFUXWe>; Thu, 21 Jun 2001 19:22:34 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:12168 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S265291AbRFUXW0>; Thu, 21 Jun 2001 19:22:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "Schilling, Richard" <RSchilling@affiliatedhealth.org>, hps@intermeta.de,
        "Henning P. Schmiedehausen" <mailgate@hometree.net>,
        linux-kernel@vger.kernel.org
Subject: Re: The latest Microsoft FUD. This time from BillG, himself.
Date: Thu, 21 Jun 2001 14:21:18 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <51FCCCF0C130D211BE550008C724149E01165690@mail1.affiliatedhealth.org>
In-Reply-To: <51FCCCF0C130D211BE550008C724149E01165690@mail1.affiliatedhealth.org>
MIME-Version: 1.0
Message-Id: <01062114211800.00692@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 June 2001 17:49, Schilling, Richard wrote:
> > -----Original Message-----
> > From: Rob Landley
> > Sent: Thursday, June 21, 2001 9:25 AM
>
> [snip]
>
> > BSD forked to death in the 80's.  Everybody from AT&T to Sun
> > to IBM who saw
> > money in it spun off their own incompatable, proprietary version.
>
> Microsoft also had a UNIX variant, but they gave up on the product . .
> .forget why.

Because Paul Allen got leukemia and quit the company around 1983.

Microsoft was founded by two people: Paul Allen (the techie) and Bill Gates 
(the marketer, whose father was a lawyer.  Gates was a bit technical in the 
8-bit days, but the last piece of code he personally wrote that shipped in a 
product was the text editor for the TRS-80.)

In late '79 early '80, they heard the rumors that IBM was pondering a PC, and 
Paul Allen went "any real computer will run Unix", so they got a license from 
AT&T and ported the sucker, calling it "Xenix".  (MS was a porting house, 
they made their living porting software (mostly BASIC) from one platform to 
another in those days, and porting unix was a big thing, so as the name 
implies: they'd port it anywhere).

And then IBM dropped the PC's tech specs on them after they signed 
non-disclosure and it said "minimum 16k of ram", and they went "okay, we need 
an embedded OS".  So they sent IBM to talk to Gary Kildall at Intergalactic 
Digital Research (I.E. Kildall's living room) and get CP/M, but the meeting 
fell through famously.  But Allen knew a guy who knew a guy who had reverse 
engineered CP/M from a store bought API manual as a summer project (Quick And 
Dirty Operating System).  They got a bank loan for $50k, bought it, and 
offered it to IBM.

Remember, the original PC the floppy was optional.  Dos 1.0 was only needed 
if you got the optional floppy, the in-ROM basic (which was the real reason 
IBM was talking to MS, the rest was just gravy) had support for the casette 
tape interface built into the original PC.  That was the default interface, 
floppies were an expensive luxury.  But microsoft had conditionally licensed 
to IBM their entire rest of their software catalog (from typing tutor on up), 
conditional on having a floppy drive to load them from.  They went out and 
got their own version of CPM so their application software deal with IBM 
wouldn't fall through.

And of course IBM had two sources for everything.  (As a big evil monopoly, 
they understood that being on the receiving end, at the mercy of a monopoly 
supplier, was a bad thing.) They even made Intel license the 8086/8088 design 
to AMD so they'd have a second source.  (And that's how AMD got into the 
clone business.)  DOS 1.0 and CP/M ran EXACTLY the same software, they were 
two sources for the same thing.  At first.

Paul Allen didn't give up on Unix, of course.  He knew the PC memory would 
grow and someday would be enough to run Unix, so in he set about making a 
migration path from DOS to unix.  The dos 2.0 manuals went out and said that 
DOS would someday be replaced with Xenix, and in the meantime here's a lot of 
unix functionality to get you used to it.  He added subdirectories (using \ 
instead of / only because / was already the command line option indicator.  
"dir /s".  In 2.0 the deprecated that and changed it to "dir -s" as the 
recommended method, to be unixish.)  Plus device drivers, pipes and redirects 
(hacked onto the CP/M base as best they could), and of course file control 
blocks were replaced with file handles.  The dos 2.0 manual eventual promised 
they'd give DOS multiple process support (multitasking).

Dos 3.0 was mostly based on adding new hardware support, specifically hard 
drives since the XT was coming out.  And it's about this time (1983ish) that 
Allen got sick and took a leave of absence from microsoft which he never 
returned from.  And Microsoft's technical side fell apart, but not until 
after they shipped DOS 3.

When allen left, two things happened.  1) Gates was left with absolute power 
within Microsoft and started succumbing to it.  (He was always a greedy 
bastard, but so are steve jobs, larry ellison, the heads of commodore and 
atari, and just about everybody else in the business.  Linus has his "i'm a 
bastard" speech too...)  2) The technical side of Microsoft imploded (at the 
mercy of marketing).  Xenix was unloaded on the Santa-Cruz operation almost 
immediately, and Gates allowed microsoft to be led around by the nose by IBM 
for the next five years or so in place of any in-house technical agenda.  
(And hence OS/2 1.0)...

Did I mention I'm writing a book on all this?  (The history of linux and the 
computer industry, going back to World War II...)  This makes me the only 
person I know who's excited about finding ~50 issues of "Compute" and 
"Compute's gazette" from the mid 80's at a garage sale.  An the university of 
texas's library has been quite a help.  So have the used book stores...

Still trying to figure out a title though.  I was thinking "Penguin Uber 
Alles", or maybe "The Story of Linux".  Of course Richard Stallman didn't 
like that title at all when I drove up to MIT to interview him.  (Then again, 
he tried to get me to write a different book. :)

> In reality for all anyone knows Microsoft could have used parts of the BSD
> kernel in their products, and no one would be the wiser.

Um, they have.  Check for references to the regents of the university of 
california.  (Grep for it.)

> The license would let them do it.  That for me is the big irony behind 
> Microsoft's situation.

Microsoft has parasitically benefited from other people's innovations from 
day one.  Its first product was BASIC for the Altair, based on a decade-old 
(at the time) project out of Dartmouth College.  DOS 1.0 they bought from the 
guy who cloned it (from CP/M).  Their spreadsheet was a straight clone of 
Lotus 1-2-3, word was a mixed clone of wordperfect and other then-popular 
word processors, they bought powerpoint, their web browser was based on code 
they licensed from spyglass (violating the terms of the license, of course, 
and then settling out of court for $8 million which probably came from their 
donut budget...)  Anybody remember the stacker lawsuit?

Name one thing Microsoft actually invented.  Other than Microsoft Bob.

Open Source is just one big resource-filled wilderness to be clear-cut and 
strip-mined as far as their concerned.  The only problem is there's this 
weird kudzu-like entity coming out of the rainforest called the GPL, that 
refuses to be easily digested, and is in fact expanding back into their 
territory..

> BSD is much more stable than Windows products,

Now there's a backhanded compliment...

> and Microsoft at any time
> can snap it up and integrate it into their product base - but so far have
> chosen not to.

I wouldn't be at all suprised if they did.  It'd fit in with the history of 
NT.  (Version numbers really approximate, I don't have my notes with me.)

NT 1.0: the inherited OS/2 1.x code ported to 32 bit mode, sort of.

NT 2.0: 1.0 didn't work so let's try porting it to the mach microkernel.

NT 3.0: that didn't work either, so let's hire Dave Cutler (chief unix hater 
at Digital research and ex-head of the VAX VMS operating system) to port VMS 
on top of the steaming pile of code that is NT.

NT 3.5: punch holes in the mach microkernel to get some performance, try to 
fix some of the more obvious bugs.

NT 4.0 stabilized (a bit) because dave cutler (and the team under him) was 
still around.  They hadn't yet again changed horses in midstream.  
Eventually, with the same team working on the same code, it's bound to 
stabilize a bit.)  Bloated a bit as well, but that's proprietary software for 
you.

And then Windows 2000 (NT 5) is proof that if you throw enough money at the 
problem and put enough coats of paint over the dry rot, you can eventually 
get someting with a stiff exoskeleton where the surface layers support the 
wriggling mass of decay beneath the surface.  It's a strange way to build an 
OS, but hey, if you're willing to waste 64 megs of ram on the lower layers 
you can have tons of scar tissue loaded in there you carefully try to avoid 
actually using...

> BTW - if I'm not mistaken, a Microsoft employee has actually been at one
> time or another on the FreeBSD core team.

Somebody who works at McDonalds may actually be a master chef in their spare 
time.  Doesn't mean it has anything to do with their day job.

> > The GPL was designed to block embrace and extend.  It
> > embraces and extends
> > right back.  And it's torquing microsoft off big time.
>
> Amen.

And we thank stallman.  Now if the FSF would just get a marketing arm... 
(It's not a bad word if it gets him to translate his "Don't call it Linux" 
campaign into something that expends political capital a bit more wisely and 
gets his message across clearly when he ISN'T preaching to the choir.) 

Rob
